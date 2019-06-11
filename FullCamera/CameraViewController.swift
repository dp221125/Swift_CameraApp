//
//  ViewController.swift
//  FullCamera
//
//  Created by Meo MacBook Pro on 11/06/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        let view = CameraView()
        view.backgroundColor = .white
        
        self.view = view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

