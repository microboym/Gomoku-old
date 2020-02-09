//
//  Game+Codable.swift
//  Gomoku
//
//  Created by Tony on 2/5/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

enum CodingKeys: String, CodingKey {
	case players, moves
}

enum PlayerCodingKeys: String, CodingKey {
	case black, white
}


extension Game: Codable {
	convenience init(from decoder: Decoder) throws {
		self.init()
		let container = try decoder.container(keyedBy: CodingKeys.self)
		var moves = try container.nestedUnkeyedContainer(forKey: .moves)
		for _ in 0 ..< moves.count! {
			var move = try moves.nestedUnkeyedContainer()
			try takeTurn(try move.decode(Int.self), try move.decode(Int.self))
		}
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		var players = container.nestedContainer(keyedBy: PlayerCodingKeys.self, forKey: .players)
		try players.encode(NSFullUserName(), forKey: .black)
		try players.encode(NSFullUserName(), forKey: .white)

		var moves = container.nestedUnkeyedContainer(forKey: .moves)
		try history.forEach({ boardCase in
			var move = moves.nestedUnkeyedContainer()
			try move.encode(boardCase.x)
			try move.encode(boardCase.y)
		})
	}
}
