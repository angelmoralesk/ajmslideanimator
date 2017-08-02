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
    let style : AJMSlideAnimatorStyle
    
    init(rect : CGRect, imageView :UIImageView, style :AJMSlideAnimatorStyle) {
        self.rect = rect
        self.mainImageView = imageView
        self.style = style
    }
    
    func prepareImageViews() {
        
    }
    
    
}
