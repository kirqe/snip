//
//  ProductCollectionViewItem.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa

class ProductCollectionViewItem: NSCollectionViewItem {
    
    static let reuseIdentifier = NSUserInterfaceItemIdentifier("ProductCollectionViewItemIdentifier")
    
    @IBOutlet weak var productTitle: NSTextField!
    @IBOutlet weak var productPrice: NSTextField!
    @IBOutlet weak var productCondition: NSTextField!
    @IBOutlet weak var productLocation: NSTextField!
    @IBOutlet weak var productSeller: NSTextField!
    @IBOutlet weak var productImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    override func mouseDown(with event: NSEvent) {
        if event.clickCount == 2 {
            print("Double click \(productTitle.stringValue)")
        } else {
            print("Single click \(productTitle.stringValue)")
            super.mouseDown(with: event)
        }
    }
    
}
