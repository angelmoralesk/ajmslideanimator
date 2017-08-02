//
//  AJMSlideAnimatable.swift
//  AJMSlideAnimator
//
//  Created by Angel Jesse Morales Karam Kairuz on 01/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import Foundation

protocol AJMAnimatable {
    
    func prepareContent()
    func animate(completion : @escaping (Bool) -> ())
}
