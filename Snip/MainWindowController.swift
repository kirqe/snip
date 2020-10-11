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
    
    @IBOutlet weak var regularSearchField: NSSearchField!
    
    convenience init() {
        self.init(windowNibName: "MainWindowController")
        
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.regularSearchField?.delegate = self
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

        
        
        contentViewController = ProductsCollectionViewController()

        
    }
}

extension MainWindowController: NSSearchFieldDelegate, NSTextFieldDelegate {
//    func searchFieldDidStartSearching(_ sender: NSSearchField) {
//        if regularSearchField.stringValue.count > 1 {
//            print("lala")
//        }
//
//    }
//
//    func searchFieldDidEndSearching(_ sender: NSSearchField) {
//        print("lala e")
//    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            // Do something against ENTER key
            let myVc = window!.contentViewController as! ProductsCollectionViewController
            myVc.search(term: control.stringValue)
            
            
            return true
        } else if (commandSelector == #selector(NSResponder.deleteForward(_:))) {
            // Do something against DELETE key
            return true
        } else if (commandSelector == #selector(NSResponder.deleteBackward(_:))) {
            // Do something against BACKSPACE key

            return false
        } else if (commandSelector == #selector(NSResponder.insertTab(_:))) {
            // Do something against TAB key
            return true
        } else if (commandSelector == #selector(NSResponder.cancelOperation(_:))) {
            // Do something against ESCAPE key
            return true
        }

        // return true if the action was handled; otherwise false
        return false
    }
}
