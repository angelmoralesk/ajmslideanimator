//
//  AJMSlideAnimatorView.swift
//  AJMSlideAnimator
//
//  Created by Angel Morales @TheKairuz on 12/03/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
///

import UIKit

enum AJMSlideAnimatorStyle {
    case Horizontal
    case Vertical
}

enum AJMSlide : Int {
    case Simple = 1
    case Multiple = 3
}

class AJMSlideAnimatorView : UIView {
    
    var imageView : UIImageView?
    
    var slide : AJMSlide?
    var animator : AJMAnimatable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareImageView()
    }
    
    func prepareImageView(){
        imageView = UIImageView(frame: self.bounds)
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareImageView()
    }
    
    func addSource(image : UIImage, usingStyle style: AJMSlideAnimatorStyle) {
        imageView?.image = image
        imageView?.contentMode = .scaleAspectFill
        
        for aView in (imageView?.subviews)! {
            aView.removeFromSuperview()
        }

        animator = FlipTileAnimation(rows: 10, columns: 10, aRect:  self.bounds, imageView: imageView!)
        animator?.prepareContent()
        
    }
    
    func addSource(image : UIImage, usingStyle style: AJMSlideAnimatorStyle, slide : AJMSlide = .Simple) {
  
        imageView?.image = image
        imageView?.contentMode = .scaleAspectFill
        
        animator = MultipleVerticalAnimation(rect: self.bounds, imageView: imageView!)
        animator?.prepareContent()
        
    }

    func animate(completion : @escaping (Bool) -> ()){
        animator?.animate(completion: completion)
    }
    
    func animateMultipleComponents(completion : @escaping (Bool) -> ()){
        animator?.animate(completion: completion)
    }

    
}
