//
//  Date+Extensions.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/20/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    /// Returns a color based on the number of days until an item expires
    func generateExpiryDateColor(expiryDate: String, dateAdded: String) -> UIColor {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let expiryDateFormatted = formatter.date(from: expiryDate),
            let dateAddedFormatted = formatter.date(from: dateAdded),
            let diffInDays = Calendar.current.dateComponents([.day], from: dateAddedFormatted, to: expiryDateFormatted).day {
            if abs(diffInDays) >= 14 {
                return .green
            } else if abs(diffInDays) >= 7 {
                return .orange
            } else {
                return .red
            }
        }
        return .blue
    }
}
