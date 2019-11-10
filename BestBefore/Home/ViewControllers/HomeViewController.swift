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
        
        title = Localization.itemsTabTitle.rawValue
        
        model = ItemModel()
        
        setupTableView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(model.stackableItems[indexPath.row])")
        
        if indexPath.row == model.stackableItems.count-1 {
            presentItemAdditionScreen(completion: { [unowned self] (title, expiry) in
                guard let title = title,
                    let expiry = expiry,
                    let expiryDate = expiry.toDate,
                    let differenceInDays = expiryDate.differenceInDaysFromToday,
                    differenceInDays > 0
                else {
                    print(Localization.error.rawValue + Localization.invalidExpiryTitle.rawValue)
                    self.showErrorMessage(
                        title: Localization.invalidExpiryTitle.rawValue,
                        message: Localization.invalidExpiryMessage.rawValue
                    )
                    tableView.deselectRow(at: indexPath, animated: true)
                    return
                }
                self.append(title: title, expiry: expiry, to: tableView)
            })
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
            cell.itemImage.backgroundColor = generateExpiryDateColor(from: dateAdded)
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
    
    private func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 32.0, height: 0)).height
    }
    
    private func setupTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        tableView.register(ItemTableViewCell.classForCoder(), forCellReuseIdentifier: "MyCell")
        
        let headerView = Component(frame: .zero)
        headerView.configure(text: Localization.itemsTabTitle.rawValue)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.backgroundColor = .white
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
    
    private func presentItemAdditionScreen(completion: @escaping (String?, String?) -> Void) {
        showInputDialog(
            title: Localization.addItemTitle.rawValue,
            subtitle: Localization.addItemSubtitle.rawValue,
            actionTitle: Localization.addItemActionTitle.rawValue,
            cancelTitle: Localization.addItemCancelTitle.rawValue,
            textField1PlaceHolder: Localization.addItemTextFieldPlaceholder1.rawValue,
            textField2PlaceHolder: Localization.addItemTextFieldPlaceholder2.rawValue) { (title: String?, expiry: String?) in
                if let title = title, title != "", let expiry = expiry, expiry != "" {
                    completion(title, expiry)
                    return
                }
                completion(nil, nil)
                return
        }
    }
    
    private func append(title: String, expiry: String, to tableView: UITableView) {
        let dateAdded = Date().currentDateString
        
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
    
    private func generateExpiryDateColor(from expiryDate: String) -> UIColor {
        if let expiryDateFormatted = expiryDate.toDate,
            let diffInDays = expiryDateFormatted.differenceInDaysFromToday {
            if diffInDays >= 14 {
                return .green
            } else if diffInDays >= 7 {
                return .orange
            } else {
                return .red
            }
        }
        return .blue
    }
}
