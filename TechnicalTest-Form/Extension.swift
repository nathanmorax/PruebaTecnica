//
//  Extension.swift
//  TechnicalTest-Form
//
//  Created by Xcaret Mora on 04/02/24.
//

import UIKit

extension String {
    
    func invalidEmail(_ value: String) -> String? {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: value) {
            return "Invalid E-mail"
        }
        
        return nil
    }
    
    func invalidPhoneNumber(_ value: String) -> String? {
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "Phone number must only digits"
        }
        if value.count != 10 {
            return "Phone number must be 10 digits in lenght"
        }
        
        return nil
    }
}

extension UIViewController {
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
    }
    @objc  func hideKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc  func keyBoarddWillShow(notification: NSNotification) {
        self.view.frame = CGRect(x: 0, y: -170, width: self.view.frame.width, height: self.view.frame.height)
    }
    @objc  func keyBoardWillHide() {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
    
}

