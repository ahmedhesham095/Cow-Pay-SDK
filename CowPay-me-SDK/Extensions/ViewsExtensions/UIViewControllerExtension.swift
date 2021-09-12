//
//  UIViewControllerExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import AVKit
import SafariServices
import UIKit

typealias ButtonCompletionBlock = (_ buttonIndex: Int) -> Void

extension UIViewController {
    func rootViewController() -> UIViewController? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController
    }

    func goToLanguageSettings() {
        let alertController = UIAlertController(title: "Title", message: "Go to Settings?", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: "App-Prefs:root=Privacy&path=PREFERRED_LANGUAGE") else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { success in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    // TODO: - share Activity View
    func shareActivityView(activityItems: [Any], excludedActivityTypes: [UIActivity.ActivityType]? = []) -> UIActivityViewController {
        // set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view // so that iPads won't crash
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = excludedActivityTypes
        // present the view controller
        return activityViewController
    }

    func goToSettings(completion: (() -> Void)?) {
        let alertController = UIAlertController(title: "Title", message: "Go to Settings?", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { _ in
                    completion?()
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func embed(_ viewController: UIViewController, inParent controller: UIViewController, inView view: UIView) {
        self.view.layoutIfNeeded()
        viewController.willMove(toParent: controller)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        controller.addChild(viewController)
        viewController.didMove(toParent: controller)
    }

    func embed(_ viewControllers: [UIViewController], inParent controller: UIViewController, inView view: UIView) {
        self.view.layoutIfNeeded()
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: CGFloat(viewControllers.count) * view.bounds.width),
        ])
        self.view.layoutIfNeeded()
        for (index, viewController) in viewControllers.enumerated() {
            viewController.willMove(toParent: controller)
            let width = view.bounds.width / 2
            viewController.view.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: view.bounds.height)
            view.addSubview(viewController.view)
            controller.addChild(viewController)
            viewController.didMove(toParent: controller)
            viewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        }
        self.view.layoutIfNeeded()
    }

    func presentFullScreen(ViewController vc: UIViewController, animated: Bool) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    func presentOverCurrentContext(viewController vc: UIViewController, animated: Bool) {
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
    }

    func pushFullScreen(ViewController vc: UIViewController, animated: Bool) {
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

    func AlertMessage(title: String, userMessage: String, complition: (() -> Void)? = nil) {
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
            complition?()
        })
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }

    func twoButtonAlert(title: String, userMessage: String, okClosure: (() -> Void)? = nil) {
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok".localized(), style: UIAlertAction.Style.default, handler: { _ in
            okClosure?()
        })
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.default, handler: { _ in
            myAlert.dismiss(animated: true, completion: nil)
        })
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }

    func openMailAlert(title: String, userMessage: String, okClosure: (() -> Void)? = nil, mailClosure: (() -> Void)? = nil) {
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok".localized(), style: UIAlertAction.Style.default, handler: { _ in
            okClosure?()
        })
        let mailAction = UIAlertAction(title: "Open Mail".localized(), style: UIAlertAction.Style.default, handler: { _ in
            mailClosure?()
            if let mailURL = URL(string: "message:") {
                if UIApplication.shared.canOpenURL(mailURL) {
                    UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
                }
            }
        })
        myAlert.addAction(okAction)
        myAlert.addAction(mailAction)
        present(myAlert, animated: true, completion: nil)
    }


    //  navigation Item Image
    func navigationItemTitleImage(image: UIImage?) {
        let titleViewImage = UIImageView(image: image)
        titleViewImage.frame = CGRect(x: 0, y: 0, width: 128, height: 38)
        titleViewImage.contentMode = .scaleAspectFit
        navigationItem.titleView = titleViewImage
    }

    func navigationItemTitle(_ title: String?) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0),
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = title
    }

    func navigationbarBackButton() {
        let backImage = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func gotToSetting(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { success in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    func estimatedLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: .infinity)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        return rectangleHeight
    }

    func openSafari(url: String) {
        if let url = URL(string: url) {
            present(SFSafariViewController(url: url), animated: true, completion: nil)
        }
    }

    func playVideo(path: String) {
        guard let url = URL(string: path) else {
            print("cannot play video")
            return
        }
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: url)
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }

    func playLocalVideo(path: String) {
        let url = URL(fileURLWithPath: path)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: url)
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }

    func alertController(withTitle title: String? = nil, message: String? = nil, alertStyle style: UIAlertController.Style = .alert, withCancelButton isCancelButton: Bool = false, cancelButtonTitle: String?, buttonsTitles: [String], completionActions completionBlock: ButtonCompletionBlock? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)

        // Buttons.
        for (index, buttonTitle) in buttonsTitles.enumerated() {
            let burronAction = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                completionBlock?(index)
            })
            alert.addAction(burronAction)
        }

        if isCancelButton {
            let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            }
            alert.addAction(cancelButton)
        }

        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Create loder view

private let spinnerTag = 101010101014510
extension UIViewController {
    func showSpinner(onView: UIView, backColor: UIColor = UIColor.black.withAlphaComponent(0)) {
        DispatchQueue.main.async {
            let spinnerView = UIView(frame: onView.bounds)
            spinnerView.backgroundColor = backColor
            //
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            blurEffectView.cornerRadius = 10
            blurEffectView.clipsToBounds = true
            blurEffectView.center = spinnerView.center
            spinnerView.addSubview(blurEffectView)
            //
            var ai = UIActivityIndicatorView()
            if #available(iOS 13, *) {
                ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            } else {
                ai = UIActivityIndicatorView(style: .whiteLarge)
            }
            ai.color = .white
            ai.startAnimating()
            ai.center = spinnerView.center

            spinnerView.addSubview(ai)
            spinnerView.tag = spinnerTag
            if onView.viewWithTag(spinnerTag) == nil {
                onView.addSubview(spinnerView)
            }
            onView.isUserInteractionEnabled = false
        }
    }

    func removeSpinner(fromView: UIView) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            var loader: UIView? = fromView.viewWithTag(spinnerTag)
            UIView.animate(withDuration: 0.2, animations: {
                loader?.alpha = 0
            }, completion: { _ in
                fromView.isUserInteractionEnabled = true
                loader?.removeFromSuperview()
                loader = nil
            })
        }
    }
}

extension UIViewController {
    func playVideo(videoLink: String) {
        DispatchQueue.main.async {
            let videoURL = URL(string: videoLink)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(playerViewController, animated: true) {
                    playerViewController.player?.play()
                }
            }
        }
    }
}

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "FirstLaunchFlag"
        
        if !standard.bool(forKey: firstLaunchFlag) {
            standard.set(true, forKey: firstLaunchFlag)
            return true
        }
        return false
    }
}
