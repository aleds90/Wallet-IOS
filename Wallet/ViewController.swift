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
         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.launchAlert))
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
    
    func launchAlert(){
        // Example of using the view to add two text fields to the alert
        // Create the subview
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        
        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)
        
        // Creat the subview
        let subview = UIView(frame: CGRectMake(0,0,216,110))
        let x = (subview.frame.width - 180) / 2

        // Add textfield 1
        let textfield1 = UITextField(frame: CGRectMake(x, 10,180,25))
        textfield1.layer.borderColor = UIColor.purpleColor().CGColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Nome"
        textfield1.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield1)
        
        // Add textfield 2
        let textfield2 = UITextField(frame: CGRectMake(x,textfield1.frame.maxY + 10,180,25))
        textfield2.secureTextEntry = true
        textfield2.layer.borderColor = UIColor.purpleColor().CGColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = UIColor.purpleColor().CGColor
        textfield2.placeholder = "Importo"
        textfield2.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield2)
        
        // Add textfield 3
        let textfield3 = UITextField(frame: CGRectMake(x,textfield2.frame.maxY + 10,180,25))
        textfield3.secureTextEntry = true
        textfield3.layer.borderColor = UIColor.purpleColor().CGColor
        textfield3.layer.borderWidth = 1.5
        textfield3.layer.cornerRadius = 5
        textfield3.layer.borderColor = UIColor.purpleColor().CGColor
        textfield3.placeholder = "Tipo conto"
        textfield3.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield3)
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        
        alert.addButton("Annulla"){
            print("annulla")

        }
        alert.addButton("Crea") {
            print("creato")
        }
        
        alert.showEdit("Conto", subTitle: "Aggiungi un conto!")
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

