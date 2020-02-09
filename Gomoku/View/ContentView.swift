//
//  ContentView.swift
//  Gomoku
//
//  Created by Tony on 1/28/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var game: Game

    var body: some View {
		GameView()
			.cornerRadius(5)
			.shadow(radius: 20)
			.rotation3DEffect(Angle(degrees: 2), axis: (x: 1, y: 0, z: 0))
			.edgesIgnoringSafeArea(.all)
			.padding(35)
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
			.background(Image("background")
				.resizable()
				.edgesIgnoringSafeArea(.all)
				.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.environmentObject(Game.testData)
    }
}
