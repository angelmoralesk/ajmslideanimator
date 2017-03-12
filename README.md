# AJMSlideAnimator

AJMSlideAnimatorView is a custom view which takes a UIImage, divides it in two components and then dynamically animates their
dismissal from screen.

## Usage
1. Import the class AJMSlideAnimatorView class in your existing project.

2. Create an IBOutlet to your `animatorView` to your View Controller.

  ```swift
      @IBOutlet weak var animatorView: AJMSlideAnimatorView!
  ```
3.  Set the initial image for you animator view by calling the function addSource sending a UIImage as a parameter

  ```swift
  let image = UIImage(named: name)!
  animatorView.addSource(image: image)
  ```
4.  Start animating your view, use the completion handler to perform custom logic

  ```swift
  animatorView.animate(completion: {(completed) in
           
        })
  ``` 

## Preview
![](http://i.giphy.com/2lI68l7PEZnpu.gif)

##License
MIT
