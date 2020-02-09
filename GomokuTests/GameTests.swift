//
//  GameTests.swift
//  GomokuTests
//
//  Created by Tony on 2/1/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import XCTest
@testable import Gomoku

class GameTests: XCTestCase {
    
    var game: Game!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        game = Game()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTakeTurn() {
        // Take a turn at (3, 5)
        var boardCase = game.currentBoardState[3][5]
		XCTAssert(boardCase.index == (x: 3, y: 5))
        XCTAssertNoThrow(try self.game.takeTurn(boardCase))
		XCTAssertEqual(game.currentBoardState[3][5].piece, Game.Player.black)
		XCTAssertEqual(game.currentPlayer, Game.Player.white)
        
        // Take a turn at (2, 8)
        boardCase = game.currentBoardState[2][8]
        XCTAssert(boardCase.index == (x: 2, y: 8))
        XCTAssertNoThrow(try self.game.takeTurn(2, 8))
		XCTAssertEqual(game.currentPlayer, Game.Player.black)
		XCTAssertEqual(game.currentBoardState[2][8].piece!, Game.Player.white, "Game.takeTurn does not work")
    }

    func testTakeBackMove() throws {
        XCTAssertFalse(try game.takeTurn(3, 5))
        XCTAssertFalse(try game.takeTurn(2, 8))
        
        XCTAssertNoThrow(try game.takeBackMove())
        XCTAssertNil(game.currentBoardState[2][8].piece)
        XCTAssertNil(game.currentBoardState[3][5].piece)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

	func testWinCheck() throws {
		for moveY in [5, 7, 8, 9] {
			XCTAssertFalse(try game.takeTurn(3, moveY))
			XCTAssertFalse(try game.takeTurn(4, moveY))
		}
		XCTAssert(try game.takeTurn(3, 6))
	}
}
