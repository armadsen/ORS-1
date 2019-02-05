//
//  DocumentController.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/5/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Cocoa

class DocumentController: NSDocumentController {
    override func addDocument(_ document: NSDocument) {
        super.addDocument(document)

        if let doc = document as? Document {
            doc.cpu = cpu
        }
    }

    var cpu: CPU? {
        didSet {
            for doc in documents {
                guard let doc = doc as? Document else { continue }
                doc.cpu = cpu
            }
        }
    }
}
