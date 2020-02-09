//
//  GameView.swift
//  Gomoku
//
//  Created by Tony on 1/28/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import SwiftUI
import Combine

struct GameView: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(game.currentBoardState, id: \.first?.id) { row in
                    HStack(spacing: 0) {
                        ForEach(row) { boardCase in
                            BoardCaseView(boardCase: boardCase)
                                
                        }
                    }
                }
            }
			.padding()
			.background(Image("boardBackground").resizable())
            .aspectRatio(1, contentMode: .fit)
    }
}

#if DEBUG
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
			.environmentObject(Game.testData)
    }
}
#endif
   
