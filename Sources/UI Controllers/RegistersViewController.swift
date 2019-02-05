//
//  RegistersViewController.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/5/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Cocoa

@objc class RegisterAndValue: NSObject {
    init(register: Register, value: Int) {
        self.name = register.name
        self.value = value
    }
    @objc dynamic var name: String
    @objc dynamic var value: Int
}

class RegistersViewController: NSViewController, NSTableViewDataSource {

    convenience init() {
        self.init(nibName: "RegistersView", bundle: nil)
    }

    // MARK: - NSTableViewDataSource

    // MARK: - Properties

    @objc static func keyPathsForValuesAffectingAllRegisterValues() -> Set<String> {
        let result = Set(Register.allCases.map { "registers." + $0.name })
        return result
    }

    @objc dynamic var allRegisterValues: [RegisterAndValue] {
        guard let registers = registers else { return [] }
        let result = Register.allCases.map { RegisterAndValue(register: $0, value: registers[$0] )}
        return result
    }

    @objc dynamic var registers: Registers?

    @IBOutlet weak var tableView: NSTableView!
}
