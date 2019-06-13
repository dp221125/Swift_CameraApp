//
//  ViewController.swift
//  FullCamera
//
//  Created by Meo MacBook Pro on 11/06/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import AVFoundation
import Photos
import UIKit

class CameraViewController: UIViewController {
    var camera: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var captureOutput: AVCapturePhotoOutput?
    var captureInput: AVCaptureDeviceInput?
    let session = AVCaptureSession()

    lazy var ownView: CameraView = {
        guard let convertView = view as? CameraView else {
            return CameraView()
        }

        return convertView
    }()

    override func loadView() {
        view = CameraView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        self.ownView.goSettingButton.addTarget(self, action: #selector(self.goSettingThisApp), for: .touchUpInside)
        self.ownView.shootButton.addTarget(self, action: #selector(self.takePicture), for: .touchUpInside)
        self.checkAuthorization()
    }

    /// 카메라 접근에 관한 권한을 확인한다.
    func checkAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.toggle(true)
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                return
            }
            self.crateCamera(device: device)

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.toggle(true)
                    guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                        return
                    }
                    self.crateCamera(device: device)
                } else {
                    self.toggle(false)
                }
            }

        case .denied:
            self.toggle(false)
        case .restricted:
            self.toggle(false)
        @unknown default: break
        }
    }

    /**
     checkAuthorization의 결과에 따라
     뷰의 아이템의 Hidden 값 과 Enable 값을 바꾼다.

     - parameters:
        - authorizationResult:
        'checkAuthorization' 결과 권한 획득에 실패하면 false를 성공하면 true를 받는다,
     */
    func toggle(_ authorizationResult: Bool) {
        DispatchQueue.main.async {
            self.ownView.notLoadLabel.isHidden = authorizationResult
            self.ownView.goSettingButton.isEnabled = !authorizationResult
            self.ownView.shootButton.isHidden = !authorizationResult
            self.ownView.shootButton.isEnabled = authorizationResult
            self.ownView.bottomView.isHidden = !authorizationResult
        }
    }

    @objc func goSettingThisApp() {
        let alert = UIAlertController(title: "설정으로 이동", message: "카메라 접근 권한을 허락하기 위해서 설정으로 가시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }

    /**
     카메라를 생성한다.

      - Parameters:
          - device: 지정된 장치 유형, 미디어 유형 및 방향에 대한 정보를 넘겨 받는다.
     */
    func crateCamera(device: AVCaptureDevice) {
        let sessionQueue = DispatchQueue(label: "Session Queue")

        sessionQueue.async {
            self.camera = device

            do {
                self.captureInput = try AVCaptureDeviceInput(device: device)
                self.captureOutput = AVCapturePhotoOutput()

                guard let captureInput = self.captureInput else {
                    return
                }

                guard let captureOutput = self.captureOutput else {
                    return
                }

                self.session.addInput(captureInput)
                self.session.addOutput(captureOutput)
            } catch {
                print(error.localizedDescription)
            }

            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill

            DispatchQueue.main.async {
                self.previewLayer?.frame.size = CGSize(width: self.ownView.bounds.width, height: self.ownView.bounds.height * 0.8)
                guard let cameraPreviewLayer = self.previewLayer else {
                    return
                }
                self.ownView.layer.insertSublayer(cameraPreviewLayer, at: 0)
            }
            self.session.startRunning()
        }
    }

    @objc func takePicture() {
        if !self.ownView.resultPhotoView.isHidden {
            self.ownView.resultPhotoView.image = nil
            self.ownView.resultPhotoView.isHidden = true
        } else {
            let settings = AVCapturePhotoSettings()
            settings.flashMode = .off
            self.captureOutput?.capturePhoto(with: settings, delegate: self)
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            if let imageData = photo.fileDataRepresentation() {
                let imgae = UIImage(data: imageData)
                ownView.resultPhotoView.isHidden = false
                self.ownView.resultPhotoView.image = imgae
            }
        }
    }
}
