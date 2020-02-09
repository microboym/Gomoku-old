//
//  CellView.swift
//  Gomoku
//
//  Created by Tony on 1/28/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import SwiftUI

struct CellView: View {
    var pieceColor: Color? = nil
    var edges: [CrossEdge] = [.top, .bottom, .left, .right]
    var body: some View {
        ZStack {
            Cross(edges)
            if pieceColor != nil {
                Circle()
                    .padding(6.5)
                    .foregroundColor(pieceColor)
                    .shadow(radius: 3)
            }
        }
        .background(Color(red: 0.8627450980392157, green: 0.7019607843137254, blue: 0.3568627450980392))
        .frame(maxWidth: 70, maxHeight: 70)
    }
}

#if DEBUG
struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CellView(pieceColor: .black)
            CellView(pieceColor: .white)
            CellView(pieceColor: nil)
            HStack (spacing: 0){
                CellView(pieceColor: .black, edges: [.bottom, .right])
                CellView(pieceColor: nil, edges: [.bottom, .left, .right])
                CellView(pieceColor: .white, edges: [.bottom, .left])
            }
        }
    }
}
#endif

struct Cross: View {
    private var edges: [Bool]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if edges[CrossEdge.top.rawValue] {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxWidth: 3)
                } else {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxWidth: 3)
                        .hidden()
                }
                if edges[CrossEdge.bottom.rawValue] {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxWidth: 3)
                } else {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxWidth: 3)
                        .hidden()
                }
            }
            HStack(spacing: 0) {
                if edges[CrossEdge.left.rawValue] {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxHeight: 3)
                } else {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxHeight: 3)
                        .hidden()
                }
                if edges[CrossEdge.right.rawValue] {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxHeight: 3)
                } else {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxHeight: 3)
                        .hidden()
                }
            }
        }
    }
    
    init(_ edges: [CrossEdge]) {
        self.edges = [false, false, false, false]
        for edge in edges {
            self.edges[edge.rawValue] = true
        }
    }
}

enum CrossEdge: Int {
    case left = 0, right, top, bottom
}
