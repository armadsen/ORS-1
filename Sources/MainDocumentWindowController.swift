//
//  MainDocumentWindowController.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Cocoa

class MainDocumentWindowController: NSWindowController {

    convenience init() {
        self.init(windowNibName: "Document")
    }
    
    @IBOutlet var assemblyTextView: NSTextView!
    @IBOutlet var machineCodeTextView: NSTextView!
    @IBOutlet var consoleTextView: NSTextView!
}
