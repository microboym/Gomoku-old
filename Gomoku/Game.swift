//
//  Game.swift
//  Gomoku
//
//  Created by Tony on 1/28/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class Game: NSObject, ObservableObject {
    let boardSize: Int = 15
    
    @Published var currentBoardState: [[BoardCase]]
	var currentPlayer: Player {
		history.count % 2 == 0 ? .black : .white
	}
    @Published var history: [(x: Int, y: Int)] = []
    
    override init() {
        currentBoardState = []
        super.init()
        for x in 0 ..< boardSize {
            currentBoardState.append([])
            for y in 0 ..< boardSize {
                currentBoardState[x].append(BoardCase(index: (x, y)))
            }
        }
    }
    
    func takeTurn(_ boardCase: BoardCase) throws -> Bool {
        return try takeTurn(boardCase.index.x, boardCase.index.y)
    }
    
    func takeTurn(_ row: Int, _ column: Int) throws -> Bool {
        if !(0..<boardSize ~= row && 0..<boardSize ~= column) {
            throw GameError.badLocation
        }
        currentBoardState[row][column].piece = currentPlayer
        history.append((row, column))

		return winCheck()
    }
    
    // MARK: History Controllers
    
    func historyIsEmpty() -> Bool {
        return history.isEmpty
    }
    
    @objc func takeBackMove() throws {
        guard let lastMove = history.last else {
            throw GameError.noMoveToTakeBack
        }
        currentBoardState[lastMove.0][lastMove.1].piece = nil
        _ = history.popLast()
        
        // take back opponent's move
        if let lastMove = history.last {
            currentBoardState[lastMove.0][lastMove.1].piece = nil
            _ = history.popLast()
        }
    }
	enum Player {
		case white
		case black
		func opposite() -> Player {
			return self == .white ? .black : .white
		}
	}

	static private let direction = [(1, 0), (0, 1), (1, 1), (1, -1)]
	private func winCheck() -> Bool {
		let piece = history.count%2 == 1 ? Player.black : .white
		for (dirX, dirY) in Self.direction {
			var count = 1
			var (x, y) = history.last!
			for _ in 1 ..< 5 {
				x += dirX
				y += dirY
				if !(0..<boardSize ~= x && 0..<boardSize ~= y) { break }
				if currentBoardState[x][y].piece == piece {
					count += 1
				}
			}

			(x, y) = history.last!
			for _ in 1 ..< 5 {
				x -= dirX
				y -= dirY
				if !(0..<boardSize ~= x && 0..<boardSize ~= y) { break }
				if currentBoardState[x][y].piece == piece {
					count += 1
				}
			}

			if count >= 5 { return true }
		}
		return false
	}

	struct BoardCase: Identifiable {
		let id = UUID()
		var piece: Player? = nil
		let index: (x: Int, y: Int)
	}

	#if DEBUG
	static var testData: Game {
		let game = Game()
		_ = try! game.takeTurn(3, 5)
		_ = try! game.takeTurn(2, 8)
		return game
	}
	#endif
}

enum GameError: Error {
    case badLocation
    case noMoveToTakeBack
}
