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
    var style : AJMSlideAnimatorStyle = .Vertical
    var slide : AJMSlide?
    var imageViews : [UIImageView]?
    
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
        
        //animator = SimpleVerticalAnimation(rect: self.bounds, imageView: imageView!)
        animator = SimpleHorizontalAnimation(rect: self.bounds, imageView: imageView!)
        animator?.prepareContent()
        
        //self.style = style
        //setupComponents()
    }
    
    func addSource(image : UIImage, usingStyle style: AJMSlideAnimatorStyle, slide : AJMSlide = .Simple) {
        
        if style == .Horizontal && slide == .Multiple {
            assertionFailure("Under construction!")
        }
        imageView?.image = image
        imageView?.contentMode = .scaleAspectFill
        self.style = style
        self.slide = slide
        setupComponents(comp: slide.rawValue)
        
    }

    func setupComponents(comp : Int) {
        
        let image = self.imageView?.image!
        
        var width : CGFloat = CGFloat(0)
        var height : CGFloat = CGFloat(0)
        
        if style == .Vertical {
            width = CGFloat(self.bounds.width) / CGFloat(comp)
            height = CGFloat(self.bounds.height)
            
            var imageViews : [UIImageView] = []
            var bounds  = 0
            while bounds < comp {
                let myWidth = (bounds == 0) ? CGFloat(width) : CGFloat(bounds) * width
                let rect = CGRect(x: CGFloat(bounds) * width, y: 0, width: myWidth, height: height)
                let temp = UIImageView(frame: rect)
                self.imageView?.addSubview(temp)
                bounds += 1
                imageViews.append(temp)
            }
            
            
            var images : [UIImage] = []
            
            var temp = 0
            while temp < comp {
                if temp == 0 {
                    // set the first image
                    let firstComp = CGSize(width: self.bounds.width / CGFloat(comp), height: self.bounds.height)
                    UIGraphicsBeginImageContext(firstComp)
                    self.imageView?.layer.render(in: UIGraphicsGetCurrentContext()!)
                    let firstHalf = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    //first!.image = firstHalf
                    images.append(firstHalf!)
                    if let tempImageView = self.imageView?.subviews[temp] as? UIImageView {
                        tempImageView.image = firstHalf
                    }
                    //imageViews[temp].image = firstHalf

                } else {
                    let imageView = imageViews[temp]
                    UIGraphicsBeginImageContext(imageView.frame.size)
                    let currentContext = UIGraphicsGetCurrentContext()
                    currentContext!.clip( to: (self.imageView?.bounds)!)
                    let drawRect = CGRect(x: -imageView.frame.origin.x,
                                          y: -imageView.frame.origin.y,
                                          width: self.bounds.width,
                                          height: self.bounds.height)
                    
                    currentContext?.draw((image?.cgImage)!, in: drawRect)
                    
                    currentContext!.translateBy(x: 0, y: self.bounds.height)
                    currentContext!.scaleBy(x: 1, y: -1);
                    
                    let finalRect = CGRect(x: -imageView.frame.origin.x,
                                          y: -imageView.frame.origin.y,
                                          width: self.bounds.width,
                                          height: self.bounds.height)
                    
                    currentContext?.draw((image?.cgImage)!, in: finalRect)
                    
                    //pull the second image from our cropped context
                    let cropped = UIGraphicsGetImageFromCurrentImageContext();
                    
                    //pop the context to get back to the default
                    UIGraphicsEndImageContext();
                    images.append(cropped!)
                   // imageViews[temp].image = cropped
                    if let tempImageView = self.imageView?.subviews[temp] as? UIImageView {
                        tempImageView.image = cropped
                    }

                }
                temp += 1
            }

            
            print(images.count)
            self.imageViews = imageViews
            
        }
        
    }
    
    func animate(completion : @escaping (Bool) -> ()){
        animator?.animate(completion: completion)
    }
    
    func animateMultipleComponents(completion : @escaping (Bool) -> ()){
        
        if slide != .Multiple {
            return
        }
        
        let components = slide?.rawValue
        
        var endFrame : CGRect = CGRect.zero
        
        var endFrams : [CGRect] = []
        var y = 0
        for view in (self.imageView?.subviews)! {
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

        imageView?.image = nil
        
        if let p = self.imageView?.subviews as? [UIImageView] {
           
        }
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveLinear, animations: {
            
            var x = 0
            while x < components! {
                for view in (self.imageView?.subviews)! {
                    if let imgView = view as? UIImageView {
                        imgView.frame = endFrams[x]
                    }
                    x += 1
                }
                
            }
            
        }) { (completed) in
            for aView in (self.imageView?.subviews)! {
               aView.removeFromSuperview()
            }
            completion(true)
            
        }
    }

    
}
