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
        /// here is the use of constructor’s dependency injection
        return FactsViewModel(landingVCObj: self)
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        callAPI()
    }
    
    deinit {
        print("perform the deinitialization")
    }
    
}

/// Utility Methods of  API
extension LandingVC {
    
    /// Function to fetch API Data
    func callAPI() {
        viewModelObj.fetchAboutCanadaFacts()
    }
    
    /// API Response Received
    /// - parameter Bool: is success from
    /// - parameter AnyObject?:  instance of view model object
    /// - parameter AnyObject: instance of exception if any
    func didReceiveApiResponse(isSuccess: Bool, exception: AnyObject?) {
        
        if isSuccess {
            print(isSuccess)
        } else {
            print("\(exception?.localizedDescription ?? AppConstant.LiteralString.errorMsg)")
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
        registerUINibForCell()
        
        ///Eliminate extra separators below UITableView
        tableView?.tableFooterView = UIView()
        
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
  
}
