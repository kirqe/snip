//
//  ProductsPageViewModel.swift
//  Snip
//
//  Created by Kirill Beletskiy on 14/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Foundation

//var href: String?
//var total: Int?
//var next: String?
//var limit: Int?
//var offset: Int?
//var itemSummaries: [Product]?

class ProductsPageViewModel {

    public var products: [Product] = []
    public var nextPage: String = ""
    public var totalNumOfProducts: Int = 0
    public var isLoading: Bool = false
    
    
}

extension ProductsPageViewModel {

    
    func searchForProduct(term: String, completion: (@escaping () -> Void)) -> Void {
        isLoading = true
//        let defaults = UserDefaults.standard.object(forKey: "applicationAccessToken")!
        
        let headers = ["Authorization": "Bearer \(UserDefaults.standard.object(forKey: "applicationAccessToken")!)"]

        dataRequest(with: "https://api.ebay.com/buy/browse/v1/item_summary/search?q=\(escape(string: term))",
                    httpMethod: "GET",
                    headers: headers,
                    objectType: ProductsPage.self) { (result: Result) in
                        
                        switch result {
                        case .success(let object):
                            
                            self.products = object.itemSummaries ?? []
                            self.nextPage = object.href!
                            self.totalNumOfProducts = object.total ?? 0
                            self.isLoading = false
                            completion()
                        case .failure(let error):
                            print(error)
                        }
                    }
    }
    
    func loadNextPage(completion: (@escaping () -> Void)) -> Void {
        isLoading = true
        let headers = ["Authorization": "Bearer \(UserDefaults.standard.object(forKey: "applicationAccessToken")!)"]
        
        dataRequest(with: self.nextPage,
                    httpMethod: "GET",
                    headers: headers,
                    objectType: ProductsPage.self) { (result: Result) in
                        
                        switch result {
                        case .success(let object):
                            self.products.append(contentsOf: object.itemSummaries!)
                            self.nextPage = object.href!
                            self.isLoading = false
                            
                            completion()
                        case .failure(let error):
                            print(error)
                        }
                    }
    }
}
