//
//  UIViewController.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//
import UIKit
import Photos

extension UIViewController {

    static func loadFromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
    
    func setLeftBarButton(style: SKBarButtonItem.BarButtonStyle, handler: ((SKBarButtonItem) -> Void)?) {
        let barButton = SKBarButtonItem(style: style, actionHandler: handler)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
    }

    func setRightBarButton(style: SKBarButtonItem.BarButtonStyle, handler: ((SKBarButtonItem) -> Void)?) {
        let barButton = SKBarButtonItem(style: style, actionHandler: handler)
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    func onHandleUserLogout() {
//        self.setClearDataLogout()
//        SocketHelperCare.share.disconnectSocket()
//        SocketHelperTimer.share.disconnectSocket()
//        //SocketHelperFitness.share.disconnectSocket()
//        SocketHelperID.share.disconnectSocket()
//
//        UIApplication.shared.keyWindow?.rootViewController = SplashRouter.setupModule()
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    func setClearDataLogout() {
        gUser = nil
        gBadgeCare = 0
//        gListCartProduct.removeAll()
        
        KeyChainManager.shared.accessToken = nil
        SKUserDefaults.shared.removeObject()
        SKUserDefaults.shared.numberOfUnreadNotification = 0
//        FileHelper.shared.setRemoveDirectory(path: "/workout")
//        FileHelper.shared.setRemoveDirectory(path: "/fit/log")
//        Shared.instance.cartProductSchema = gListCartProduct
//
//        let listProfile: [ProfileRealm] = gRealm.objects()
//        listProfile.forEach { profile in
//            gRealm.remove(profile)
//        }
    }
    
    func onCallTelephone(phoneNumber: String) {
        guard phoneNumber.count > 1 else {
            SKToast.shared.showToast(content: "Không có số điện thoại")
            return
        }
        guard let url = URL(string: "tel://\(phoneNumber)") else {
            SKToast.shared.showToast(content: "Không có số điện thoại")
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func onSendSms(content: String, phoneNumber: String) {
        let sms: String = "sms:\(phoneNumber)&body=\(content)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    func onOpenLinkToSafari(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}

//MARK: Alert View
extension UIViewController {
    func alertDefault(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
//    func onShowAlertRateConsultationView(appointmentId: Int) {
//        let controller = AlertRateConsultationViewController()
//        controller.view.frame = UIScreen.main.bounds
//        controller.appointmentId = appointmentId
//        controller.showInView(self.tabBarController!, animated: true)
//    }
//
//    func onShowAlertWarningAppointment(videoCall: VideoCallModel?) {
//        switch videoCall?.meta?.code ?? 0 {
//        case 10001:
//            self.showAlertWarningJoinRoom(title: "Vui lòng chờ đến thời gian tư vấn", content: "Bạn có thể vào phòng sớm hơn 5 phút so với thời gian hẹn")
//
//        case 10002:
//            self.showAlertWarningJoinRoom(title: "Cuộc gọi tư vấn", content: "Bạn đã tham gia tư vấn online bằng thiết bị khác")
//
//        case 10004:
//            self.showAlertWarningJoinRoom(title: "Đã hết thời gian tư vấn này", content: "Bạn vui lòng đợi bác sĩ kê đơn thuốc")
//
//        default:
//            SKToast.shared.showToast(content: videoCall?.meta?.message ?? "Lỗi vào phòng\nBạn vui lòng thử lại")
//        }
//    }
//
//    func showAlertWarningJoinRoom(title: String, content: String) {
//        let controller = AlertWarningRoomViewController()
//        controller.view.frame = UIScreen.main.bounds
//        controller.alertTitle = title
//        controller.alertContent = content
//        controller.showInView(self.tabBarController!, animated: true)
//    }
//
//    func showAlertRenewTokenCallViewController(title: String, content: String, appointment: AppointmentModel?, delegate: AlertRenewTokenCallViewDelegate?) {
//        let controller = AlertRenewTokenCallViewController()
//        controller.view.frame = UIScreen.main.bounds
//        controller.delegate = delegate
//        controller.alertTitle = title
//        controller.alertContent = content
//        controller.appointment = appointment
//        controller.showInView(self.tabBarController!, animated: true)
//    }
//
    func alertOpenSettingsURLString(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Từ chối", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cài đặt", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        })
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertOpenSettingsBluetooth(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Từ chối", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cài đặt", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: "App-prefs:Bluetooth") else {
                return
            }
            UIApplication.shared.open(settingsUrl)
        })
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: animate when present
extension UIViewController {
    func presentSelectionDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }

    func dismissSelectionDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }

}

extension UIViewController {
//    func removeFromNavigationController() { navigationController?.removeController(.last) { self == $0 } }
}

// MARK: Settings Bluetooth
extension UIViewController {
    func setOpenSettingsBluetooth() {
        guard let settingsUrl = URL(string: "App-prefs:Bluetooth") else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }
}

