//
//  PageViewController.swift
//  Doodle
//
//  Created by 신동규 on 2017. 12. 31..
//  Copyright © 2017년 DongkyuShin. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var pageControl = UIPageControl()
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "TutorialLogin", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "1"),
                self.newVc(viewController: "2"),
                self.newVc(viewController: "3"),
                self.newVc(viewController: "4"),
                self.newVc(viewController: "5"),
                self.newVc(viewController: "6")]
    }()
    
    override func viewDidLoad() {
        
        
        
        func configurePageControl() {
            
            let image = UIImage.outlinedEllipse(size: CGSize(width: 7.0, height: 7.0), color: .lightGray)
            pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 25,width: UIScreen.main.bounds.width,height: 0))
            self.pageControl.numberOfPages = orderedViewControllers.count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.white
            
            self.pageControl.pageIndicatorTintColor = UIColor.init(patternImage: image!)
            self.pageControl.currentPageIndicatorTintColor = UIColor(hue: 215/360, saturation: 29/100, brightness: 38/100, alpha: 1.0)
            self.view.addSubview(pageControl)
        }
        self.delegate = self
        configurePageControl()

        self.dataSource = self
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
        }
        super.viewDidLoad()
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        
        guard previousIndex >= 0 else {
            return nil
            
        }
        
      
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
      
        guard orderedViewControllersCount != nextIndex else {
            return nil
            
        }
        

        return orderedViewControllers[nextIndex]
    }
 


   
}
