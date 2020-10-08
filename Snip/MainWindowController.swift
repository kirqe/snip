//
//  MainWindowController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    convenience init() {
        self.init(windowNibName: "MainWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        contentViewController = ProductsCollectionViewController()
    }
    
}
