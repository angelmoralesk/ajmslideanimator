//
//  FlipTileAnimation.swift
//  AJMSlideAnimator
//
//  Created by Angel Jesse Morales Karam Kairuz on 03/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit


struct FlipTileAnimation : AJMAnimatable {
    
    let rect : CGRect
    let mainImageView : UIImageView
    var imageViews : [UIImageView] = []

    init(rows : Int, columns : Int, aRect : CGRect, imageView: UIImageView) {
        self.rect = aRect
        self.mainImageView = imageView
        
        let image = mainImageView.image!
        let size = imageView.frame.size
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: imageView.frame.size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        // prepare the frames for the imageViews
        let width = mainImageView.frame.width / CGFloat(columns)
        let height = mainImageView.frame.height / CGFloat(rows)
        
        let imgWidth = image.size.width / CGFloat(columns)
        let imgHeight = image.size.height / CGFloat(rows)
        
         mainImageView.image = nil
        for i in 0..<Int(rows) {
            for j in 0..<Int(columns) {
                let imgView = UIImageView(frame: CGRect(x: CGFloat(i)*width, y: CGFloat(j)*height, width: width, height: height))
                print("rect \(imgView.frame)")
                
                let imgRect = CGRect(x: CGFloat(i)*imgWidth, y: CGFloat(j)*imgHeight, width: imgWidth, height: imgHeight)

                let croppedImage = cropImage(imageToCrop: image, toRect: imgRect)
                imgView.image = croppedImage
                imageViews.append(imgView)
                mainImageView.addSubview(imgView)
            }
        }
        
        
       
    }
    
    func prepareContent() {
    }
    
    func animateOne(completion: @escaping (Bool) -> ()) {
        
        let snapshot = imageViews[2]
        let destinationView = UIImageView(frame: snapshot.frame)

        let finalFrame = imageViews[2].frame
        
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        mainImageView.layer.sublayerTransform = transform
        self.mainImageView.insertSubview(destinationView, belowSubview: imageViews[2])

        destinationView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0.0, 1.0, 0.0)
        
        UIView.animateKeyframes(
            withDuration: TimeInterval(Int(arc4random_uniform(UInt32(10)))),
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                    snapshot.frame = finalFrame
                })
                
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                    snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 1.0, 0.0)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                    snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, 1.0, 0.0)
                    destinationView.layer.transform = CATransform3DMakeRotation(CGFloat(0), 0.0, 1.0, 0.0)
                })
        },
            completion: { _ in
             
        })
    }
    
    func animate(completion: @escaping (Bool) -> ()) {
        
        for i in 0..<imageViews.count {
            let snapshot = imageViews[i]
            let destinationView = UIImageView(frame: snapshot.frame)
            
            let finalFrame = imageViews[i].frame
            
            var transform = CATransform3DIdentity
            transform.m34 = -0.002
            mainImageView.layer.sublayerTransform = transform
            self.mainImageView.insertSubview(destinationView, belowSubview: imageViews[2])
            
            destinationView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0.0, 1.0, 0.0)
            
            let time = Int32(arc4random_uniform(UInt32(5)))+2
            
            UIView.animateKeyframes(
                withDuration: TimeInterval(abs(time)),
                delay: 0,
                options: .calculationModeCubic,
                animations: {
                    
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                        snapshot.frame = finalFrame
                    })
                    
                    UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                        snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 1.0, 0.0)
                    })
                    
                    UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                        snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(0), 0.0, 1.0, 0.0)
                        destinationView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, 1.0, 0.0)
                    })
            },
                completion: { _ in
                    completion(true)
            })

        }
    
    }
    
    
    func cropImage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage{
        
        let imageRef:CGImage = imageToCrop.cgImage!.cropping(to: rect)!
        let cropped:UIImage = UIImage(cgImage:imageRef)
        return cropped
    }
}
