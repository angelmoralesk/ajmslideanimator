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

class AJMSlideAnimatorView : UIView {
    
    var imageView : UIImageView?
    private var compOne : UIView?
    private var compTwo : UIView?
    var style : AJMSlideAnimatorStyle = .Vertical

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        addSubview(imageView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imageView = UIImageView(frame: self.bounds)
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        addSubview(imageView!)
    }
    
    func addSource(image : UIImage, usingStyle style: AJMSlideAnimatorStyle) {
        imageView?.image = image
        imageView?.contentMode = .scaleAspectFill
        self.style = style
        setupComponents()
    }
    
    func setupComponents() {
        
        // setting the area for the 2 rects
        let image = self.imageView?.image!
        
        var width : CGFloat = CGFloat(0)
        var height : CGFloat = CGFloat(0)
        
        var firstRect : CGRect = CGRect.zero
        var secondRect : CGRect = CGRect.zero
        
        var first : UIImageView?
        var second : UIImageView?
        
        if style == .Vertical {
            width = CGFloat(self.bounds.width)/2
            height = CGFloat(self.bounds.height)
            
            firstRect = CGRect(x: 0, y: 0, width: width, height: height)
            first = UIImageView(frame: firstRect)
            
            secondRect = CGRect(x: width, y: 0, width: width, height: height)
            second = UIImageView(frame: secondRect)
            
            // add them to the main imageView
            imageView?.addSubview(first!)
            imageView?.addSubview(second!)
            
            // set the first image
            let halfSize = CGSize(width: self.bounds.width / 2 , height: self.bounds.height)
            UIGraphicsBeginImageContext(halfSize)
            self.imageView?.layer.render(in: UIGraphicsGetCurrentContext()!)
            let firstHalf = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            first!.image = firstHalf
            
            // set the second image
            UIGraphicsBeginImageContext(second!.frame.size)
            let currentContext = UIGraphicsGetCurrentContext()
            currentContext!.clip( to: (self.imageView?.bounds)!)
            let drawRect = CGRect(x: -secondRect.origin.x,
                                  y: -secondRect.origin.y,
                                  width: self.bounds.width,
                                  height: self.bounds.height)
            
            currentContext?.draw((image?.cgImage)!, in: drawRect)
            
            currentContext!.translateBy(x: 0, y: self.bounds.height)
            currentContext!.scaleBy(x: 1, y: -1);
            
            currentContext?.draw((image?.cgImage)!, in: drawRect)
            
            //pull the second image from our cropped context
            let cropped = UIGraphicsGetImageFromCurrentImageContext();
            
            //pop the context to get back to the default
            UIGraphicsEndImageContext();
            
            second!.image = cropped
            
            compOne = first
            compTwo = second

        
        } else {
            width = CGFloat(self.bounds.width)
            height = CGFloat(self.bounds.height)/2
            
            firstRect = CGRect(x: 0, y: 0, width: width, height: height)
            first = UIImageView(frame: firstRect)
            
            secondRect = CGRect(x: 0, y: height, width: width, height: height)
            second = UIImageView(frame: secondRect)
            
            // add them to the main imageView
            imageView?.addSubview(first!)
            imageView?.addSubview(second!)
            
            // set the first image
            let halfSize = CGSize(width: self.bounds.width, height: self.bounds.height / 2)
            UIGraphicsBeginImageContext(halfSize)
            self.imageView?.layer.render(in: UIGraphicsGetCurrentContext()!)
            let firstHalf = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            first!.image = firstHalf
            
            // set the second image
            UIGraphicsBeginImageContext(second!.frame.size)
            let currentContext = UIGraphicsGetCurrentContext()
            
            currentContext!.clip( to: (self.imageView?.bounds)!)
            let drawRect = CGRect(x: -secondRect.origin.x,
                                  y: -secondRect.origin.x,
                                  width: self.bounds.width,
                                  height: self.bounds.height)
            
            currentContext?.draw((image?.cgImage)!, in: drawRect)
            
            currentContext!.translateBy(x: 0, y: self.bounds.height/2)
            currentContext!.scaleBy(x: 1, y: -1);
            
            currentContext?.draw((image?.cgImage)!, in: drawRect)

            //pull the second image from our cropped context
            let cropped = UIGraphicsGetImageFromCurrentImageContext();
            
            //pop the context to get back to the default
            UIGraphicsEndImageContext();
            
            second!.image = cropped
            
            compOne = first
            compTwo = second

        }
        
        
        
    }
    
    func animate(completion : @escaping (Bool) -> ()){
        
        var firstEndFrame : CGRect = CGRect.zero
        var secondEndFrame : CGRect = CGRect.zero
        
        if style == .Vertical {
            firstEndFrame = CGRect(x: 0, y: (self.compOne?.frame.height)!, width: (self.compOne?.frame.width)!, height: (self.compOne?.frame.height)!)
            secondEndFrame = CGRect(x: (self.compTwo?.frame.origin.x)!, y: (self.compTwo?.frame.height)! * -1, width: (self.compTwo?.frame.width)!, height: (self.compTwo?.frame.height)!)

        } else {
            firstEndFrame = CGRect(x: (self.compOne?.frame.width)!, y: 0, width: (self.compOne?.frame.width)!, height: (self.compOne?.frame.height)!)
            secondEndFrame = CGRect(x: (self.compTwo?.frame.width)! * -1 , y: (self.compTwo?.frame.height)! , width: (self.compTwo?.frame.width)!, height: (self.compTwo?.frame.height)!)

        }
        imageView?.image = nil
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveLinear, animations: {
            
            self.compOne?.frame = firstEndFrame
            
            self.compTwo?.frame = secondEndFrame
            
            
        }) { (completed) in
            self.compOne?.removeFromSuperview()
            self.compTwo?.removeFromSuperview()
            completion(true)
            
        }
    }
}
