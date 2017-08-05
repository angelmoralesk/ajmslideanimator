# AJMSlideAnimator

AJMSlideAnimatorView is a custom view which takes an UIImage, divides it up into components and, by using an animation style, it dynamically animates their dismissal from screen. There are 3 different animation styles available: Simple, Vertical and Tile which takes the number of rows and columns.

![Preview](https://media.giphy.com/media/ifVSLf4CIYD7i/giphy.gif)

## Usage

1. Import the class AJMSlideAnimatorView class in your existing project.

2. Create an IBOutlet to your `animatorView` to your View Controller.

  ```swift
      @IBOutlet weak var animatorView: AJMSlideAnimatorView!
  ```
  
## Simple Horizontal and Vertical Animation

1.  Set the initial image for you animator view by calling the function addSource sending a UIImage as a parameter and a AJMSlideAnimatorStyle.

  ```swift
  let image = UIImage(named: name)!
  
  var style : AJMSlideAnimatorStyle = AJMSlideAnimatorStyle.Horizontal // or AJMSlideAnimatorStyle.Vertical 
  animatorView.addSource(image: image, usingStyle: style)
  ```

2.  Start animating your view, use the completion handler to perform custom logic

  ```swift
  animatorView.animate(completion: {(completed) in
           
        })
  ``` 
## Tile Animation

![](http://www.thekairuz.com/blog/wp-content/uploads/2017/08/Captura-de-pantalla-2017-08-05-a-las-2.24.16-p.m..png)

1.  Set the initial image for you animator view by calling the function addSource sending a UIImage as a parameter, and a AJMSlideAnimatorStyle and AJMSlide

  ```swift
  let image = UIImage(named: name)!
  var style : AJMSlideAnimatorStyle = AJMSlideAnimatorStyle.Tile(5, 5) // matrix of 5 X 5
  animatorView.addSource(image: image, usingStyle: style)
  ```

2.  Start animating your view, use the completion handler to perform custom logic

  ```swift
  animatorView.animate(completion: {(completed) in    
        })
   ```


## License
MIT
