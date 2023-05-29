//
//  CartLoading.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import SwiftUI
import Lottie

struct CartLoading: UIViewRepresentable {
    
    let animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<CartLoading>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named("cartloading")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([ animationView.heightAnchor.constraint(equalTo: view.heightAnchor), animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CartLoading>) {
        
    }
}
