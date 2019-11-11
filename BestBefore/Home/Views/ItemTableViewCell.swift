//
//  ItemTableViewCell.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/20/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Table View Cell
class ItemTableViewCell: UITableViewCell {

    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    let expiryDateLabel = UILabel()
    let dateAddedLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        itemImageView.backgroundColor = .blue
        itemImageView.setRoundedCorners(radius: 3)
        
        [itemImageView, itemNameLabel, expiryDateLabel, dateAddedLabel].forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        itemNameLabel.font = ThemeManager().titleFont 
        [expiryDateLabel, dateAddedLabel].forEach() {
            $0.font = ThemeManager().subTitleFont
        }
        
        let viewsDict = [
            "itemImage": itemImageView,
            "itemName": itemNameLabel,
            "expiryDate": expiryDateLabel,
            "dateAdded": dateAddedLabel,
        ]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemImage(10)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[expiryDate]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemName]-[dateAdded]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[itemName]-[itemImage(10)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dateAdded]-(>=30)-[expiryDate]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
