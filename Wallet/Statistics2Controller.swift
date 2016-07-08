//
//  Statistics2Controller.swift
//  Wallet
//
//  Created by Estia on 08/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit
import Charts

class Statistics2Controller: UIViewController, ChartViewDelegate {

    @IBOutlet var pieChartView: PieChartView!
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["Benzina", "Bollette", "Uscite", "Altro"]
        let unitsSold = [200.0, 41.0, 16.0, 130.0]
        
        setPieChart(months, values: unitsSold)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setPieChart(dataPoints: [String], values: [Double]){
        pieChartView.noDataText = "You need to provide data for the chart."
        pieChartView.descriptionText = ""
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
