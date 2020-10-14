//
//  PreferencesAccountController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 11/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa

class PreferencesAccountController: NSViewController {
    lazy var authorizeWindowController = AuthorizeWindowController()
    
    @IBAction func openAuthorizeWindow(_ sender: Any) {
        print("wer")
        authorizeWindowController = AuthorizeWindowController()
        authorizeWindowController.showWindow(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

    }
    
}
