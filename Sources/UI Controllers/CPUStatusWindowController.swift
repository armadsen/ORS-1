//
//  CPUStatusWindowController.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/5/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Cocoa

class DebugView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        NSColor.green.set()
        dirtyRect.fill()
    }
}

class CPUStatusWindowController: NSWindowController {

    override init(window: NSWindow?) {
        registersViewController = RegistersViewController()
        
        super.init(window: window)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(cpu: CPU) {
        self.init(windowNibName: "CPUStatusWindow")

        self.cpu = cpu
        registersViewController.registers = cpu.registers
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        let registersView = registersViewController.view
        registersView.translatesAutoresizingMaskIntoConstraints = false
        registersContainerView.addSubview(registersView)
        registersView.leftAnchor.constraint(equalTo: registersContainerView.leftAnchor).isActive = true
        registersView.rightAnchor.constraint(equalTo: registersContainerView.rightAnchor).isActive = true
        registersView.topAnchor.constraint(equalTo: registersContainerView.topAnchor).isActive = true
        registersView.bottomAnchor.constraint(equalTo: registersContainerView.bottomAnchor).isActive = true
    }

    var cpu: CPU?

    private var registersViewController: RegistersViewController

    @IBOutlet weak var registersContainerView: NSView!
}
