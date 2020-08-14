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
    
    @available(iOS 13, *)
    func customizeNavigationBar() {
//        navigationItem.setLeftBarButton(.init(barButtonSystemItem: .cancel, target: nil, action: nil), animated: true)
//        navigationItem.setRightBarButton(.init(barButtonSystemItem: .done, target: nil, action: nil), animated: true)

//        navigationItem.searchController = searchController

        let navBarAppearance = UINavigationBarAppearance()

        // Call this first otherwise it will override your customizations
        navBarAppearance.configureWithDefaultBackground()

        let buttonAppearance = UIBarButtonItemAppearance()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        buttonAppearance.normal.titleTextAttributes = titleTextAttributes

        navBarAppearance.titleTextAttributes = [
            .foregroundColor : UIColor.black, // Navigation bar title color
            .font : ThemeManager().headerFont // Navigation bar title font
        ]

        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor : UIColor.black, // Navigation bar title color
        ]

        // appearance.backgroundColor = UIColor.systemGray // Navigation bar bg color
        // appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8) // Only works on non large title

        let transNavBarAppearance = navBarAppearance.copy()
        transNavBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = transNavBarAppearance

//        searchController.navigationItem.standardAppearance = navBarAppearance
//        searchController.navigationItem.compactAppearance = navBarAppearance
//        searchController.navigationItem.scrollEdgeAppearance = transNavBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = true // Activate large title
    }
}
