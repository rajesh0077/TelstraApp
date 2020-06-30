//
//  LandingVC.swift
//  TelstraApp
//
//  Created by RajeshDeshmukh on 30/06/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class LandingVC: UITableViewController {
    
    /// private constants
    private struct Constant {
        static let estimatedRowHeight: CGFloat = 44
    }
    
    /// Variables
    lazy var viewModelObj = {
        return FactsViewModel()
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Rajesh")
        configureTableView()
    }
    
    deinit {
        print("perform the deinitialization")
    }
    
}

// MARK: - TableView Utility Methods

extension LandingVC {
    
    /// Function to configure TableView
    func configureTableView() {
        
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = LandingVC.Constant.estimatedRowHeight
        
        ///Eliminate extra separators below UITableView
        tableView?.tableFooterView = UIView()
        
        registerUINibForCell()
    }
    
    /// Function to  register tableViewCell
    func registerUINibForCell() {
        if let tableView = tableView {
            tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: AppConstant.CellIdentifire.kFactsTableViewCellId)
        }
    }
    
    /// Function to creation cell  and it's configuration
    /// - parameter indexPath: IndexPath for cell
    /// - ReturnS: instance of ImageTableViewCell
    func getFactsTableViewCellFor(indexPath: IndexPath) -> FactsTableViewCell? {
        let cell = tableView?.dequeueReusableCell(withIdentifier: AppConstant.CellIdentifire.kFactsTableViewCellId, for: indexPath) as! FactsTableViewCell
        return cell
    }
    
}
// MARK: -  Table view data source

extension LandingVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelObj.getNumberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelObj.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getFactsTableViewCellFor(indexPath: indexPath) ?? UITableViewCell()
    }
    
}
