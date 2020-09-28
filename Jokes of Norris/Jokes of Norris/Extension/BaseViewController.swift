//
//  BaseViewController.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import UIKit
import MBProgressHUD
import SwiftMessages

protocol BaseViewControllerDelegate: class {
    func viewControllerDidExit(_ viewController: UIViewController)
}

class BaseViewController: UIViewController {
    
    weak var baseDelegate: BaseViewControllerDelegate?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
            
        if self.navigationController == nil {
            self.baseDelegate?.viewControllerDidExit(self)
        }
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showProgress() {
             UIApplication.shared.beginIgnoringInteractionEvents()
             MBProgressHUD.showAdded(to: self.view, animated: true)
    }
         
    func hideProgress() {
        UIApplication.shared.endIgnoringInteractionEvents()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showSuccessMessage(_ title: String?, message: String?, duration: Float) {
        let info = MessageView.viewFromNib(layout: .cardView)
        info.configureTheme(.success)
        info.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Fechar", buttonTapHandler: { _ in SwiftMessages.hide() })
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.duration = .seconds(seconds: TimeInterval(duration))
        infoConfig.interactiveHide = true
        infoConfig.duration = .seconds(seconds: TimeInterval(duration))
        infoConfig.interactiveHide = true
        infoConfig.presentationStyle = .bottom
        SwiftMessages.show(config: infoConfig, view: info)
    }
         
    func showErrorMessage(_ title: String?, message: String?, duration: Float) {
        let info = MessageView.viewFromNib(layout: .cardView)
        info.configureTheme(.error)
        info.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Fechar", buttonTapHandler: { _ in SwiftMessages.hide() })
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.duration = .seconds(seconds: TimeInterval(duration))
        infoConfig.interactiveHide = true
        infoConfig.presentationStyle = .bottom
        SwiftMessages.show(config: infoConfig, view: info)
    }
         
    func hideMessage() {
        SwiftMessages.hide()
    }
         
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}
