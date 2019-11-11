//
//  ItemModel.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/20/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit
import PlatformCommon

final class ItemModel {
    
    private var stackableItem: [ItemModel.StackableItems] = [
        .item(name: "Broccoli", dateAdded: "2019-10-20", expiryDate: "2019-10-27"),
        .item(name: "Spinach", dateAdded: "2019-10-20", expiryDate: "2019-10-27"),
        .item(name: "Cheese", dateAdded: "2019-10-20", expiryDate: "2019-11-20"),
        .item(name: "Onion", dateAdded: "2019-10-20", expiryDate: "2019-11-04"),
        .item(name: StringKey.addMoreText.localized, dateAdded: "", expiryDate: "")
    ]
    
    var stackableItems: [ItemModel.StackableItems] {
        return stackableItem
    }
    
    public enum StackableItems: Comparable {
        case item(name: String, dateAdded: String, expiryDate: String)
        
        public static func < (lhs: ItemModel.StackableItems, rhs: ItemModel.StackableItems) -> Bool {
            var lhsExpiryDate: Date
            var rhsExpiryDate: Date
            
            switch lhs {
            case .item(_, _, let expiryDate):
                lhsExpiryDate = expiryDate.toDate ?? Date()
            }
            
            switch lhs {
            case .item(_, _, let expiryDate):
                rhsExpiryDate = expiryDate.toDate ?? Date()
            }
            
            return lhsExpiryDate < rhsExpiryDate
        }
    }
    
    public func addItem(name: String, dateAdded: String, expiryDate: String) {
        stackableItem[stackableItem.count-1] = .item(name: name, dateAdded: dateAdded, expiryDate: expiryDate)
        sortItems()
        stackableItem.append(addMoreStackableItem)
    }
    
    public func removeItem(at row: Int) {
        stackableItem.remove(at: row)
    }
}

// MARK: - Network Requests
extension ItemModel {
    
    func fetchData(completion: @escaping ((FetchInfoState) -> Void)) {
        guard let url = URL(string: StringKey.baseURL.localized + StringKey.itemJSONPath.localized) else { return }
        NetworkRequest.fetchData([ItemInfo].self, for: url, completionHandler: { [weak self] (data, error) in
            if let error = error {
                print("Error: ")
                print(error)
                completion(.failure)
                return
            }
            
            guard let self = self, let data = data else {
                print("Error getting data: result is nil")
                completion(.failure)
                return
            }
            
            dump(data)
                        
            self.stackableItem = data
                .sorted { $0 < $1 }
                .compactMap() { .item(name: $0.name, dateAdded: $0.dateAdded, expiryDate: $0.expiryDate) }
            self.stackableItem.append(self.addMoreStackableItem)
            
            completion(.success)
        })
    }
}

// MARK: - Computed Properties
extension ItemModel {
    
    func isExpired(item: StackableItems) -> Bool {
        switch item {
        case .item(_, _, let expiryDate):
            guard let expiryDate = expiryDate.toDate,
                let differenceInDays = expiryDate.differenceInDaysFromToday,
                differenceInDays > 0 else { return true }
            return false
        }
    }
}

// MARK: - Private Methods
extension ItemModel {
    
    private var addMoreStackableItem: ItemModel.StackableItems {
        return .item(name: StringKey.addMoreText.localized, dateAdded: "", expiryDate: "")
    }
    
    private func sortItems() {
        stackableItem = stackableItem.sorted { $0 < $1 }
    }
}
