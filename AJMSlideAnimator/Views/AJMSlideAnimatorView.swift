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
    case Tile(Int, Int)
}

class AJMSlideAnimatorView : UIView {
    
    var imageView : UIImageView?
    
    var animator : AJMAnimatable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareImageView()
        addGesture()
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
        addGesture()
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AJMSlideAnimatorView.didTap(tap:)))
        self.addGestureRecognizer(tap)
    }
    
    func didTap(tap : UITapGestureRecognizer) {
        print("Tap")
    }
    
    func addSource(image : UIImage, usingStyle style: AJMSlideAnimatorStyle) {
        imageView?.image = image
        imageView?.contentMode = .scaleAspectFill
        
        for aView in (imageView?.subviews)! {
            aView.removeFromSuperview()
        }
        
        switch style {
        case .Horizontal:
            animator = SimpleHorizontalAnimation(rect: self.bounds, imageView: imageView!)
            break
        case .Vertical:
            animator = SimpleVerticalAnimation(rect: self.bounds, imageView: imageView!)
            break
        case .Tile(let rows,let columns):
            animator = FlipTileAnimation(rows: rows , columns: columns, aRect: self.bounds, imageView: imageView!)
            break
  
        }

        guard let animator = animator else { return }
        animator.prepareContent()
        
    }

    func animate(completion : @escaping (Bool) -> ()){
        animator?.animate(completion: completion)
    }


    
}
