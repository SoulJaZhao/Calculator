import Combine
import Foundation

check("Empty") {
    Empty<Int, SampleError>()
}

check("Just") {
    Just("Hello SwiftUI")
}

check("Sequence") {
    Publishers.Sequence<[Int], Never>(sequence: [1, 2, 3])
}

check("Map") {
    [1, 2, 3].publisher.map {
        $0 * 2
    }
}

check("Reduce") {
    [1, 2, 3, 4].publisher.reduce(0, +)
}

check("Catch and Continue") {
    ["1", "2", "3", "Swift", "5"].publisher.flatMap { (s) in
        Just(s).tryMap { (i) -> Int in
            guard let value = Int(i) else {
                throw SampleError.sampleError
            }
            return value
        }.catch { (error)->AnyPublisher<Any, Never> in
            Just(-1).eraseToAnyPublisher()
        }
    }
}

check("Filter") {
    [1, 2, 3, 4, 5].publisher.filter { (i) -> Bool in
        return i % 2 == 0
    }
}

check("contain") {
    [1, 2, 3, 4, 5].publisher.print("[Original]").contains(10)
}

let subject_example1 = PassthroughSubject<Int, Never>()
let subject_example2 = PassthroughSubject<Int, Never>()

check("Subject Order") {
  subject_example1.merge(with: subject_example2)
}

subject_example1.send(20)
subject_example2.send(1)
subject_example1.send(40)
subject_example1.send(60)
subject_example2.send(1)
subject_example1.send(80)
subject_example1.send(100)
subject_example1.send(completion: .finished)
subject_example2.send(completion: .finished)

struct Response: Decodable {
  struct Args: Decodable {
    let foo: String
  }
  let args: Args?
}

check("URLSession") {
    URLSession.shared.dataTaskPublisher(for: URL.init(string: "https://httpbin.org/get?foo=bar")!).map { (data, _) in
        data
    }.decode(type: Response.self, decoder: JSONDecoder.init()).compactMap {
        $0.args?.foo
    }
}

class Wrapper {
    @Published var text: String = "hoho"
}

var wrapper = Wrapper.init()

check("@Published") {
    wrapper.$text
}

wrapper.text = "123"
wrapper.text = "abc"
