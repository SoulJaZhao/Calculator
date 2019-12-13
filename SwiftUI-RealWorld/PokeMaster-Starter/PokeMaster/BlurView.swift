//
//  BlurView.swift
//  PokeMaster
//
//  Created by SoulJa on 2019/12/13.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let style:UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView.init(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(blurView)
            NSLayoutConstraint.activate([
              blurView.heightAnchor
                .constraint(equalTo: view.heightAnchor),
              blurView.widthAnchor
                .constraint(equalTo: view.widthAnchor)
            ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}

extension View {
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}
