//
//  CaroulselView.swift
//  RNCarousel
//
//  Created by Nguyen Hoang on 6/18/19.
//  Copyright © 2019 fh. All rights reserved.
//

import UIKit

@IBDesignable
class CaroulselView: UIView,UIScrollViewDelegate {

//  list imageView
    var itemCircular:[UIView] =  []
    
//   list image url
    var itemImageUrl:[String] =  []
    
// scrollView
    var scrollView = UIScrollView()
    
//    page control
    var pageControl = UIPageControl()
    
    var heightScrollView:CGFloat = 0.0
    
//    spacing
    var spacing:CGFloat = 10
    
//   height of paging control
    var heightPagingControl:CGFloat = 30
    
    var currentPage:Int = 0
    
    let widthPrevNextItem:CGFloat = 40
    
//  firt image View
    var firstView:UIImageView = UIImageView()
//  last image view
    var lastView: UIImageView = UIImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        let newWidth = superSize.width + superSize.height
        let newHeight = superSize.height
        let newSize = CGSize(width: newWidth, height: newHeight)
        return newSize
    }
    
    open func commonInit() {
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.frame.size.height - heightPagingControl - spacing, width: self.frame.size.width, height: heightPagingControl))
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        addSubview(pageControl)
        
        heightScrollView = self.frame.size.height - heightPagingControl - 2*spacing
        scrollView = UIScrollView(frame: CGRect(x: widthPrevNextItem, y: 0, width: UIScreen.main.bounds.width - 2*widthPrevNextItem, height: self.frame.size.height - (heightPagingControl + 2*spacing)))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
       
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        
        backgroundColor = .clear
        scrollView.backgroundColor = .clear
        
        
//        setup Swipe Right/Left for UIScrollView
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        scrollView.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        scrollView.addGestureRecognizer(swipeLeft)
        self.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        
    }
    // handle event swipe Left/Right
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                moveScrollView(direction: -1)
                break
            case UISwipeGestureRecognizer.Direction.left:
                moveScrollView(direction: 1)
                break
            default:
                break
            }
        }
    }
    
    // handle action move
    func moveScrollView(direction: Int) {
        
        currentPage = currentPage + direction
        if currentPage == self.itemCircular.count {
            currentPage = 0
            let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
            scrollView.setContentOffset(point, animated: false)
        }
        else if currentPage < 0
        {
            currentPage = self.itemCircular.count - 1
            let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
            scrollView.setContentOffset(point, animated: false)
        }
        else
        {
            let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
            scrollView.setContentOffset(point, animated: true)
        }

        self.updatePageControlWithAnimation()


    }
    
    func setCurrentPage(page: Int)
    {
        currentPage = page
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        self.updatePageControlWithAnimation()
    }
    
    // update page control number and animation
    func updatePageControlWithAnimation() {
        //        // Create a animation to increase the actual icon on screen
        UIView.animate(withDuration: 0.4)
        {
            self.itemCircular[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            for x in 0 ..< self.itemCircular.count
            {
                if (x != self.currentPage) {
                    self.itemCircular[x].transform = CGAffineTransform.init(scaleX: 1.0, y: 0.6)
                }
            }
            if self.currentPage == self.itemCircular.count - 1
            {
                self.lastView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.6)
                self.firstView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.6)
                
            }
            else if self.currentPage == 0
            {
                self.lastView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.6)
                self.firstView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.6)
            }
        }
        pageControl.currentPage = currentPage
    }
    
    func setupData(imageURL:[String])  {
        
        self.itemImageUrl = imageURL
        
        for item in 0..<self.itemImageUrl.count {
            self.itemCircular.append(self.initDataScrollView(index: item))
        }
        
        firstView = self.initDataScrollView(index: -1)
        lastView = self.initDataScrollView(index: self.itemImageUrl.count)

        // setup default page
        pageControl.numberOfPages = self.itemCircular.count
        self.setCurrentPage(page: 2)
        scrollView.contentSize = CGSize(width: CGFloat(self.itemImageUrl.count) * self.frame.width + 2*self.frame.width, height: heightScrollView)
        
    }
    
    func initDataScrollView (index: Int) -> UIImageView {
        
        let width = scrollView.frame.width
        let x = (CGFloat(index) * width)
        let view = UIImageView(frame: CGRect(x: x + spacing, y: 0, width: width - 2*spacing, height: heightScrollView))
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .gray
        scrollView.addSubview(view)
     
        if ( index == -1 )
        {
            view.setCustomImage(self.itemImageUrl[self.itemImageUrl.count - 1])
        }
        else if ( index == self.itemImageUrl.count )
        {
             view.setCustomImage(self.itemImageUrl[0])
        }
        else
        {
            view.setCustomImage(self.itemImageUrl[index])
        }
        return view
        
    }

}
extension UIImageView {
    
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
                self.contentMode = .scaleToFill
            }
        }
    }
}
