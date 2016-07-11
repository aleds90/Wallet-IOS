//
//  HomeViewController.swift
//  Wallet
//
//  Created by Estia on 11/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPageViewControllerDataSource {

    
    var pageImages:NSArray!
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageImages = NSArray(objects: "meal1", "meal2", "meal3")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyPageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        let initialContentViewController = self.pageTutorialAtIndex(0) as HomeHolderViewController
        let viewControllers = NSArray(objects:  initialContentViewController)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController] , direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-300)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipButtonTapped(sender: AnyObject) {
        let nextView: DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appdelegate.window!.rootViewController = nextView
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        let viewController = viewController as! HomeHolderViewController
        var index = viewController.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.pageTutorialAtIndex(index)
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        let viewController = viewController as! HomeHolderViewController
        var index = viewController.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        index += 1
        if (index == pageImages.count) {
            return nil
        }
        return self.pageTutorialAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return pageImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageTutorialAtIndex(index: Int) -> HomeHolderViewController{
        let  pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentHolderViewController") as! HomeHolderViewController
        
        pageContentViewController.imageFileName = pageImages[index] as! String
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }


}
