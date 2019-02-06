//
//  MainDocumentWindowController.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Cocoa

class MainDocumentWindowController: NSWindowController {

    convenience init() {
        self.init(windowNibName: "Document")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        assemblyTextView.lnv_setUpLineNumberView()
        machineCodeTextView.lnv_setUpLineNumberView()
    }

    @IBAction func assembleProgram(_ sender: Any) {
        do {
            statements = try assemble(string: assemblyProgram)
        } catch {
            presentError(error)
        }
    }

    @IBAction func run(_ sender: Any) {
        assembleProgram(sender)
        cpu?.program = statements
        do {
            try cpu?.runUntilHalt()
        } catch {
            presentError(error)
        }
    }

    @IBAction func reset(_ sender: Any) {
        cpu?.reset()
    }

    @IBAction func step(_ sender: Any) {
        do {
            try cpu?.singleStep()
        } catch {
            printToConsole(string: "Error: \(error)")
        }
    }

    // MARK: - Private

    func printToConsole(string: String) {
        consoleTextView.textStorage?.mutableString.append(string)
        consoleTextView.textStorage?.mutableString.append("\n")
    }

    // MARK: - Properties

    var cpu: CPU? {
        didSet {
            cpu?.printHandler = { [weak self] string in
                self?.consoleTextView.textStorage?.mutableString.append(string)
            }
        }
    }

    @objc static func keyPathsForValuesAffectingAssemblyProgram() -> Set<String> {
        return ["document.assemblyProgram"]
    }

    @objc dynamic var assemblyProgram: String {
        get {
            guard let doc = document else { return "" }
            return (doc as! Document).assemblyProgram
        }
        set {
            guard let doc = document else { return }
            (doc as! Document).assemblyProgram = newValue
        }
    }
    @objc dynamic var assembledProgram: String = ""

    var statements: [Statement] = [] {
        didSet {
            assembledProgram = statements.map { $0.rawHexString }.joined(separator: "\n")
        }
    }
    
    @IBOutlet var assemblyTextView: NSTextView!
    @IBOutlet var machineCodeTextView: NSTextView!
    @IBOutlet var consoleTextView: NSTextView!
}
