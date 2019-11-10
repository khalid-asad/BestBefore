//
//  UIViewController+Extensions.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/16/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// A modal that takes input from 2 TextFields to add an item
    func showInputDialog(title: String? = nil,
                         subtitle: String? = nil,
                         actionTitle: String? = StringKey.addActionTitle.localized,
                         cancelTitle: String? = StringKey.cancelTitle.localized,
                         textField1PlaceHolder: String,
                         textField2PlaceHolder: String? = nil,
                         inputKeyboardType: UIKeyboardType = .default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?, _ text2: String?) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = textField1PlaceHolder
            textField.keyboardType = inputKeyboardType
        }
        
        if let textField2PlaceHolder = textField2PlaceHolder {
            alert.addTextField { (textField: UITextField) in
                textField.placeholder = textField2PlaceHolder
                textField.keyboardType = inputKeyboardType
            }
        }
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action: UIAlertAction) in
            guard let textField = alert.textFields?.first else {
                actionHandler?(nil, nil)
                return
            }
            if let textField2 = alert.textFields?[1] {
                actionHandler?(textField.text, textField2.text)
            } else {
                actionHandler?(textField.text, nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /// A modal that takes input from 2 TextFields to add an item
    func showErrorMessage(title: String,
                          message: String,
                          buttonTitle: String? = "OK",
                          inputKeyboardType: UIKeyboardType = .default,
                          completion: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
