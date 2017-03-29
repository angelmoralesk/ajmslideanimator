//
//  ViewController.swift
//  AJMSlideAnimator
//
//  Created by Angel Morales @TheKairuz on 12/03/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatorView: AJMSlideAnimatorView!
    private let images = ["eiffel.jpg", "museo.jpg", "usapool.jpg"]
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animatorView.center = self.view.center
       
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
     
        var style :AJMSlideAnimatorStyle = .Horizontal
        if index % 2 == 0 {
            style = .Vertical
        }
        let name = images[index]
        let image = UIImage(named: name)!
        
        animatorView.addSource(image: image, usingStyle: style)
        animatorView.animate(completion: {(completed) in
            self.index += 1
            if self.index > self.images.count - 1 {
                self.index = 0
            }
        })

        
      
    }

    @IBAction func useMultipleSlideAnimation(_ sender: Any) {
        
        let name = images[index]
        let image = UIImage(named: name)!
        
        let slide : AJMSlide = .Multiple
        animatorView.addSource(image: image, usingStyle: .Vertical, slide : slide)
        animatorView.animateMultipleComponents(completion:{ (completed) in
            
            self.index += 1
            if self.index > self.images.count - 1 {
                self.index = 0
            }
        })
    
    }
}

