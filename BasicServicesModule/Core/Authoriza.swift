//
//  Authority.swift
//  BasicServicesModule
//
//  Created by frank.he on 2019/8/16.
//

import Foundation
import AVFoundation
import Photos
import CoreLocation

/// 相机权限
public func cameraAuthority(_ authorizeClouse: @escaping (_ state: AVAuthorizationStatus) -> ()) {
    let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    
    if status == .authorized{
        authorizeClouse(status)
    } else if status == .notDetermined {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
            if granted {  // 允许
                authorizeClouse(.authorized)
            }
        })
    } else {
        authorizeClouse(status)
    }
}

/// 保存照片权限
public func photoLibraryAuthorize(_ authorizeClouse: @escaping (PHAuthorizationStatus)->()) {
    PHPhotoLibrary.requestAuthorization({ (status) in
        if status == .authorized || status == .notDetermined {
            authorizeClouse(.authorized)
        } else {
            
            authorizeClouse(status)
        }
    })
}

/// 检测定位是否开启权限，然后跳转设置界面。
public func startAuthorizationStatus(_ viewController: UIViewController, _ callback: (() -> ())) {
    if(CLLocationManager.authorizationStatus() != .denied) {
        callback()
    }
    else {
        viewController.showAlert(title: "定位服务不可用",
                                 message: "为保障正常使用，请允许使用定位服务",
                                 buttonTitles: ["知道了", "去设置"], highlightedButtonIndex: 1) { (index) in
                                    if index == 1 {
                                        if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                                            UIApplication.shared.openURL(appSettings as URL)
                                        }
                                    }
        }
    }
}
