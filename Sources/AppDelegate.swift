//
//  AppDelegate.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        (NSDocumentController.shared as! DocumentController).cpu = cpu
        statusWindowController.showWindow(nil)
    }

    private var cpu = CPU()

    lazy var statusWindowController: CPUStatusWindowController = {
        return CPUStatusWindowController(cpu: cpu)
    }()
    
}

