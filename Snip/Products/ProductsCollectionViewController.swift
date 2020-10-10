//
//  ProductsCollectionViewController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa

@objc protocol SomeDelegate {
    func logText(title: String)
}

class ProductsCollectionViewController: NSViewController {

    var products: [Product]   = []
    var nextPage: String = ""

    
    func logText(title: String) {
        print(title)
        
        dataRequest(with: "https://api.ebay.com/buy/browse/v1/item_summary/search?q=blackberry", objectType: ProductsPage.self) { (result: Result) in
            switch result {
            case .success(let object):
                print(object.itemSummaries)
                self.products = object.itemSummaries!
                self.nextPage = object.next ?? ""
                
                DispatchQueue.main.async {
                    self.productsCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    @IBOutlet var productsCollectionView: NSCollectionView!

    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
         setCollectionView()
    }
    
    private func setCollectionView() {
        productsCollectionView.delegate = self
        productsCollectionView.isSelectable = true
        productsCollectionView.register(ProductCollectionViewItem.self, forItemWithIdentifier: ProductCollectionViewItem.reuseIdentifier)
        let gridLayout = NSCollectionViewGridLayout()
        
        gridLayout.minimumItemSize = NSSize(width: 450.0, height: 200.0)
        gridLayout.maximumItemSize = NSSize(width: 900.0, height: 200.0)
        
        gridLayout.minimumInteritemSpacing = 10
        gridLayout.minimumLineSpacing = 10


        gridLayout.maximumNumberOfColumns = 3
        
        gridLayout.margins = NSEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        productsCollectionView.collectionViewLayout = gridLayout
    }
    
}

extension ProductsCollectionViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if products.count > 0 {
            return products.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let product = productsCollectionView.makeItem(withIdentifier: ProductCollectionViewItem.reuseIdentifier, for: indexPath)
        guard let productCVI = product as? ProductCollectionViewItem else { return product }
        
        // set image from url
        DispatchQueue.global(qos: .background).async {
            let image: NSImage = NSImage(contentsOf: URL(string: self.products[indexPath.item].image?.imageUrl ?? "")!)!
            DispatchQueue.main.async {
                productCVI.productImage.image = image
            }
        }
        
        let queuedProduct = products[indexPath.item]
        
        
        productCVI.productTitle.stringValue = queuedProduct.title!
        productCVI.productPrice.stringValue = "\(queuedProduct.price?.value ?? "n/a") \(queuedProduct.price?.currency ?? "n/a")"
        productCVI.productLocation.stringValue = "\(queuedProduct.itemLocation?.country ?? "n/a") \(queuedProduct.itemLocation?.postalCode ?? "n/a")"
        productCVI.productSeller.stringValue = "\(queuedProduct.seller?.username ?? "n/a") (\(String(describing: queuedProduct.seller!.feedbackScore!)) ★) \(queuedProduct.seller?.feedbackPercentage ?? "n/a") %"
        
        
        let condition = products[indexPath.item].condition ?? "n/a"
        
        switch condition {
        case "New":
            productCVI.productCondition.textColor = NSColor.red
            productCVI.productCondition.font = NSFont(name: "System Heavy Regular", size: 13)
        case "Open box":
            productCVI.productCondition.textColor = NSColor.init(deviceRed: 34/255, green: 172/255, blue: 59/255, alpha: 1.0)
        case "Seller Refurbished":
            productCVI.productCondition.textColor = NSColor.gray
        default:
            productCVI.productCondition.textColor = NSColor.black
        }
        productCVI.productCondition.stringValue = condition
        
        

        return productCVI
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, willDisplay item: NSCollectionViewItem, forRepresentedObjectAt indexPath: IndexPath) {
        if indexPath.item == self.products.count - 1 {
            progressIndicator.startAnimation(self)
            dataRequest(with: self.nextPage, objectType: ProductsPage.self) { (result: Result) in
               switch result {
               case .success(let object):
                   print(object.itemSummaries)
//                   self.products.append(contentsOf: object.itemSummaries!)
                   self.nextPage = object.next ?? ""
                   
                   
                   let newIndexPath = IndexPath(item: self.products.count, section: 0)
                   self.products.append(contentsOf: object.itemSummaries!)
                   DispatchQueue.main.async {
                        self.productsCollectionView.insertItems(at: [newIndexPath])
                        self.progressIndicator.stopAnimation(self)
                   }

                   
               case .failure(let error):
                   print(error)
               }
           }
        }

    }
}


