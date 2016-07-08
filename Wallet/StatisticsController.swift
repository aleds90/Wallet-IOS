//
//  StatisticsController.swift
//  Wallet
//
//  Created by Estia on 07/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit
import Charts

class StatisticsController: UIViewController, ChartViewDelegate, UISearchBarDelegate {
    
    var months: [String]!
  
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Statistics"
        
        searchBar.delegate = self
        searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        barChartView.delegate = self
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [120.0, 140.0, 160.0, 30.0, -112.0, 160.0, -40.0, 180.0, 200.0, -54.0, -45.0, -14.0]
        
        setChart(months, values: unitsSold)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARKS: Functions Charts

    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.descriptionText = ""
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        // Customizing the Chart
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)

        chartDataSet.colors = ChartColorTemplates.liberty()
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let limit = ChartLimitLine(limit: 100.0, label: "Obiettivo Mensile")
        barChartView.rightAxis.addLimitLine(limit)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value) in \(months[entry.xIndex])")
    }
    
    //MARKS: Functions SearchBar
    
    
    
    

}
