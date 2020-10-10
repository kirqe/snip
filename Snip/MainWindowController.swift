//
//  MainWindowController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
//    @IBOutlet weak var myButton: NSToolbar!
//     weak var delegate: SomeDelegate?

    
    @IBAction func myAction(sender: AnyObject) {
        let myVc = window!.contentViewController as! ProductsCollectionViewController
        myVc.logText(title: "WC") // make request and send data to collection view
    }
    
    
    convenience init() {
        self.init(windowNibName: "MainWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

        
        
        contentViewController = ProductsCollectionViewController()

        
    }
    

    
}
