//
//  UINavigationBarAppearance+Extensions.swift
//  BestBefore
//
//  Created by Khalid Asad on 11/10/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
extension UINavigationBarAppearance {
    
    func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.backgroundColor = .white
        let transparentAppearance = navBarAppearance.copy()
        transparentAppearance.configureWithTransparentBackground()
        
//        navigationItem.searchController = searchController
//        searchController.navigationItem.scrollEdgeAppearance = transparentAppearance
    }
}
