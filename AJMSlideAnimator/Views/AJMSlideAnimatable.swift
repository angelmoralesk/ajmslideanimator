//
//  AJMSlideAnimatable.swift
//  AJMSlideAnimator
//
//  Created by Angel Jesse Morales Karam Kairuz on 01/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import Foundation
import UIKit

protocol AJMAnimatable {
    
    func prepareContent()
    func animate(completion : @escaping (Bool) -> ())
}


struct SingleVerticalAnimation : AJMAnimatable {
    
    let rect : CGRect
    let mainImageView : UIImageView
    var compOne : UIImageView
    var compTwo : UIImageView
    
    let style : AJMSlideAnimatorStyle
    
    init(rect : CGRect, imageView :UIImageView, style :AJMSlideAnimatorStyle) {
        self.rect = rect
        self.mainImageView = imageView
        self.style = style
     
        let width = CGFloat(rect.width)/2
        let height = CGFloat(rect.height)
        
        let firstRect = CGRect(x: 0, y: 0, width: width, height: height)
        compOne = UIImageView(frame: firstRect)
        
        let secondRect = CGRect(x: width, y: 0, width: width, height: height)
        compTwo = UIImageView(frame: secondRect)
        
    }
    
    func prepareImageViews() {
        
    }
    
    
}
