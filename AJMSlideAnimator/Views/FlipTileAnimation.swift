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
        
        // prepare the frames for the imageViews
        let width = mainImageView.frame.width / CGFloat(columns)
        let height = mainImageView.frame.height / CGFloat(rows)
        
        for i in 0...Int(rows) {
            for j in 0...Int(columns) {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(i)*width, y: CGFloat(j)*height, width: width, height: height))
                imageViews.append(imageView)
            }
        }
    }
    
    func prepareContent() {
        
        guard let image = mainImageView.image else { return }
        
        for i in 0..<imageViews.count {
            let croppedImage = cropImage(imageToCrop: image, toRect: imageViews[i].frame)
            print("Hola")
        }
        
    }
    
    func animate(completion: @escaping (Bool) -> ()) {
        
    }
    
    func cropImage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage{
        
        let imageRef:CGImage = imageToCrop.cgImage!.cropping(to: rect)!
        let cropped:UIImage = UIImage(cgImage:imageRef)
        return cropped
    }
}
