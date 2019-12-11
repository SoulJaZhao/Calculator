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
        PokemonInfoRow()
    }
}

struct PokemonInfoRow: View {
    let model = PokemonViewModel.sample(id: 1)
    
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
            
            HStack {
                Spacer()
                Button(action: {
                    print("fav")
                }) {
                    Image(systemName: "star")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                }
                Button(action: {
                    print("panel")
                }) {
                    Image(systemName: "chart.bar")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                }
                Button(action: {
                    print("web")
                }) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                }
            }
            .padding(.bottom, 12)
        }
        .background(Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
