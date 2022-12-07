//
//  ReportViewController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 16/09/2022.
//

import UIKit
import Charts
private let ITEM_COUNT = 12
import SwiftTheme
class ReportViewController: BaseUI, ChartViewDelegate {
    let maxSumAmountDay = 4420
    let maxSumAmoutMonth = 8820
    private var segmentControl : UISegmentedControl!
    private var scrollView : UIScrollView!
    private var headerView : UIView!
    private var headerTitle : UILabel!
    private var qrChartView : CombinedChartView!
    private var reportQRPaymentView : TransactionItem!
    private var reportAddOnServiceView : TransactionItem!
    private var chartBackView :UIView!
    private var chartNoteLeft1 : UILabel!
    private var chartNoteRight1 : UILabel!
    private var noteChartQr : UILabel!
    
    private var addOnServiceChartView : CombinedChartView!
    private var chartNoteLeft2 : UILabel!
    private var chartNoteRight2 : UILabel!
    private var noteChartAddOn : UILabel!
    private var noteValueDTView : UIView!
    private var noteValueDTLabel : UILabel!
    private var noteValueSLLabel : UILabel!
    private var noteValueSLView : UIImageView!
    
    private var tabIndex = 0
    private var reportData = ReportReponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupView()
        getDayReport()
        setupChartView()
        
        if isDarkMode {
            chartBackView.applyViewDarkMode()
            noteValueDTView.backgroundColor = .blueColor
            headerView.backgroundColor = .blueColor
        }else{
            reportQRPaymentView.layer.borderWidth = 0.5
            reportQRPaymentView.layer.borderColor = UIColor.gray6.cgColor
            
            reportAddOnServiceView.layer.borderWidth = 0.5
            reportAddOnServiceView.layer.borderColor = UIColor.gray6.cgColor
            
            chartBackView.layer.borderWidth = 0.5
            chartBackView.layer.borderColor = UIColor.gray6.cgColor
        }
    
    }
    private func initUI(){
        segmentControl = UISegmentedControl(items: ["Thống kê ngày", "Thống kê tháng"])
        scrollView = POMaker.makeScrollView()
        headerView = POMaker.makeView(backgroundColor: .blueColor)
        headerTitle = POMaker.makeLabel(text: "Báo cáo", font: .helvetica.withSize(20), color: .white, alignment: .center)
        qrChartView = CombinedChartView()
        reportQRPaymentView = TransactionItem()
        reportAddOnServiceView = TransactionItem()
        chartBackView = POMaker.makeView(backgroundColor: .white, radius: 10)
        chartNoteLeft1 = POMaker.makeLabel(text: "Nghìn đồng", font: .helvetica.withSize(10))
        chartNoteRight1 = POMaker.makeLabel(text: "Sản lượng", font: .helvetica.withSize(10))
        noteChartQr = POMaker.makeLabel(text: "Doanh số\nThanh toán QR", color: .blueColor, alignment: .center)
        
        addOnServiceChartView = CombinedChartView()
        chartNoteLeft2 = POMaker.makeLabel(text: "Nghìn đồng", font: .helvetica.withSize(10))
        chartNoteRight2 = POMaker.makeLabel(text: "Sản lượng", font: .helvetica.withSize(10))
        noteChartAddOn = POMaker.makeLabel(text: "Doanh số\nDịch vụ gia tăng", color: .blueColor, alignment: .center)
        noteValueDTView = POMaker.makeView(backgroundColor: .blueColor)
        noteValueDTLabel = POMaker.makeLabel(text: "Doanh số")
        noteValueSLLabel = POMaker.makeLabel(text: "Sản lượng")
        noteValueSLView = POMaker.makeImage(image: "sanluong_chart")
    }
//    override func configNavigation() {
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    private func getDayReport(dateMode: String = "D"){
        let config = StoringService.shared.getConfigData()
        let user = StoringService.shared.getUserData()
        let rq = ReportRequest()
        rq.merchantId = config?.merchantID
        rq.empId = user?.id
        rq.dateMode = dateMode
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestObject(dataRq: rqString, code: "REPORT_MOBILE_DASHBOARD", returnType: ReportReponse.self) { result, err in
            self.hideLoading()
            if let result = result {
                self.reportData = result
                if !result.listDateCustomize.isEmpty {
                    let data = result.listDateCustomize[0]
                    self.reportQRPaymentView.quantity = data.countQROnline
                    self.reportQRPaymentView.amount = data.sumQROnline
                    self.reportAddOnServiceView.quantity = data.countGTGT
                    self.reportAddOnServiceView.amount = data.sumGTGT
                }
                if !result.listThreeDay.isEmpty {
                    var legendLabel = [String]()
                    for i in result.listThreeDay {
                        legendLabel.append(i.nameDate)
                    }
                    self.qrChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: legendLabel)
                    self.addOnServiceChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: legendLabel)
                    let dataChart = CombinedChartData()
                    dataChart.barData = self.generateBarData(isChartDay: dateMode == "D" ? true : false)
                    dataChart.lineData = self.generateLineData()
                    self.qrChartView.data = dataChart
                    self.qrChartView.xAxis.axisMaximum = dataChart.xMax + 0.6
                    self.qrChartView.barData?.setValueFormatter(self.getValueFormtter())
                    
                    let dataChartAO = CombinedChartData()
                    dataChartAO.barData = self.generateBarData(isAddOn: true,isChartDay: dateMode == "D" ? true : false)
                    dataChartAO.lineData = self.generateLineData(isAddOn: true)
                    self.addOnServiceChartView.data = dataChartAO
                    self.addOnServiceChartView.xAxis.axisMaximum = dataChartAO.xMax + 0.6
                    self.addOnServiceChartView.barData?.setValueFormatter(self.getValueFormtter(isAddOn: true))
                    
                }
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    private func setupView(){
        view.addSubviews(views: headerView, segmentControl, scrollView)
        headerView.top(toView: view)
        headerView.horizontal(toView: view)
        headerView.height(topInset+screenHeight*0.05)
        headerView.addSubview(headerTitle)
        headerTitle.centerX(toView: headerView)
        headerTitle.bottom(toView: headerView, space: 10)
        
        //        segmentControl.setSegmentedWith()
        //        segmentControl.itemsWithText = true
        //        segmentControl.fillEqually = true
        //        segmentControl.roundedControl = true
        //        segmentControl.padding = 2
        //        segmentControl.thumbViewColor = .blueColor
        //        segmentControl.titlesFont = .helvetica.withSize(14)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        segmentControl.selectedSegmentTintColor = .blueColor
        let selectedTextColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControl.setTitleTextAttributes(selectedTextColor, for: .selected)
        segmentControl.top(toAnchor: headerView.bottomAnchor, space: 10)
        segmentControl.horizontal(toView: view, space: 20)
        segmentControl.height(48)
        
        scrollView.top(toAnchor: segmentControl.bottomAnchor, space: 10)
        scrollView.horizontal(toView: view)
        scrollView.safeBottom(toView: view, space: 50)
        scrollView.addSubviews(views: reportQRPaymentView, reportAddOnServiceView)
        
        reportQRPaymentView.top(toView: scrollView, space: 14)
        reportQRPaymentView.horizontal(toView: view, space: 14)
        reportQRPaymentView.title = "Thanh toán QR"
        
        reportAddOnServiceView.top(toAnchor: reportQRPaymentView.bottomAnchor, space: 10)
        reportAddOnServiceView.horizontal(toView: view, space: 14)
        reportAddOnServiceView.title = "Dịch vụ gia tăng"
    }
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            getDayReport(dateMode: "D")
            qrChartView.leftAxis.axisMaximum = 4500
            qrChartView.rightAxis.axisMaximum = 450
            addOnServiceChartView.leftAxis.axisMaximum = 4500
            addOnServiceChartView.rightAxis.axisMaximum = 450
        } else {
            getDayReport(dateMode: "M")
            qrChartView.leftAxis.axisMaximum = 9000
            qrChartView.rightAxis.axisMaximum = 1800
            addOnServiceChartView.leftAxis.axisMaximum = 9000
            addOnServiceChartView.rightAxis.axisMaximum = 1800
        }
    }
    private func setupChartView(){
        scrollView.addSubviews(views: chartBackView,chartNoteLeft1,chartNoteRight1, qrChartView, noteChartQr, chartNoteLeft2, chartNoteRight2, addOnServiceChartView, noteChartAddOn, noteValueDTView, noteValueDTLabel, noteValueSLLabel, noteValueSLView)
        chartBackView.top(toAnchor: reportAddOnServiceView.bottomAnchor, space: 14)
        chartBackView.bottom(toView: scrollView, space: 10)
        chartBackView.horizontal(toView: view, space: 14)
        
        chartNoteLeft1.top(toView: chartBackView, space: 8)
        chartNoteLeft1.left(toView: chartBackView, space: 4)
        chartNoteRight1.top(toView: chartBackView, space: 8)
        
        qrChartView.top(toAnchor: chartNoteLeft1.bottomAnchor, space: 2)
        qrChartView.left(toView: chartBackView)
        qrChartView.size(CGSize(width: (screenWidth-28)/2, height: screenHeight*0.34))
        qrChartView.barData?.groupBars(fromX: Double(0), groupSpace: Double(2), barSpace: Double(2))
        qrChartView.highlightFullBarEnabled = false
        qrChartView.dragEnabled = false
        qrChartView.doubleTapToZoomEnabled = false
        qrChartView.scaleXEnabled = false
        qrChartView.scaleYEnabled = false
        qrChartView.doubleTapToZoomEnabled = false
        qrChartView.highlightPerTapEnabled = false
        
        
        chartNoteRight1.right(toView: qrChartView)
        noteChartQr.top(toAnchor: qrChartView.bottomAnchor, space: 8)
        noteChartQr.horizontal(toView: qrChartView, space: 6)
        
        chartConfig(qrChartView)
        chartConfig(addOnServiceChartView)
        
        chartNoteLeft2.top(toView: chartBackView, space: 8)
        addOnServiceChartView.top(toAnchor: chartNoteLeft2.bottomAnchor, space: 2)
        addOnServiceChartView.right(toView: chartBackView)
        addOnServiceChartView.size(CGSize(width: (screenWidth-28)/2, height: screenHeight*0.34))
        addOnServiceChartView.highlightFullBarEnabled = false
        addOnServiceChartView.dragEnabled = false
        addOnServiceChartView.doubleTapToZoomEnabled = false
        addOnServiceChartView.scaleXEnabled = false
        addOnServiceChartView.scaleYEnabled = false
        addOnServiceChartView.doubleTapToZoomEnabled = false
        addOnServiceChartView.highlightPerTapEnabled = false
        
        chartNoteLeft2.left(toView: addOnServiceChartView, space: 4)
        chartNoteRight2.top(toView: chartBackView, space: 8)
        chartNoteRight2.right(toView: chartBackView, space: 4)
        
        noteChartAddOn.top(toAnchor: addOnServiceChartView.bottomAnchor, space: 8)
        noteChartAddOn.horizontal(toView: addOnServiceChartView, space: 6)
        
        noteValueDTView.size(CGSize(width: 22, height: 22))
        noteValueDTView.top(toAnchor: noteChartQr.bottomAnchor, space: 8)
        noteValueDTView.bottom(toView: chartBackView, space: 10)
        noteValueDTView.left(toView: chartBackView, space: 50)
        noteValueDTLabel.left(toAnchor: noteValueDTView.rightAnchor, space: 6)
        noteValueDTLabel.centerY(toView: noteValueDTView)
        
        noteValueSLLabel.right(toView: chartBackView, space: 50)
        noteValueSLLabel.centerY(toView: noteValueDTView)
        noteValueSLView.right(toAnchor: noteValueSLLabel.leftAnchor, space: 6)
        noteValueSLView.centerY(toView: noteValueDTView)
        noteValueSLView.size(CGSize(width: 30, height: 20))
    }
    private func chartConfig(_ chart: CombinedChartView){
        chart.delegate = self
        chart.animate(yAxisDuration: 1.0)
        chart.pinchZoomEnabled = false
        chart.drawBordersEnabled = false
        chart.drawGridBackgroundEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.chartDescription.enabled = false
        chart.drawBarShadowEnabled = false
        chart.highlightFullBarEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        
        chart.rightAxis.drawGridLinesEnabled = false
        
        chart.leftAxis.drawGridLinesEnabled = false
        
        chart.legend.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.axisMinimum = -0.6
        chart.leftAxis.axisMinimum = 0
        chart.rightAxis.axisMinimum = 0
        //        xAxis.axisMinimum = 0
        //        xAxis.granularity = 1
        chart.leftAxis.axisMaximum = 4500
        chart.leftAxis.labelCount = 10
        
        chart.rightAxis.axisMaximum = 450
        chart.rightAxis.labelCount = 9
    }
    
    private func generateBarData(isAddOn: Bool = false,isChartDay: Bool = false) -> BarChartData {
        var dataEntries: [BarChartDataEntry] = []
        for (index,value) in reportData.listThreeDay.enumerated() {
            let yValue = isAddOn ? value.sumGTGT/1000 : value.sumQROnline/1000
            var dataEntry: BarChartDataEntry
            if isChartDay{
                if yValue>maxSumAmountDay{
                    dataEntry = BarChartDataEntry(x: Double(index), y: Double(maxSumAmountDay))
                }else{
                    dataEntry = BarChartDataEntry(x: Double(index), y: Double(yValue))
                }
                dataEntries.append(dataEntry)
            }else{
                if yValue>maxSumAmoutMonth{
                    dataEntry = BarChartDataEntry(x: Double(index), y: Double(maxSumAmoutMonth))
                }else{
                    dataEntry = BarChartDataEntry(x: Double(index), y: Double(yValue))
                }
                dataEntries.append(dataEntry)
            }
            
        }
        let set = BarChartDataSet(entries: dataEntries)
        set.setColor(.blueColor)
        set.valueTextColor = .blueColor
        set.valueFont = .systemFont(ofSize: 10)
        set.axisDependency = .left
        let data = BarChartData(dataSets: [set])
        return data
    }
    private func getValueFormtter(isAddOn: Bool = false) -> MyValueFormatter {
        var valueTitle = [String]()
        for item in self.reportData.listThreeDay{
            let yValue = isAddOn ? item.sumGTGT/1000 : item.sumQROnline/1000
            if yValue == 0 {
                valueTitle.append("")
            }else{
                let content = Utils.formatCurrency(amount: yValue).replacingOccurrences(of: "VNĐ", with: "")
                valueTitle.append(content)
            }
            
        }
        
        return MyValueFormatter(tile: valueTitle)
    }
    private func generateLineData(isAddOn: Bool = false) -> LineChartData{
        var dataEntries: [BarChartDataEntry] = []
        for (index,value) in reportData.listThreeDay.enumerated() {
            let yValue = isAddOn ? value.countGTGT : value.countQROnline
            let dataEntry = BarChartDataEntry(x: Double(index), y: Double(yValue))
            dataEntries.append(dataEntry)
        }
        let set = LineChartDataSet(entries: dataEntries)
        set.setColor(.lineChart)
        set.lineWidth = 1.5
        set.setCircleColor(.lineChart)
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = .lineChart
        set.mode = .horizontalBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = .lineChart
        set.axisDependency = .right
        set.circleHoleColor = .lineChart
        set.drawValuesEnabled = false
        
        return LineChartData(dataSet: set)
    }
}
class MyValueFormatter: ValueFormatter{
    private var title = [String]()
    private var postion = -1
    init(tile:[String],position:Int = -1){
        self.title = tile
        self.postion = position
    }
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if postion == 2 {
            postion = -1
        }
        postion += 1
        
        return title[postion]
    }
}
