//
//  MultipleVerticalAnimation.swift
//  AJMSlideAnimator
//
//  Created by Angel Jesse Morales Karam Kairuz on 03/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import Foundation
import UIKit

struct MultipleVerticalAnimation : AJMAnimatable {

    let rect : CGRect
    let mainImageView : UIImageView
    let numberOfSlides = 3
    var imageViews : [UIImageView] = []
    
    init(rect : CGRect, imageView : UIImageView) {
        
        func setupImageViewsUsingWidth(width : CGFloat, height : CGFloat) -> [UIImageView] {
            
            var imageViews : [UIImageView] = []
            var counter  = 0
            
            while counter < numberOfSlides {
                let aWidth = (counter == 0) ? CGFloat(width) : CGFloat(counter) * width
                let rect = CGRect(x: CGFloat(counter) * width, y: 0, width: aWidth, height: height)
                let temp = UIImageView(frame: rect)
                mainImageView.addSubview(temp)
                counter += 1
                imageViews.append(temp)
            }
            return imageViews
        }
        
        self.rect = rect
        self.mainImageView = imageView
        
        let width = CGFloat(rect.width) / CGFloat(numberOfSlides)
        let height = CGFloat(rect.height)
        
        imageViews = setupImageViewsUsingWidth(width: width, height: height)
        
    }
    
    func prepareContent() {
        
        guard let image = mainImageView.image else { return }
        
        var images : [UIImage] = []
        
        var index = 0
        while index < numberOfSlides {
            if index == 0 {
                // set the first image
                let firstComp = CGSize(width: rect.width / CGFloat(numberOfSlides), height: rect.height)
                UIGraphicsBeginImageContext(firstComp)
                mainImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
                let firstHalf = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                //first!.image = firstHalf
                images.append(firstHalf!)
                if let tempImageView = mainImageView.subviews[index] as? UIImageView {
                    tempImageView.image = firstHalf
                }
                //imageViews[temp].image = firstHalf
                
            } else {
                
                let imageView = imageViews[index]
                UIGraphicsBeginImageContext(imageView.frame.size)
                let currentContext = UIGraphicsGetCurrentContext()
                currentContext!.clip( to: mainImageView.bounds)
                let drawRect = CGRect(x: -imageView.frame.origin.x,
                                      y: -imageView.frame.origin.y,
                                      width: rect.width,
                                      height: rect.height)
                
                currentContext?.draw(image.cgImage!, in: drawRect)
                
                currentContext!.translateBy(x: 0, y: rect.height)
                currentContext!.scaleBy(x: 1, y: -1);
                
                let finalRect = CGRect(x: -imageView.frame.origin.x,
                                       y: -imageView.frame.origin.y,
                                       width: rect.width,
                                       height: rect.height)
                
                currentContext?.draw((image.cgImage)!, in: finalRect)
                
                //pull the second image from our cropped context
                let cropped = UIGraphicsGetImageFromCurrentImageContext();
                
                //pop the context to get back to the default
                UIGraphicsEndImageContext();
                images.append(cropped!)
                // imageViews[temp].image = cropped
                if let tempImageView = mainImageView.subviews[index] as? UIImageView {
                    tempImageView.image = cropped
                }
                
            }
            index += 1
        }
        
    }
    
    func animate(completion : @escaping (Bool) -> ()) {

        var endFrame : CGRect = CGRect.zero
        var endFrams : [CGRect] = []
        
        var y = 0
        for view in mainImageView.subviews {
            if let imgView = view as? UIImageView {
                if y % 2 == 0 {
                    endFrame = CGRect(x: imgView.frame.origin.x, y: (imgView.frame.height), width: (imgView.frame.width), height: (imgView.frame.height))
                    endFrams.append(endFrame)
                } else {
                    endFrame = CGRect(x: imgView.frame.origin.x, y: (imgView.frame.height) * -1, width: (imgView.frame.width), height: (imgView.frame.height))
                    endFrams.append(endFrame)
                }
                
            }
            y += 1
        }
        
        mainImageView.image = nil
        
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveLinear, animations: {
            
            var x = 0
            while x < self.numberOfSlides {
                for view in self.mainImageView.subviews {
                    if let imgView = view as? UIImageView {
                        imgView.frame = endFrams[x]
                    }
                    x += 1
                }
                
            }
            
        }) { (completed) in
            for aView in (self.mainImageView.subviews) {
                aView.removeFromSuperview()
            }
            completion(true)
            
        }

        
    }

}
