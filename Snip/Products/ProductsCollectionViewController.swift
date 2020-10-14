//
//  ProductsCollectionViewController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa


class ProductsCollectionViewController: NSViewController {
    var placeholderView = EmptyViewController().view
    var productsPageVM = ProductsPageViewModel()
    
    @IBOutlet var productsCollectionView: NSCollectionView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        setCollectionView()
        
        
        // fix
        placeholderView.autoresizingMask = [.width, .height]
        view.addSubview(placeholderView)
        
    }
    
    func search(term: String) {
        print("term: \(escape(string: term))")

        
        progressIndicator.startAnimation(nil)
        productsPageVM.searchForProduct(term: term) { [weak self]  in
            DispatchQueue.main.async {
 
                self?.productsCollectionView.scroll(NSPoint(x: 0, y: 0)) // scroll to top
                self?.productsCollectionView.reloadData()
                self?.progressIndicator.stopAnimation(nil)
            }
        }
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


        gridLayout.maximumNumberOfColumns = 4
        
        gridLayout.margins = NSEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        productsCollectionView.collectionViewLayout = gridLayout
        
    }
    
}

extension ProductsCollectionViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if productsPageVM.products.count > 0 {
            // fix
            placeholderView.removeFromSuperview()
        }

        return productsPageVM.products.count
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let product = productsCollectionView.makeItem(withIdentifier: ProductCollectionViewItem.reuseIdentifier, for: indexPath)
        
        guard let productCVI = product as? ProductCollectionViewItem else { return product }

        let productViewModel = ProductViewModel(product: (productsPageVM.products[indexPath.item]))

        productViewModel.configure(productCVI)
        return productCVI
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, willDisplay item: NSCollectionViewItem, forRepresentedObjectAt indexPath: IndexPath) {
        
        if indexPath.item == productsPageVM.products.count - 1  && productsPageVM.products.count < productsPageVM.totalNumOfProducts {
            
            
            progressIndicator.startAnimation(nil)
            
            productsPageVM.loadNextPage() { [weak self] in
                let newIndexPath = IndexPath(item: (self?.productsPageVM.products.count)!, section: 0)

                DispatchQueue.main.async {
                    self?.productsCollectionView.insertItems(at: [newIndexPath])
                    self?.progressIndicator.stopAnimation(nil)
                }
            }
            
  
        }


    }
}


