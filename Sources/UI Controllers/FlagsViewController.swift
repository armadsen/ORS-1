//
//  FlagsViewController.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/5/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Cocoa

private extension NSUserInterfaceItemIdentifier {

    static var flagColumn = NSUserInterfaceItemIdentifier("FlagColumn")
    static var valueColumn = NSUserInterfaceItemIdentifier("ValueColumn")

}

class FlagsViewController: NSViewController, NSTableViewDataSource {

    convenience init() {
        self.init(nibName: "FlagsView", bundle: nil)
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        guard let flags = flags else { return nil }

        switch tableColumn!.identifier {
        case .flagColumn:
            return Flags.allKeys[row]._kvcKeyPathString
        case .valueColumn:
            return flags[keyPath: Flags.allKeys[row]]
        default: return nil
        }
    }


    private var flagsObservers = [NSKeyValueObservation]()
    var flags: Flags? {
        willSet {
            flagsObservers = []
        }
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
            guard let flags = flags else { return }
            for key in Flags.allKeys {
                flagsObservers.append(flags.observe(key) { [weak self] (_, _) in
                    DispatchQueue.main.async { self?.tableView.reloadData() }
                })
            }
        }
    }

    @IBOutlet weak var tableView: NSTableView!
}
