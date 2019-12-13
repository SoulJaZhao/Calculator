//
//  SettingRootView.swift
//  PokeMaster
//
//  Created by SoulJa on 2019/12/13.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
         SettingView().navigationBarTitle("设置")
        }
        
    }
}

struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
