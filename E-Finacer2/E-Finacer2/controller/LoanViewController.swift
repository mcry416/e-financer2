//
//  LoanViewController.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import Charts
import SnapKit
import Alamofire
import SwiftyJSON
import Toast

class LoanViewController: UIViewController{
    
    // MARK: - Ponit the class variable.
    var labelMyLoan = UILabel()
    var labelLoanHistory = UILabel()
    var chartViewMyLoan: PieChartView!
    var chartViewLoanHistory: LineChartView!
    var scrollView = UIScrollView()
    var array: Array<LineData> = Array<LineData>()
    
    // MARK: - Init the view.
    private func initView(){
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: (self.view.frame.height ) + (self.view.frame.height / 3))
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        self.view.addSubview(scrollView)
        
        labelMyLoan.text = "简览借贷"
        labelMyLoan.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)
      //  self.view.addSubview(labelMyLoan)
        scrollView.addSubview(labelMyLoan)
        
        labelLoanHistory.text = "借贷历史"
        labelLoanHistory.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)
      //  self.view.addSubview(labelLoanHistory)
        scrollView.addSubview(labelLoanHistory)
        
        chartViewMyLoan = PieChartView()
     //   self.view.addSubview(chartViewMyLoan)
        scrollView.addSubview(chartViewMyLoan)
        
        chartViewLoanHistory = LineChartView()
     //   self.view.addSubview(chartViewLoanHistory)
        scrollView.addSubview(chartViewLoanHistory)
        
        // ChartView of PieChartView data.
        var dataEntriesMyLoan = [PieChartDataEntry]()
        let entriesCan = PieChartDataEntry(value: 40, label: "已借贷")
        let entriesUsed = PieChartDataEntry(value: 60, label: "可借贷")
        dataEntriesMyLoan.append(entriesCan)
        dataEntriesMyLoan.append(entriesUsed)
        let chartDataSetMyLoan = PieChartDataSet(entries: dataEntriesMyLoan, label: "借贷 / 可借贷")
        chartDataSetMyLoan.xValuePosition = .insideSlice
        chartDataSetMyLoan.yValuePosition = .outsideSlice
        
        chartDataSetMyLoan.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
        let chartDataMyLoan = PieChartData(dataSet: chartDataSetMyLoan)
        chartDataMyLoan.setValueTextColor(.black)
        chartViewMyLoan.data = chartDataMyLoan
        
        // ChartView of LineChartView data.
        var dataEntriesLoanHistory = [ChartDataEntry]()
        let entryLoanHistory = BarChartDataEntry(x: Double(1), y: Double(10))
        dataEntriesLoanHistory .append(entryLoanHistory)
        for i in 2..<30 {
            let y = Double(arc4random_uniform(35))
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntriesLoanHistory .append(entry)
        }
        let chartDataSetMyHistory = LineChartDataSet(entries: dataEntriesLoanHistory , label: "近十次借贷历史")
        let chartDataMyHistory = LineChartData(dataSets: [chartDataSetMyHistory])
        chartViewLoanHistory.data = chartDataMyHistory
        
        labelMyLoan.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaInsets).offset(35)
            make.centerX.equalToSuperview()
        }
        
        chartViewMyLoan.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.equalTo(self.labelMyLoan.snp.bottom).offset(10)
        }
        
        labelLoanHistory.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalTo(self.chartViewMyLoan.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
        }
        
        chartViewLoanHistory.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.equalTo(self.labelLoanHistory.snp.bottom).offset(10)
        }
    }
    
    private func initData(){
        let phone = InitConfig.getUser()
        let url = "http://192.168.0.2:8080/ef/loan/my/17356900019"
        Alamofire.AF.request(url).responseJSON { [self] (response) in
            switch response.result {
            case .success(let json):
                print("-------> NETWORK:\(json)")
                let jsonData = JSON(json)
            //    print("------> PASER \(jsonData[0]["status"].string!)")
                let loanCash = (jsonData[0]["total_loan"].string!)
                
                for i in 1..<jsonData.count{
                    let item = LineData(x: jsonData[i]["x"].string!, y: jsonData[i]["y"].string!)
                    self.array.append(item)
                }
                
                var used: Int = Int(loanCash)!
                used = Int((used * 100) / 50000)
                let canUsed = 100 - used
                
                var dataEntriesMyLoan = [PieChartDataEntry]()
                let entriesCan = PieChartDataEntry(value: Double(used), label: "已借贷")
                let entriesUsed = PieChartDataEntry(value: Double(canUsed), label: "可借贷")
                dataEntriesMyLoan.append(entriesCan)
                dataEntriesMyLoan.append(entriesUsed)
                let chartDataSetMyLoan = PieChartDataSet(entries: dataEntriesMyLoan, label: "借贷 / 可借贷")
                chartDataSetMyLoan.xValuePosition = .insideSlice
                chartDataSetMyLoan.yValuePosition = .outsideSlice
                
                chartDataSetMyLoan.colors = ChartColorTemplates.vordiplom()
                    + ChartColorTemplates.joyful()
                let chartDataMyLoan = PieChartData(dataSet: chartDataSetMyLoan)
                chartDataMyLoan.setValueTextColor(.black)
                self.chartViewMyLoan.data = chartDataMyLoan
                
                
                // ChartView of LineChartView data.
                var dataEntriesLoanHistory = [ChartDataEntry]()
                let entryLoanHistory = BarChartDataEntry(x: Double(1), y: Double(10))
                dataEntriesLoanHistory .append(entryLoanHistory)
                for i in 1..<self.array.count{
                    let y = Double(self.array[i].y!)
                    let entry = ChartDataEntry.init(x: Double(i), y: y!)
                    dataEntriesLoanHistory .append(entry)
                }
                let chartDataSetMyHistory = LineChartDataSet(entries: dataEntriesLoanHistory , label: "近十次借贷历史")
                let chartDataMyHistory = LineChartData(dataSets: [chartDataSetMyHistory])
                self.chartViewLoanHistory.data = chartDataMyHistory
                
                
                break
            case .failure(let error):
                print("error:\(error)")
                self.view.makeToast("查看失败，请检查网络状态")
                break
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()
        
        initData()

        // Do any additional setup after loading the view.
    }
    
    func setDataForMyLoan(can: Double, used: Double){
        var dataEntriesMyLoan = [PieChartDataEntry]()
        let entriesCan = PieChartDataEntry(value: can, label: "已借贷")
        let entriesUsed = PieChartDataEntry(value: used, label: "可借贷")
        dataEntriesMyLoan.append(entriesCan)
        dataEntriesMyLoan.append(entriesUsed)
        let chartDataSetMyLoan = PieChartDataSet(entries: dataEntriesMyLoan, label: "借贷 / 可借贷")
        chartDataSetMyLoan.xValuePosition = .insideSlice
        chartDataSetMyLoan.yValuePosition = .outsideSlice
        
        chartDataSetMyLoan.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
        let chartDataMyLoan = PieChartData(dataSet: chartDataSetMyLoan)
        chartDataMyLoan.setValueTextColor(.black)
        chartViewMyLoan.data = chartDataMyLoan
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

