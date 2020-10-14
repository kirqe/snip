//
//  PreferencesWindowController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 11/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {

    lazy var preferencesTabViewController: NSTabViewController = {
        let tabVC = NSTabViewController()
        tabVC.tabStyle = .toolbar
        
        let generalTabView = NSTabViewItem(viewController: PreferencesGeneralController())
        generalTabView.label = "General"
        generalTabView.image = NSImage(named: "NSPreferencesGeneral")
        
        let accountTabView = NSTabViewItem(viewController: PreferencesAccountController())
        accountTabView.label = "Account"
        accountTabView.image = NSImage(named: "NSUserAccounts")
        
        tabVC.addTabViewItem(generalTabView)
        tabVC.addTabViewItem(accountTabView)
        
        return tabVC
    }()
    
    convenience init() {
        self.init(windowNibName: "PreferencesWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        
        
        contentViewController = preferencesTabViewController
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func generalTabPressed(_ sender: Any) {
        preferencesTabViewController.selectedTabViewItemIndex = 0
    }
    
    @IBAction func accountTabPressed(_ sender: Any) {
        preferencesTabViewController.selectedTabViewItemIndex = 1
    }
    
}
