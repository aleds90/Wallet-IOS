
//
//  DetailViewController.swift
//  Wallet
//
//  Created by Estia on 08/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//
import CoreData
import UIKit
import SCLAlertView

class DetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var wallet: Wallet!
    var contoDetail: ContoCorrente?
    var nome: String!
    var listaTipoConto: [String] = ["Conto Bancario", "Conto Paypal", "Conto MoneyBookers", "Conto Neteller", "Altro..."]
    var tipoContoSelected = "Conto Bancario"
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var listaCausale: [String] = ["Carburante", "Spesa", "Prelievi", "Shopping", "Ristoranti"]
    var causaleSelected = "Carburante"

    @IBOutlet weak var nomeContoLabel: UILabel!
    @IBOutlet weak var importoContoLabel: UILabel!
    @IBOutlet weak var nomeTipoContoLabel: UILabel!
    @IBOutlet weak var movimentiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(nome)
        title = "Dettaglio"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.launchAlert))
        // Do any additional setup after loading the view.
 
        if let conto = wallet as? ContoCorrente {
            print(conto.nome)
            nomeTipoContoLabel.text = conto.tipoConto?.nome
            movimentiLabel.text = String(conto.listaMovimentoContoCorrente!.count)
        } else {
            print("non è un conto")
        }
        
        if let carta = wallet as? CartaCredito {
            nomeTipoContoLabel.text = carta.contoCorrente?.nome
            movimentiLabel.text = String(carta.listaMovimentoCartaCredito!.count)
        } else {
            print("non è na carta")
        }
        
        
        nomeContoLabel.text = wallet.nome!
        importoContoLabel.text = String(wallet.importo!)
        
        
        
        //nomeTipoContoLabel.text = .tipoConto?.nome
       // movimentiLabel.text = String(contoDetail.listaMovimentoContoCorrente!.count)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            
                let causale = self.getCausaleByName(self.causaleSelected)
                
                if let conto = self.wallet as? ContoCorrente {
                    MovimentoContoCorrente.createInManagedObjectContext(self.managedObjectContext, nome: nome, importo: importo, data: NSDate(), rendicontato: 0, casuale: causale, contoCorrente: conto)
                } else {
                    print("non è un conto")
                }
                
                if let carta = self.wallet as? CartaCredito {
                    MovimentoCartaCredito.createInManagedObjectContext(self.managedObjectContext, nome: nome, importo: importo, data: NSDate(), casuale: causale, cartacredito: carta)
                } else {
                    print("non è na carta")
                }            
                
                //self.getContoCorrenteFromCoreData()
                
            }else{
                SCLAlertView().showError("Errore Crezione", subTitle: "Devi completare entrambi i campi per poter creare un conto!")
            }
        }
        alert.showEdit("Crea Movimento", subTitle: "")
    }
    
    //MARKS: Override UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(_: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView{
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = listaCausale[row]
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "HelveticaNeue", size: 14) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaCausale.count
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 180
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        causaleSelected = listaCausale[row]
    }
    
    //MARKS: Functions
    
    func getCausaleByName(nome: String) -> Causale?{
        let fetchRequest = NSFetchRequest(entityName: "Causale")
        let predicate = NSPredicate(format: "nome = %@", nome)
        fetchRequest.predicate = predicate
        do {
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as?[Causale]{
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
    
    //MARKS: Function TableView
    
    
    //MARKS: Override UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let conto = wallet as? ContoCorrente {
            return conto.listaMovimentoContoCorrente!.count

        } else {
            print("non è un conto")
        }
        
        if let carta = wallet as? CartaCredito {
            return carta.listaMovimentoCartaCredito!.count

        } else {
            print("non è na carta")
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! CellDeatilViewCell
        if let conto = wallet as? ContoCorrente {
            let list = conto.listaMovimentoContoCorrente?.allObjects as! [MovimentoContoCorrente]
            let movimentoContoCorrente = list[indexPath.item]
            cell.nomeLabel.text = movimentoContoCorrente.nome
            cell.importoLabel.text = String(movimentoContoCorrente.importo!)
            cell.causaleLabel.text = movimentoContoCorrente.causale?.nome
            return cell
            
        } else {
            print("non è un conto")
        }

        
        if let carta = wallet as? CartaCredito {
            let list = carta.listaMovimentoCartaCredito!.allObjects as! [MovimentoCartaCredito]
            let movimentoContoCorrente = list[indexPath.item]
            cell.nomeLabel.text = movimentoContoCorrente.nome
            cell.importoLabel.text = String(movimentoContoCorrente.importo!)
            cell.causaleLabel.text = movimentoContoCorrente.causale?.nome
            return cell
            
        } else {
            print("non è na carta")
        }
        //Non dovrebbe arrivaraci mai.
        return cell
 
    }

}
