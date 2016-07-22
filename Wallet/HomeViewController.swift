//
//  HomeViewController.swift
//  Wallet
//
//  Created by Estia on 11/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView

class HomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    var pageImages:NSArray!
    var pageViewController: UIPageViewController!
    var listaContoCorrente = [ContoCorrente]()
    var tipoContoSelected = "Conto Bancario"
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var listaTipoConto: [String] = ["Conto Bancario", "Conto Paypal", "Conto MoneyBookers", "Conto Neteller", "Altro..."]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContoCorrenteFromCoreData()

        pageImages = NSArray(objects: "amex", "discover", "masterCard", "paypal", "visa")
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyPageViewController") as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let initialContentViewController = self.pageTutorialAtIndex(0) as HomeHolderViewController
        let viewControllers = NSArray(objects:  initialContentViewController)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController] , direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height/2)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.launchAlert))
        self.title = "Conti & Carte"
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
    
    //MARKS: Function for pageViewController
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        let viewController = viewController as! HomeHolderViewController
        var index = viewController.pageIndex as Int
        //titleAtIndex(index)

        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.pageTutorialAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        let viewController = viewController as! HomeHolderViewController
        var index = viewController.pageIndex as Int
        //titleAtIndex(index)

        if (index == NSNotFound) {
            return nil
        }
        index += 1
        if (index == listaContoCorrente.count) {
            
            return nil
        }

        return self.pageTutorialAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return listaContoCorrente.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageTutorialAtIndex(index: Int) -> HomeHolderViewController{
        let  pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentHolderViewController") as! HomeHolderViewController
        pageContentViewController.imageFileName = "amex"
        pageContentViewController.pageIndex = index
        pageContentViewController.nome = listaContoCorrente[index].nome
        pageContentViewController.contoCorrente = listaContoCorrente[index]
        return pageContentViewController
    }
    
    func titleAtIndex(index: Int) {
        self.title = listaContoCorrente[index].nome
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
        } catch { //let error as NSError {
            //print("Could not fetch \(error), \(error.userInfo)")
            print("error inside HomeViewController.getContoCorrenteFromCoreData")
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
}
