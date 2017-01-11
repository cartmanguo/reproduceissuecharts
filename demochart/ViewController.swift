//
//  ViewController.swift
//  demochart
//
//  Created by randy on 17/1/11.
//  Copyright © 2017年 Alpha. All rights reserved.
//

import UIKit
import Charts
class ChartDateFormater:NSObject,IAxisValueFormatter
{
    var dateFormatter:DateFormatter!
    var current:Date!
    init(date:Date)
    {
        super.init()
        self.current = date
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
    }
    override init()
    {
        super.init()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        //因为x的值是两个时间相减后的值,所以用timeIntervalSince1970时需要把时间加回来
        return dateFormatter.string(from: NSDate(timeIntervalSince1970: value) as Date)
    }
}

class ViewController: UIViewController {
    var lineChart:LineChartView!
    var i = 0
    var values:[Double] = [199.8,199.8,199.8,212,5,212,5]
    var entries:[ChartDataEntry]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date().timeIntervalSince1970
        let entry1 = ChartDataEntry(x: date, y: 164.9)
        let entry2 = ChartDataEntry(x: date + 1, y: 165.7)
        let entry3 = ChartDataEntry(x: date + 2, y: 164.9)
        let entry4 = ChartDataEntry(x: date + 3, y: 200.8)
        let entry5 = ChartDataEntry(x: date + 4, y: 200.8)
        let entry6 = ChartDataEntry(x: date + 5, y: 199.8)
        let entry7 = ChartDataEntry(x: date + 6, y: 200.8)
        let entry8 = ChartDataEntry(x: date + 7, y: 200.8)
        let entry9 = ChartDataEntry(x: date + 8, y: 200.8)
        let entry10 = ChartDataEntry(x: date + 9, y: 200.8)
        entries = [entry1,entry2,entry3,entry4,entry5,entry6,entry7,entry8,entry9,entry10]
        lineChart = LineChartView(frame: CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height - 100))
        view.addSubview(lineChart)
        lineChart.rightAxis.enabled = false
        let xAxis = lineChart.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1
        xAxis.labelCount = 5
        xAxis.valueFormatter = ChartDateFormater()
        xAxis.labelPosition = XAxis.LabelPosition.bottom
        xAxis.labelTextColor = UIColor.black
        let leftAxis = lineChart.leftAxis;
        leftAxis.granularityEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.labelCount = 2
        xAxis.axisMinimum = entries[0].x
        xAxis.axisMaximum = entries[9].x
        //leftAxis.valueFormatter = LeftAxisFormatter()

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func add(_ sender: Any)
    {
        if i >= 10
        {
            return
        }
        let entry = entries[i]
//        let x = lineChart.xAxis
//        x.axisMinimum = Double(entry.x)
//        x.axisMaximum = entries[9].x
        //print(entry.x)
        i += 1
        
        if lineChart.data == nil
        {
            let dataSet = LineChartDataSet(values: [entry], label: "")
            dataSet.axisDependency = YAxis.AxisDependency.left
            //dataSet.setColor(UIColor(hexString:"#84c7db")!)
            dataSet.lineWidth = 2
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = true
            dataSet.valueFont = UIFont.systemFont(ofSize: 9)
            dataSet.drawValuesEnabled = true
            dataSet.drawCirclesEnabled = true
            dataSet.circleRadius = 3.0

            let data = LineChartData(dataSets: [dataSet])
            lineChart.data = data
        }
        else
        {
            let last = lineChart.data!.dataSets[0].entryForIndex(lineChart.data!.dataSets[0].entryCount - 1)
            if entry.y > last!.y
            {
                let left = lineChart.leftAxis
                left.axisMaximum = entry.y
            }
            
            //left.resetCustomAxisMax()
            //left.resetCustomAxisMin()
            let _ = lineChart.data!.dataSets[0].addEntry(entry)
            lineChart.notifyDataSetChanged()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

