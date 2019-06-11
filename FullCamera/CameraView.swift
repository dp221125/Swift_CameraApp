//
//  File.swift
//  FullCamera
//
//  Created by Meo MacBook Pro on 11/06/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

class CameraView: UIView {

    let backButtonView: UIView = {
        let backButtonView = UIView()
        backButtonView.backgroundColor = .clear
        return backButtonView
    }()
    
    let shootButton: UIButton = {
        let shootButton = UIButton()
        shootButton.backgroundColor = UIColor(named: "AppleBlue")
        return shootButton
    }()
    
    func addBackButtonViewConstraint() {
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButtonView.widthAnchor.constraint(equalToConstant: 80),
            backButtonView.heightAnchor.constraint(equalTo: backButtonView.widthAnchor),
            backButtonView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -64),
            backButtonView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    func addShootButtonViewConstraint() {
        shootButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shootButton.widthAnchor.constraint(equalToConstant: 60),
            shootButton.heightAnchor.constraint(equalTo: shootButton.widthAnchor),
            shootButton.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor),
            shootButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backButtonView)
        addBackButtonViewConstraint()
        backButtonView.addSubview(shootButton)
        addShootButtonViewConstraint()
        
        backButtonView.layer.cornerRadius = 40
        shootButton.layer.cornerRadius = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
