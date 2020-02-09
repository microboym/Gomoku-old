//
//  Document.swift
//  Gomoku
//
//  Created by Tony on 1/28/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import Cocoa
import SwiftUI

class Document: NSDocument {
    @objc var game = Game()

    override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
		return typeName == "Gomoku Game"
    }

	override class func canConcurrentlyReadDocuments(ofType typeName: String) -> Bool {
		return typeName == "Gomoku Game"
	}

    override func makeWindowControllers() {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
			.environmentObject(game)

        // Create the window and set the content view.
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 900, height: 1000),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.contentView = NSHostingView(rootView: contentView)
        let windowController = NSWindowController(window: window)
        self.addWindowController(windowController)
    }
    
    override func data(ofType typeName: String) throws -> Data {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		return try encoder.encode(game)
    }

    override func read(from data: Data, ofType typeName: String) throws {
		let decoder = JSONDecoder()
		game = try decoder.decode(Game.self, from: data)
    }
}

