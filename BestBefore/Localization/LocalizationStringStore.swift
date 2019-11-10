//
//  LocalizationStringStore.swift
//  BestBefore
//
//  Created by Khalid Asad on 11/10/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation

public enum Localization: String {
    case error = "Error: "
    case invalidExpiryTitle = "Invalid Expiry Date!"
    case invalidExpiryMessage = "This item is already expired or has an invalid expiry date."
    case itemsTabTitle = "Items"
    case addItemTitle = "Add Item"
    case addItemSubtitle = "Please enter the name and expiry date of the item."
    case addItemActionTitle = "Add"
    case addItemCancelTitle = "Cancel"
    case addItemTextFieldPlaceholder1 = "Name"
    case addItemTextFieldPlaceholder2 = "Expiry Date"
}
