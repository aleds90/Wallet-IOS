//
//  HomeHolderViewController.swift
//  Wallet
//
//  Created by Estia on 11/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit

class HomeHolderViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    var imageFileName: String!
    var pageIndex: Int!
    var nome: String!
    var contoCorrente: ContoCorrente!
    
    @IBOutlet weak var nomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageView.image = UIImage(named: imageFileName)
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(HomeHolderViewController.imageTapped(_:)))
        myImageView.userInteractionEnabled = true
        myImageView.addGestureRecognizer(tapGestureRecognizer)
        nomeLabel.text = nome
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func imageTapped(img: AnyObject)
    {
        let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController
        nextView?.nome = nome
        nextView?.contoDetail = contoCorrente
        self.navigationController?.pushViewController(nextView!, animated: true)
        
        
    }

}
