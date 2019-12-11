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
                    Text("\(model.nameEN)")
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Fav")
                }
                Button(action: {
                    
                }) {
                    Text("Panel")
                }
                Button(action: {
                    
                }) {
                    Text("Web")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
