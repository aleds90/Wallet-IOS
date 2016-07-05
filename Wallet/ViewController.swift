//
//  ViewController.swift
//  Wallet
//
//  Created by Estia on 04/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import CoreData
import UIKit
import SCLAlertView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARKS: Properties
    
    var listaContoCorrente = [ContoCorrente]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //MARKS: Override UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create navigation bar item for add new object to the tableview
         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.addNewItem))
        // Set the title of the view
        title = "I tuoi conti"
        // Populate listaContoCorrente
        getContoCorrenteFromCoreData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARKS: Override UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellView", forIndexPath: indexPath) as! CellViewController
        
        return cell
    }
    
    //MARKS: Fuctions
    
    func addNewItem(){
        //TO-DO Deve creare l alert per inserire nuovi conti.
    }
    
    func getContoCorrenteFromCoreData() {
        let fetchRequest = NSFetchRequest(entityName: "ContoCorrente")
        listaContoCorrente.removeAll()
        do {
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as?[ContoCorrente]{
                if(results.count>0){
                    for item in results {
                        listaContoCorrente.append(item)
                    }
                }else {
                    print("list is empty")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

}

