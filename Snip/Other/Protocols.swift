//
//  Protocols.swift
//  Snip
//
//  Created by Kirill Beletskiy on 11/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Foundation

@objc protocol SomeDelegate {
    func logText(title: String)
}


@objc protocol SearchableDelegate {
    func search(term: String)
}
