//
//  ItemModel.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/20/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

final class ItemModel {
    
    // TODO - Start fetching this from the backend
    // TODO - Sort this by date of expiry
    private var stackableItem: [ItemModel.StackableItems] = [
        .item(name: "Broccoli", dateAdded: "2019-10-20", expiryDate: "2019-10-27"),
        .item(name: "Spinach", dateAdded: "2019-10-20", expiryDate: "2019-10-27"),
        .item(name: "Cheese", dateAdded: "2019-10-20", expiryDate: "2019-11-20"),
        .item(name: "Onion", dateAdded: "2019-10-20", expiryDate: "2019-11-04"),
        .item(name: "Garlic", dateAdded: "2019-10-20", expiryDate: "2019-11-15"),
        .item(name: "Add More", dateAdded: "", expiryDate: "")
    ]
    
    var stackableItems: [ItemModel.StackableItems] {
        return stackableItem
    }
    
    public enum StackableItems {
        case item(name: String, dateAdded: String, expiryDate: String)
    }
    
    public func addItem(name: String, dateAdded: String, expiryDate: String) {
        stackableItem[stackableItem.count-1] = .item(name: name, dateAdded: dateAdded, expiryDate: expiryDate)
        stackableItem.append(.item(name: "Add More", dateAdded: "", expiryDate: ""))
    }
    
    public func removeItem(at row: Int) {
        stackableItem.remove(at: row)
    }
}
