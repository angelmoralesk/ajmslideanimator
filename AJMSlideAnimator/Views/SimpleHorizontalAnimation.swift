//
//  SimpleHorizontalAnimation.swift
//  AJMSlideAnimator
//
//  Created by Angel Jesse Morales Karam Kairuz on 02/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

struct SimpleHorizontalAnimation : AJMAnimatable {
    
    let rect : CGRect
    let mainImageView : UIImageView
    var compOne : UIImageView
    var compTwo : UIImageView
    
    init(rect : CGRect, imageView :UIImageView) {
        self.rect = rect
        self.mainImageView = imageView
        
        let width = CGFloat(rect.width)
        let height = CGFloat(rect.height)/2
        
        let firstRect = CGRect(x: 0, y: 0, width: width, height: height)
        compOne = UIImageView(frame: firstRect)
        
        let secondRect = CGRect(x: 0, y: height, width: width, height: height)
        compTwo = UIImageView(frame: secondRect)
    }
    
    func prepareContent() {
        
        guard let image = mainImageView.image else { return }
        
        let first = compOne
        let second = compTwo
        
        // add them to the main imageView
        mainImageView.addSubview(first)
        mainImageView.addSubview(second)

        // set the first image
        let halfSize = CGSize(width: rect.width, height: rect.height / 2)
        UIGraphicsBeginImageContext(halfSize)
        mainImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let firstHalf = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        first.image = firstHalf
        
        // set the second image
        UIGraphicsBeginImageContext(second.frame.size)
        let currentContext = UIGraphicsGetCurrentContext()
        
        currentContext!.clip( to: mainImageView.bounds)
        let drawRect = CGRect(x: -compTwo.frame.origin.x,
                              y: -compTwo.frame.origin.x,
                              width: rect.width,
                              height: rect.height)
        
        currentContext?.draw(image.cgImage!, in: drawRect)
        
        currentContext!.translateBy(x: 0, y: rect.height/2)
        currentContext!.scaleBy(x: 1, y: -1);
        
        currentContext?.draw((image.cgImage)!, in: drawRect)
        
        //pull the second image from our cropped context
        let cropped = UIGraphicsGetImageFromCurrentImageContext();
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
        
        second.image = cropped

    }
    
    func animate(completion : @escaping (Bool) -> ()) {
        
        var firstEndFrame : CGRect = CGRect.zero
        var secondEndFrame : CGRect = CGRect.zero
        
        firstEndFrame = CGRect(x: compOne.frame.width, y: 0, width: compOne.frame.width, height: compOne.frame.height)
        secondEndFrame = CGRect(x: compTwo.frame.width * -1 , y: compTwo.frame.height , width: compTwo.frame.width, height: compTwo.frame.height)
        
        mainImageView.image = nil
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveLinear, animations: {
            
            self.compOne.frame = firstEndFrame
            self.compTwo.frame = secondEndFrame
            
        }) { (completed) in
            self.compOne.removeFromSuperview()
            self.compTwo.removeFromSuperview()
            completion(true)
            
        }
        
        
    }

}
