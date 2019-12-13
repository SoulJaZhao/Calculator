//
//  PokemonInfoPanel.swift
//  PokeMaster
//
//  Created by SoulJa on 2019/12/13.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    let model:PokemonViewModel
    var abilities:[AbilityViewModel]? {
        AbilityViewModel.sample(pokemonID: 1)
    }
    
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6, alignment: .center)
            .opacity(0.2)
    }
    
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(model: model, abilityModels: abilities)
        }
        .padding(EdgeInsets(top: 12, leading: 30, bottom: 30, trailing: 30))
        .blurBackground(style: .systemMaterial)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
}

extension PokemonInfoPanel {
    struct Header: View {
        let model:PokemonViewModel
        
        var body: some View {
            HStack(alignment: .center, spacing: 18) {
                pokemonIcon
                nameSpecies
                verticalDivider
                 VStack(spacing: 12) {
                   bodyStatus
                   typeInfo
                 }
            }
        }
        
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
            .resizable()
                .frame(width: 68, height: 68, alignment: .center)
        }
        
        var nameSpecies: some View {
            VStack {
                Text("\(model.name)")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(model.color)
                Text("\(model.nameEN)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(model.color)
                    .padding(.bottom, 10)
                Text("\(model.genus)")
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundColor(.gray)
            }
        }
        
        var verticalDivider: some View {
            Divider()
                .frame(width: 1, height: 44, alignment: .center)
                .background(Color.init(hex: 0x000000, alpha: 0.1))
        }
        
        var bodyStatus: some View {
            VStack {
                HStack {
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text("\(model.height)")
                    .font(.system(size: 11))
                    .foregroundColor(model.color)
                }
                HStack {
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text("\(model.weight)")
                    .font(.system(size: 11))
                    .foregroundColor(model.color)
                }
            }.padding(.bottom, 12)
        }
        
        var typeInfo: some View {
            HStack() {
                ForEach(model.types) { (type) in
                    Text("\(type.name)")
                        .font(.system(size: 9))
                        .frame(width: 36, height: 14, alignment: .center)
                        .background(type.color)
                        .cornerRadius(7)
                }
            }
        }
    }
    
    struct AbilityList: View {
        let model: PokemonViewModel
        let abilityModels:[AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                if (abilityModels != nil) {
                    ForEach(abilityModels!) { (ability) in
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }.frame(minWidth: nil, idealWidth: nil, maxWidth: .infinity, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .leading)
        }
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: PokemonViewModel.sample(id: 2)
        )
    }
}
