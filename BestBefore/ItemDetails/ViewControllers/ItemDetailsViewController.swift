//
//  ItemDetailsViewController.swift
//  BestBefore
//
//  Created by Khalid Asad on 10/21/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation
import UIKit

final class ItemDetailsViewController: UIViewController {
    
    private var itemDetailsModel: ItemDetailsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    init(itemDetailsModel: ItemDetailsModel) {
        super.init(nibName: nil, bundle: nil)
        self.itemDetailsModel = itemDetailsModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemDetailsViewController {
    
    private func setUpViews() {
        view = UIView()
        view.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        for string in [itemDetailsModel.name, itemDetailsModel.dateAdded, itemDetailsModel.expiryDate] {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = string
            stackView.addArrangedSubview(label)
        }
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
