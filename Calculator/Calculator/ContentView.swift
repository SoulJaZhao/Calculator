//
//  ContentView.swift
//  Calculator
//
//  Created by Zhao, Long on 2019/12/10.
//  Copyright © 2019 Zhao, Long. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 8) {
            CalculateButtonRow(row: [.command(.clear), .command(.flip), .command(.percent), .op(.divide)])
            CalculateButtonRow(row: [.digit(7), .digit(8), .digit(9), .op(.multiply)])
            CalculateButtonRow(row: [.digit(4), .digit(5), .digit(6), .op(.minus)])
            CalculateButtonRow(row: [.digit(1), .digit(2), .digit(3), .op(.plus)])
        }
    }
}

struct CalculateButtonRow: View {
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
      HStack {
        ForEach(row, id: \.self) { item in
            CalculatorButton.init(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
                print("\(item.title)")
            }
        }
      }
    }
}

struct CalculatorButton : View {

  let fontSize: CGFloat = 38
  let title: String
  let size: CGSize
  let backgroundColorName: String
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.system(size: fontSize))
        .foregroundColor(.white)
        .frame(width: size.width, height: size.height)
        .background(Color(backgroundColorName))
        .cornerRadius(size.width / 2)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
