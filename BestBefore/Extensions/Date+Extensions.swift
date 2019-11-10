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
        
    /// Returns the current date as a String in yyy-MM-dd format.
    var currentDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    /// Returns the difference in date from today to the date provided in an optional Integer.
    var differenceInDaysFromToday: Int? {
        return Calendar.current.dateComponents([.day], from: Date(), to: self).day
    }
}
