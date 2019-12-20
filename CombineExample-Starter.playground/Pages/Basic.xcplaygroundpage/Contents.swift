import Combine

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
