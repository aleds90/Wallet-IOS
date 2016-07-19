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
import FoldingTabBar

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, YALTabBarDelegate{
    
    //MARKS: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var rowForSegue = 0
    var tipoContoSelected = "Conto Bancario"
    var listaTipoConto: [String] = ["Conto Bancario", "Conto Paypal", "Conto MoneyBookers", "Conto Neteller", "Altro..."]
    var listaContoCorrente = [ContoCorrente]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //MARKS: Override UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create navigation bar item for add new object to the tableview
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.launchAlert))
        
        // Set the title of the view
        title = "Conti e Carte"
        // Populate listaContoCorrente
        getContoCorrenteFromCoreData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Detail") {
            let destinationVC:DetailViewController = segue.destinationViewController as! DetailViewController
            destinationVC.contoDetail = listaContoCorrente[rowForSegue]
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    //MARKS: Override UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaContoCorrente.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellView", forIndexPath: indexPath) as! CellViewController
        let contoCorrente = listaContoCorrente[indexPath.item]
        cell.nomeLabel.text = contoCorrente.nome
        cell.importoLabel.text = String(contoCorrente.importo!)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let contoCorrenteToDelete = listaContoCorrente[indexPath.row]
            listaContoCorrente.removeAtIndex(indexPath.row)
            managedObjectContext.deleteObject(contoCorrenteToDelete)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        rowForSegue = indexPath.row
        
        return indexPath
    }
    //MARKS: Override UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(_: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView{
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = listaTipoConto[row]
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "HelveticaNeue", size: 14) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaTipoConto.count
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 180
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipoContoSelected = listaTipoConto[row]
    }
    //MARKS: Override YALTabBarDelegate
    
    func tabBarWillCollapse(tabBar: YALFoldingTabBar!){
        
    }
    func tabBarWillExpand(tabBar: YALFoldingTabBar!){
    
    }
    func tabBarDidCollapse(tabBar: YALFoldingTabBar!){
    
    }
    func tabBarDidExpand(tabBar: YALFoldingTabBar!){
    
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
        
        // Create the subview
        let subview = UIView(frame: CGRectMake(0,0,216,205))
        let x = (subview.frame.width - 180) / 2
        
        let textfield1 = UITextField(frame: CGRectMake(x, 10,180,25))
        let textfield2 = UITextField(frame: CGRectMake(x,textfield1.frame.maxY + 10,180,25))
        let pickerView = UIPickerView(frame: CGRectMake(x,textfield2.frame.maxY + 10,180,102))
        pickerView.delegate = self
        pickerView.dataSource = self

        // Add textfield nome
      
        textfield1.layer.borderColor = UIColor.purpleColor().CGColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Nome"
        textfield1.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield1)
        
        // Add textfield importo
       
        textfield2.layer.borderColor = UIColor.purpleColor().CGColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = UIColor.purpleColor().CGColor
        textfield2.placeholder = "Importo"
        textfield2.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield2)
        
        // Add picker
        
        pickerView.layer.borderColor = UIColor.purpleColor().CGColor
        pickerView.layer.borderWidth = 1.5
        pickerView.layer.cornerRadius = 5
        pickerView.layer.borderColor = UIColor.purpleColor().CGColor
        subview.addSubview(pickerView)
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        
        alert.addButton("Annulla"){
        }
        alert.addButton("Conferma") {
            if(textfield1.text != "" && textfield2.text != ""){
                let nome:String! = textfield1.text
                let importo:Int! = Int(textfield2.text!)
                let tipoConto = self.getTipoContoByName(self.tipoContoSelected)
                ContoCorrente.createInManagedObjectContext(self.managedObjectContext, nome: nome, importo: importo, tipoconto: tipoConto!)
                self.getContoCorrenteFromCoreData()
                self.tableView.reloadData()
            }else{
                SCLAlertView().showError("Errore Crezione", subTitle: "Devi completare entrambi i campi per poter creare un conto!")
            }
        }
        alert.showEdit("Crea Conto", subTitle: "")
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
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func getTipoContoByName(nome: String) -> TipoConto?{
        let fetchRequest = NSFetchRequest(entityName: "TipoConto")
        let predicate = NSPredicate(format: "nome = %@", nome)
        fetchRequest.predicate = predicate
        do {
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as?[TipoConto]{
                if(results.count>0){
                    return results[0]
                } else {
                   return nil
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return nil
    }
    

}

