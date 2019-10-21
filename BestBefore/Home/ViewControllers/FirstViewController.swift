//
//  FirstViewController.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/16/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var model: ItemModel!
    private var myArray: [String] = ["First", "Second", "Third", "Add More"]
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
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.stackableItems.count
    }
    
    // TODO - Change colours based on expiry date
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! ItemTableViewCell
        switch model.stackableItems[indexPath.row] {
        case .item(let name, let expiryDate, let dateAdded, let image):
            cell.itemName.text = name
            cell.expiryDate.text = expiryDate
            cell.dateAdded.text = dateAdded
            cell.itemImage.image = image
        }
        return cell
    }
}

// MARK: - Private Methods
extension FirstViewController {
    
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
        
        model.addItem(name: title, dateAdded: dateAdded, expiryDate: expiry, image: nil)
        
        let cell = tableView.cellForRow(at: IndexPath(row: model.stackableItems.count-1, section: 0)) as? ItemTableViewCell
        cell?.itemName.text = title
        cell?.expiryDate.text = expiry
        cell?.dateAdded.text = dateAdded
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: model.stackableItems.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        reloadData()
    }
}

// MARK: - Header
class CustomTableViewHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
