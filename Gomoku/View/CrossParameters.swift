//
//  CrossParameters.swift
//  Gomoku
//
//  Created by Tony on 2/5/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation
import SwiftUI

struct CrossParameters {
    struct Segment {
		let edge: Edge
        let useWidth: (CGFloat, CGFloat)
        let xFactors: (CGFloat, CGFloat)
        let useHeight: (CGFloat, CGFloat)
        let yFactors: (CGFloat, CGFloat)
    }
    
    static let rectangle = [
        Segment(
			edge:		.top,
            useWidth:   (0, 1),
            xFactors:   (0.5, -0.5),
            useHeight:  (-0.5, -0.5),
            yFactors:   (0.5, 0.5)
        ),
        Segment(
			edge:		.bottom,
            useWidth:   (0, 1),
            xFactors:   (0.5, -0.5),
            useHeight:  (0.5, 0.5),
            yFactors:   (0.5, 0.5)
        ),
        Segment(
			edge:		.leading,
            useWidth:   (-0.5, -0.5),
            xFactors:   (0.5, 0.5),
            useHeight:  (0, 1),
            yFactors:   (0.5, -0.5)
        ),
        Segment(
			edge:		.trailing,
            useWidth:   (0.5, 0.5),
            xFactors:   (0.5, -0.5),
            useHeight:  (0, 1),
            yFactors:   (0.5, -0.5)
        )
    ]
}
