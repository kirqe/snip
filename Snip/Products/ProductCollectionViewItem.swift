//
//  ProductCollectionViewItem.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa
import QuartzCore

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
        view.makeBackingLayer()
        view.wantsLayer = true
        
        // shadows https://stackoverflow.com/a/32882755/1231365
        view.wantsLayer = true
        view.shadow = NSShadow()
        view.layer?.shadowOpacity = 0.3
        view.layer?.shadowColor = NSColor.black.cgColor
        view.layer?.shadowOffset = NSMakeSize(0, 0)
        view.layer?.shadowRadius = 5
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
