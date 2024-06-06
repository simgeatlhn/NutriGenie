//
//  LottieView.swift
//  NutriGenie
//
//  Created by simge on 6.06.2024.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        
        // Animasyon dosyasını yükle
        let animation = LottieAnimation.named(filename)
        animationView.animation = animation
        
        animationView.contentMode = .scaleAspectFit
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: .loop,
                           completion: { (finished) in
            if finished {
                print("Animation Complete")
            } else {
                print("Animation cancelled")
            }
        })
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
