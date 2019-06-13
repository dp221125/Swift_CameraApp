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
        backButtonView.backgroundColor = .white
        backButtonView.layer.borderColor = UIColor.black.cgColor
        backButtonView.layer.borderWidth = 1.0
        return backButtonView
    }()

    let shootButton: UIButton = {
        let shootButton = UIButton()
        shootButton.backgroundColor = UIColor(named: "LightGreyGreen")
        return shootButton
    }()

    let notLoadLabel: UILabel = {
        let notLoadLabel = UILabel()
        notLoadLabel.text = "카메라에 접근할 수 없음"
        notLoadLabel.baselineAdjustment = .alignCenters
        notLoadLabel.font = UIFont.boldSystemFont(ofSize: 26)
        notLoadLabel.adjustsFontSizeToFitWidth = true
        notLoadLabel.isHidden = true
        return notLoadLabel
    }()

    let goSettingButton: UIButton = {
        let goSettingButton = UIButton()
        goSettingButton.isEnabled = false
        return goSettingButton
    }()

    let bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(named: "Pale")
        return bottomView
    }()

    let resultPhotoView: UIImageView = {
        let resultPhotoView = UIImageView()
        resultPhotoView.contentMode = UIView.ContentMode.scaleAspectFill
        resultPhotoView.clipsToBounds = true
        resultPhotoView.isHidden = true
        return resultPhotoView
    }()

    func addBottomViewConstraint() {
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            bottomView.widthAnchor.constraint(equalTo: widthAnchor),
            bottomView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func addBackButtonViewConstraint() {
        self.backButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButtonView.widthAnchor.constraint(equalToConstant: 80),
            backButtonView.heightAnchor.constraint(equalTo: backButtonView.widthAnchor),
            backButtonView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            backButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    func addShootButtonViewConstraint() {
        self.shootButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shootButton.widthAnchor.constraint(equalToConstant: 60),
            shootButton.heightAnchor.constraint(equalTo: shootButton.widthAnchor),
            shootButton.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor),
            shootButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    func addNotLoadLabelConstraint() {
        self.notLoadLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notLoadLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            notLoadLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func addGoSettingButtonConstraint() {
        self.goSettingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goSettingButton.widthAnchor.constraint(equalTo: notLoadLabel.widthAnchor),
            goSettingButton.heightAnchor.constraint(equalTo: notLoadLabel.heightAnchor),
            goSettingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            goSettingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func addResultPhotoViewConstraint() {
        self.resultPhotoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultPhotoView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            resultPhotoView.widthAnchor.constraint(equalTo: widthAnchor),
            resultPhotoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultPhotoView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }

    func addViewItem() {
        addSubview(self.bottomView)
        self.bottomView.addSubview(self.backButtonView)
        self.backButtonView.addSubview(self.shootButton)
        addSubview(self.notLoadLabel)
        addSubview(self.goSettingButton)
        addSubview(self.resultPhotoView)
    }

    func addViewItemConstraint() {
        self.addBottomViewConstraint()
        self.addBackButtonViewConstraint()
        self.addShootButtonViewConstraint()
        self.addNotLoadLabelConstraint()
        self.addGoSettingButtonConstraint()
        self.addResultPhotoViewConstraint()
    }

    func makeButtonLayer() {
        self.backButtonView.layer.cornerRadius = 40
        self.shootButton.layer.cornerRadius = 30
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addViewItem()
        self.addViewItemConstraint()
        self.makeButtonLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
