//
//  BoardCaseView.swift
//  Gomoku
//
//  Created by Tony on 1/29/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import SwiftUI

struct BoardCaseView: View {
    @EnvironmentObject var game: Game
	var boardCase: Game.BoardCase

	private var edges: Edge.Set {
		var e = Edge.Set.all
		if boardCase.index.x == 0 { e.remove(.top) }
		if boardCase.index.y == 0 { e.remove(.leading) }
		if boardCase.index.x >= game.boardSize-1 { e.remove(.bottom) }
		if boardCase.index.y >= game.boardSize-1 { e.remove(.trailing) }
		return e
	}

    var body: some View {
        GeometryReader { geo in
            ZStack {
				Cross(size: min(geo.size.width, geo.size.height), edges: self.edges)
					.foregroundColor(.black)
                if self.boardCase.piece != nil {
                    Circle()
                        .padding(min(geo.size.width, geo.size.height) * 0.05)
                        .foregroundColor(self.boardCase.piece == .black ? .black : .white)
                        .shadow(radius: 3)
                }
                Rectangle().frame(width: geo.size.width, height: geo.size.height).opacity(0.001)
            }.onTapGesture {
                if self.boardCase.piece == nil {
                    _ = try? self.game.takeTurn(self.boardCase)
                }
            }
        }
    }
}

#if DEBUG
struct BoardCaseView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
			BoardCaseView(boardCase: Game.BoardCase(index: (0, 3)))
				.environment(\.colorScheme, .dark)
			BoardCaseView(boardCase: Game.BoardCase(index: (1, 1)))
                .environment(\.colorScheme, .light)

		}
			.frame(width: 200, height: 200)
			.background(Image("boardBackground"))
			.environmentObject(Game.testData)
    }
}
#endif

struct Cross: View {
	let size: CGFloat
	var edges: Edge.Set = .all
	var body: some View {
		Path { path in
			let width = size
			let height = width
			let penWidth = width / 20

			CrossParameters.rectangle.forEach {
				if !edges.contains(.init($0.edge)) { return }
				path.addRect(
					.init(
						x: width * $0.xFactors.0 + penWidth * $0.xFactors.1,
						y: height * $0.yFactors.0 + penWidth * $0.yFactors.0,
						width: width * $0.useWidth.0 + penWidth * $0.useWidth.1,
						height: height * $0.useHeight.0 + penWidth * $0.useHeight.1
					)
				)
			}
		}
	}
}
