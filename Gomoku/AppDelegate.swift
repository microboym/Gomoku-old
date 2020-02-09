//
//  AppDelegate.swift
//  Gomoku
//
//  Created by Tony on 1/28/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @objc var hasLastMove: Bool {
        guard let doc = NSDocumentController.shared.currentDocument as? Document else {
            return false
        }
        return !doc.game.historyIsEmpty()
    }

    @IBAction func takeBackMove(_ sender: Any) {
        if let doc = NSDocumentController.shared.currentDocument as? Document {
            do {
                try doc.game.takeBackMove()
            } catch GameError.noMoveToTakeBack {
                fatalError("calling game.takeBackMove failed: No move to take back")
            } catch {
                fatalError("calling game.takeBackMove failed: Other error")
            }
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

