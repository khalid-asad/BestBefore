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
        .item(name: "Broccoli", dateAdded: "2019-10-20", expiryDate: "2019-10-27", image: nil),
        .item(name: "Spinach", dateAdded: "2019-10-20", expiryDate: "2019-10-27", image: nil),
        .item(name: "Cheese", dateAdded: "2019-10-20", expiryDate: "2019-11-20", image: nil),
        .item(name: "Onion", dateAdded: "2019-10-20", expiryDate: "2019-11-04", image: nil),
        .item(name: "Garlic", dateAdded: "2019-10-20", expiryDate: "2019-11-15", image: nil),
        .item(name: "Add More", dateAdded: "", expiryDate: "", image: nil)
    ]
    
    var stackableItems: [ItemModel.StackableItems] {
        return stackableItem
    }
    
    public enum StackableItems {
        case item(name: String, dateAdded: String, expiryDate: String, image: UIImage?)
    }
    
    public func addItem(name: String, dateAdded: String, expiryDate: String, image: UIImage?) {
        stackableItem[stackableItem.count-1] = .item(name: name, dateAdded: dateAdded, expiryDate: expiryDate, image: image)
        stackableItem.append(.item(name: "Add More", dateAdded: "", expiryDate: "", image: nil))
    }
    
    public func removeItem(at row: Int) {
        stackableItem.remove(at: row)
    }
}
