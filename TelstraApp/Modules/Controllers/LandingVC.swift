//
//  LandingVC.swift
//  TelstraApp
//
//  Created by RajeshDeshmukh on 30/06/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class LandingVC: UITableViewController {
    
    /// Private Constants
    private struct Constant {
        static let estimatedRowHeight: CGFloat = 44
    }
    
    /// Variables
    lazy var viewModelObj = {
        /// here is the use of constructor’s dependency injection
        return FactsViewModel(landingVCObj: self)
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        addRefreshButton()
        callAPI()
    }
    
    deinit {
        print("perform the deinitialization")
    }
    
}

// MARK: - API Utility Methods

extension LandingVC {
    
    /// Function to fetch API Data
    func callAPI() {
        viewModelObj.fetchAboutCanadaFacts()
    }
    
    /// API Response Received
    /// - parameter Bool: is success from API
    /// - parameter AnyObject: instance of exception if any
    func didReceiveApiResponse(isSuccess: Bool, exception: AnyObject?) {
        
        if isSuccess {
            
            print(isSuccess)
            DispatchQueue.main.async {
                self.title = self.viewModelObj.getNavigationTitle()
                if self.viewModelObj.getTotalNumberOfFacts() > 0 {
                    self.tableView.reloadData()
                }
            }
            
        } else {
            DispatchQueue.main.async {
                self.showAlert(title: AppConstant.LiteralString.errorTitle,
                               message : exception?.localizedDescription ?? AppConstant.LiteralString.errorMsg,
                               actionTitle : AppConstant.LiteralString.okBtn)
            }
        }
    }
    
}

// MARK: - TableView Utility Methods

extension LandingVC {
    
    /// Function to configure TableView
    func configureTableView() {
        
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = LandingVC.Constant.estimatedRowHeight
        registerTableCell()
        
        ///Eliminate extra separators below UITableView
        tableView?.tableFooterView = UIView()
        
    }
    
    /// Function to  register table view cell
    func registerTableCell () {
        if let tableView = tableView {
            tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: AppConstant.CellIdentifire.kFactsTableViewCellId)
        }
    }
    
    /// Function to creation cell  and it's configuration
    /// - parameter indexPath: IndexPath for cell
    /// - ReturnS: instance of ImageTableViewCell
    func getFactsTableViewCellFor(indexPath: IndexPath) -> FactsTableViewCell? {
        let cell = tableView?.dequeueReusableCell(withIdentifier: AppConstant.CellIdentifire.kFactsTableViewCellId, for: indexPath) as! FactsTableViewCell
        
        /// set table view cell data
        cell.rowCellModel = viewModelObj.getPerticularFactAtIndexPath(indexPath: indexPath)
        
        return cell
    }
    
}

// MARK: -  TableView Data Source

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

// MARK: - Helper Methods

extension LandingVC {
    
    /// Function to displays alertview controller
    /// - parameter String: title for alert
    /// - parameter String: message for alert
    /// - parameter String: actionbtnTitle for alert
    func showAlert(title : String , message : String , actionTitle : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    func addRefreshButton() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func refresh() {
        callAPI()
    }
    
}
