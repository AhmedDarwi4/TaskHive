//
//  CelebrationanimationView.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 08/09/2024.
//

import Lottie
import UIKit

class CelebrationAnimationView: UIView {
    
    var animationView: LottieAnimationView

    init(fileName: String){
        let animation = LottieAnimation.named(fileName)
        self.animationView = LottieAnimationView(animation: animation)
        super.init(frame: .zero)
        setupView()
    }
    
    func setupView(){
        addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    func play(completion: @escaping(Bool)-> Void){
        animationView.play(completion: completion)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
