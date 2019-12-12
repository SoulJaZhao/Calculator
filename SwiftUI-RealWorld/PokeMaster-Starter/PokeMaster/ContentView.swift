//
//  ContentView.swift
//  PokeMaster
//
//  Created by Wang Wei on 2019/08/28.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            PokemonInfoRow(model: PokemonViewModel.sample(id: 1), expanded: false)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 21), expanded: true)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 25), expanded: false)
        }
    }
}

struct PokemonInfoRow: View {
    let model:PokemonViewModel
    @State var expanded:Bool
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: ContentMode.fit)
                    .shadow(radius: 4.0)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(model.name)")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text("\(model.nameEN)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            Spacer()
            HStack(spacing: expanded ? 20 : -30) {
                Spacer()
                Button(action: {
                    print("fav")
                }) {
                    Image(systemName: "star")
                    .modifier(ToolButtonModifier())
                }
                Button(action: {
                    print("panel")
                }) {
                    Image(systemName: "chart.bar")
                    .modifier(ToolButtonModifier())
                }
                Button(action: {
                    print("web")
                }) {
                    Image(systemName: "info.circle")
                    .modifier(ToolButtonModifier())
                }
            }
            .padding(.bottom, 12)
            .opacity(expanded ? 1.0 : 0.0)
            .frame(maxHeight: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20).stroke(model.color, lineWidth: 4.0)
                RoundedRectangle(cornerRadius: 20).fill(
                    LinearGradient(
                            gradient: Gradient(colors: [.white, model.color]),
                            startPoint: .leading,
                            endPoint: .trailing
                          )
                )
            }
        )
        .padding(.horizontal)
        .animation(
            Animation.spring(response: 0.55, dampingFraction: 0.425, blendDuration: 0.0)
        )
        .onTapGesture {
            self.expanded.toggle()
        }
    }
}

struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
