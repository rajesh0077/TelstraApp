//
//  FactsViewModel.swift
//  TelstraApp
//
//  Created by RajeshDeshmukh on 30/06/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation

class FactsViewModel {
    
    weak var landingVCObj: LandingVC?
    var displayAboutCanda: [DisplayRowModel]?
    var navTitle: String?
    
    init(landingVCObj: LandingVC) {
        self.landingVCObj = landingVCObj
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumberOfRows() -> Int {
        return 4
    }
    
    ///  function to fetch API Data by given URL
    func fetchAboutCanadaFacts() {
        let urlStr = AppConstant.ApiURLS.aboutCanada
        NetworkManager.shared.callAPI(withURLStr: urlStr, onCompletion: {(data, error) in
            
            guard let data = data else {
                self.navTitle = ""
                self.landingVCObj?.didReceiveApiResponse(isSuccess: false, exception: error as AnyObject?)
                return
            }
            
            let jsonStr = String(decoding: data, as: UTF8.self)
            
            do {
                let results = try JSONDecoder().decode(AboutCandaModel.self, from: jsonStr.data(using: .utf8)!)
                self.navTitle = results.title
                self.displayAboutCanda  = results.rows
                self.landingVCObj?.didReceiveApiResponse(isSuccess: true, exception: error as AnyObject?)
                
            } catch {
                print(error.localizedDescription)
                self.landingVCObj?.didReceiveApiResponse(isSuccess: false, exception: error as AnyObject?)
            }
            
        })
    }
    
}
 
