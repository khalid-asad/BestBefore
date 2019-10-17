//
//  FirstViewController.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/16/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var myArray: [String] = ["First", "Second", "Third", "Add More"]
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        tableView.register(CustomTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "headerID")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
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
        print("Value: \(myArray[indexPath.row])")
        if indexPath.row == myArray.count-1 {
            showInputDialog(title: "Add Item",
                            subtitle: "Please enter the name and expiry date of the item.",
                            actionTitle: "Add",
                            cancelTitle: "Cancel",
                            textField1PlaceHolder: "Name",
                            textField2PlaceHolder: "Expiry Date") { [unowned self] (title: String?, expiry: String?) in
                                if let title = title, let expiry = expiry {
                                    self.append(title, to: tableView)
                                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.text = String(myArray[indexPath.row])
        return cell
    }
}

// MARK: - Private Methods
extension FirstViewController {
    
    private func append(_ title: String, to tableView: UITableView) {
        myArray[myArray.count-1] = title
        tableView.cellForRow(at: IndexPath(row: myArray.count-1, section: 0))?.textLabel?.text = title
        myArray.append("Add More")
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: myArray.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
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
