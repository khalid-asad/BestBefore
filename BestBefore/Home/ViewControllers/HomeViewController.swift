//
//  FirstViewController.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/16/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var model: ItemModel!
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = ItemModel()
        
        setupTableView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerID") as? CustomTableViewHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(model.stackableItems[indexPath.row])")
        
        if indexPath.row == model.stackableItems.count-1 {
            showInputDialog(title: "Add Item",
                            subtitle: "Please enter the name and expiry date of the item.",
                            actionTitle: "Add",
                            cancelTitle: "Cancel",
                            textField1PlaceHolder: "Name",
                            textField2PlaceHolder: "Expiry Date") { [unowned self] (title: String?, expiry: String?) in
                                if let title = title, title != "", let expiry = expiry, expiry != "" {
                                    self.append(title: title, expiry: expiry, to: tableView)
                                }
            }
        } else {
            switch model.stackableItems[indexPath.row] {
            case .item(let name, let expiryDate, let dateAdded):
                goToItemDetails(title: name, expiry: expiryDate, dateAdded: dateAdded)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.stackableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! ItemTableViewCell
        switch model.stackableItems[indexPath.row] {
        case .item(let name, let expiryDate, let dateAdded):
            cell.itemName.text = name
            cell.expiryDate.text = expiryDate
            cell.dateAdded.text = dateAdded
            cell.itemImage.backgroundColor = Date().generateExpiryDateColor(expiryDate: expiryDate, dateAdded: dateAdded)
        }
        return cell
    }
}

// MARK: - Private Methods
extension HomeViewController {
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        tableView.register(CustomTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "headerID")
        tableView.register(ItemTableViewCell.classForCoder(), forCellReuseIdentifier: "MyCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
    
    private func append(title: String, expiry: String, to tableView: UITableView) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateAdded = formatter.string(from: Date())
        
        model.addItem(name: title, dateAdded: dateAdded, expiryDate: expiry)
        
        let cell = tableView.cellForRow(at: IndexPath(row: model.stackableItems.count-1, section: 0)) as? ItemTableViewCell
        cell?.itemName.text = title
        cell?.expiryDate.text = expiry
        cell?.dateAdded.text = dateAdded
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: model.stackableItems.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        reloadData()
    }
    
    private func goToItemDetails(title: String, expiry: String, dateAdded: String) {
        let itemDetailsModel = ItemDetailsModel(name: title, dateAdded: dateAdded, expiryDate: expiry)
        let newViewController = ItemDetailsViewController(itemDetailsModel: itemDetailsModel)
        self.present(newViewController, animated: true, completion: {
            // TODO - Add deletion and edit behaviours to refresh stack
        })
    }
}

// MARK: - Table View Header
class CustomTableViewHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
