# AJMSlideAnimator

AJMSlideAnimatorView is a custom view which takes a UIImage, divides it up to 3 components and then dynamically animates their
dismissal from screen.

## Usage
1. Import the class AJMSlideAnimatorView class in your existing project.

2. Create an IBOutlet to your `animatorView` to your View Controller.

  ```swift
      @IBOutlet weak var animatorView: AJMSlideAnimatorView!
  ```
  
## Simple animation
1.  Set the initial image for you animator view by calling the function addSource sending a UIImage as a parameter and a AJMSlideAnimatorStyle

  ```swift
  let image = UIImage(named: name)!
  var style : AJMSlideAnimatorStyle = .Horizontal
  animatorView.addSource(image: image, usingStyle: style)
  ```

2.  Start animating your view, use the completion handler to perform custom logic

  ```swift
  animatorView.animate(completion: {(completed) in
           
        })
  ``` 
## Multiple animation

1.  Set the initial image for you animator view by calling the function addSource sending a UIImage as a parameter, and a AJMSlideAnimatorStyle and AJMSlide

  ```swift
  let image = UIImage(named: name)!
  let slide : AJMSlide = .Multiple
  animatorView.addSource(image: image, usingStyle: .Vertical, slide : slide)
  ```

2.  Start animating your view, use the completion handler to perform custom logic

  ```swift
  animatorView.animateMultipleComponents(completion: {(completed) in    
        })
   ```
   
## Preview
![](https://media.giphy.com/media/XobhJApmBMNc4/giphy.gif)

## License
MIT
