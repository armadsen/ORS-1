//
//  Document.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        super.makeWindowControllers()
        mainWindowController = MainDocumentWindowController()
        addWindowController(mainWindowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        guard let result = assemblyProgram.data(using: .utf8) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileWriteUnknownError, userInfo: nil)
        }
        return result
    }

    override func read(from data: Data, ofType typeName: String) throws {
        guard let string = String(data: data, encoding: .utf8) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileReadCorruptFileError, userInfo: nil)
        }
        assemblyProgram = string
    }

    // MARK: - Private

    // MARK: - Properties

    var cpu: CPU? {
        didSet {
            mainWindowController?.cpu = cpu
        }
    }

    @objc var assemblyProgram: String = ""

    private var mainWindowController: MainDocumentWindowController! {
        didSet {
            mainWindowController.cpu = cpu
        }
    }
}

