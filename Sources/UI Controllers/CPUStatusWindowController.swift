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
        flagsViewController = FlagsViewController()

        super.init(window: window)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(cpu: CPU) {
        self.init(windowNibName: "CPUStatusWindow")

        self.cpu = cpu
        registersViewController.registers = cpu.registers
        flagsViewController.flags = cpu.flags
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        embed(viewController: registersViewController, in: registersContainerView)
        embed(viewController: flagsViewController, in: flagsContainerView)
    }

    private func embed(viewController: NSViewController, in containerView: NSView) {
        let vcView = viewController.view
        vcView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(vcView)
        vcView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        vcView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        vcView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        vcView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }

    var cpu: CPU?

    private var registersViewController: RegistersViewController
    private var flagsViewController: FlagsViewController

    @IBOutlet weak var registersContainerView: NSView!
    @IBOutlet weak var flagsContainerView: DebugView!
}
