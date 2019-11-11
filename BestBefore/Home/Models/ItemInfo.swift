//
//  Item.swift
//  BestBefore
//
//  Created by Khalid Asad on 11/10/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation

struct ItemInfo: Codable, Comparable {
    var name: String
    var dateAdded: String
    var expiryDate: String
    
    static func < (lhs: ItemInfo, rhs: ItemInfo) -> Bool {
        guard let lhsExpiry = lhs.expiryDate.toDate, let rhsExpiry = rhs.expiryDate.toDate else { return false }
        return lhsExpiry < rhsExpiry
    }
}
