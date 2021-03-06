//
//  AppDelegate.swift
//  Wallet
//
//  Created by Estia on 04/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit
import CoreData
import FoldingTabBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        createParam()
        let defaults = NSUserDefaults.standardUserDefaults()
        if (!defaults.boolForKey("firstLogin")) {
            preloadData()
        }
        setupToolbar()
        setupNavigationBar()
    
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.backgroundColor = UIColor(
            red: 72.0/255.0,
            green: 211.0/255.0,
            blue: 178.0/255.0,
            alpha: 1
        )
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.alemarco.Wallet" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Wallet", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    func createParam() {
        let defaults = NSUserDefaults.standardUserDefaults()
            if (defaults.boolForKey("firstLogin") as Bool?) != nil{
            
            }else{
                defaults.setBool(false, forKey: "firstLogin")
            }
    }
  
    func preloadData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "firstLogin")

        let listaTipoConto: [String] = ["Conto Bancario", "Conto Paypal", "Conto MoneyBookers", "Conto Neteller", "Altro..."]
        for item in listaTipoConto {
            TipoConto.createInManagedObjectContext(managedObjectContext, nome: item)
        }
        
        let listaCausali: [String] = [ "Carburante", "Spesa", "Prelievi", "Shopping", "Ristoranti"]
        for item in listaCausali{
            Causale.createInManagedObjectContext(managedObjectContext, nome: item)
        }
    }
    
    
    
    func removeData(){
        let fetchRequest = NSFetchRequest(entityName: "TipoConto")
        do {
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as?[TipoConto]{
                
                if(results.count>0){
                    for logitem in results {
                        managedObjectContext.deleteObject(logitem)
                    }
                    
                } else {
                    print("la lista è vuota")
                }
                
                
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    func setupNavigationBar(){
        UINavigationBar.appearance().barTintColor = UIColor(
            red: 72.0/255.0,
            green: 211.0/255.0,
            blue: 178.0/255.0,
            alpha: 1
        )
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
    }
    
    func setupToolbar(){
        if let tabBarController = window?.rootViewController as? YALFoldingTabBarController {
            //leftBarItems
            let firstItem = YALTabBarItem(
                itemImage: UIImage(named: "ic_event_note_white")!,
                leftItemImage: nil,
                rightItemImage: nil
            )
            let secondItem = YALTabBarItem(
                itemImage: UIImage(named: "ic_trending_up_white")!,
                leftItemImage: nil,
                rightItemImage: nil
            )
            tabBarController.leftBarItems = [firstItem, secondItem]
            //rightBarItems
            
            let thirdItem = YALTabBarItem(
                itemImage: UIImage(named: "ic_golf_course_white")!,
                leftItemImage: nil,
                rightItemImage: nil
            )
    
            let forthItem = YALTabBarItem(
                itemImage: UIImage(named: "settings_icon")!,
                leftItemImage: nil,
                rightItemImage: nil
            )
    
            tabBarController.rightBarItems = [thirdItem, forthItem]
            
            tabBarController.tabBarView.tabBarColor = UIColor(
                red: 72.0/255.0,
                green: 211.0/255.0,
                blue: 178.0/255.0,
                alpha: 1
            )
            tabBarController.centerButtonImage = UIImage(named: "ic_add_white")
            
            tabBarController.tabBarView.dotColor = UIColor(
                red: 94.0/255.0,
                green: 91.0/255.0,
                blue: 149.0/255.0,
                alpha: 1
            )
            
            
        }
    }
}



