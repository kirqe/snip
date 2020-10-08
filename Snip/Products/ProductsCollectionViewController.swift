//
//  ProductsCollectionViewController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa

class ProductsCollectionViewController: NSViewController {
    
    @IBOutlet var productsCollectionView: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
         setCollectionView()
    }
    
    private func setCollectionView() {
//        productsCollectionView.delegate = self
        productsCollectionView.register(ProductCollectionViewItem.self, forItemWithIdentifier: ProductCollectionViewItem.reuseIdentifier)
        let gridLayout = NSCollectionViewGridLayout()
        
        gridLayout.minimumItemSize = NSSize(width: 300.0, height: 150.0)
        gridLayout.maximumItemSize = NSSize(width: 600.0, height: 300.0)
        
        gridLayout.minimumInteritemSpacing = 10
        gridLayout.minimumLineSpacing = 10
        

        gridLayout.maximumNumberOfColumns = 3
        
        
        gridLayout.margins = NSEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        productsCollectionView.collectionViewLayout = gridLayout
    }
    
}

extension ProductsCollectionViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let product = productsCollectionView.makeItem(withIdentifier: ProductCollectionViewItem.reuseIdentifier, for: indexPath)
        
        return product
    }
}
