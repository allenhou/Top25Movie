//
//  Rating.swift
//  Movie
//
//  Created by Allen Hou on 10/2/18.
//  Copyright © 2018 nEmmY. All rights reserved.
//

import UIKit

class Rating: UILabel {
    
    var unit: CGFloat = 0
    let totalStars = 5
    var rating = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.width
        unit = width / CGFloat(totalStars)
    }
    
    func showRatingfor(location: CGPoint) {
        var star = ""
        rating = Int(floor(location.x / unit))
        for i in 0...4{
            if i > rating {
                star += "☆"
            } else {
                star += "★"
            }
        }
        self.text = star
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        showRatingfor(location: location!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        showRatingfor(location: location!)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
