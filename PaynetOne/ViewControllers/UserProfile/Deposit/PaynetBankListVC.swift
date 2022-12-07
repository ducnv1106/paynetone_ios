//
//  PaynetBankListVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 18/08/2022.
//

import UIKit

class PaynetBankListVC: BaseUI {
    private var lbTopTitle : UILabel!
    private var lbSyntaxNote : UILabel!
    private var lbBankList : UILabel!
    private var tableView : UITableView!
    private var copyButton : UIButton!
    
    private let paynetBanks = [
        PaynetBank(name: "CÔNG TY CỔ PHẦN MẠNG THANH TOÁN PAYNET VIỆT NAM", bankName: "Ngân hàng Thương mại cổ phần Đầu tư và Phát triển Việt Nam", logo: "bidv", bankNumber: "21210002226222"),
        PaynetBank(name: "CÔNG TY CỔ PHẦN MẠNG THANH TOÁN PAYNET VIỆT NAM", bankName: "Ngân hàng Viettin – Chi nhánh Ba Đình – PGD Vĩnh Phúc", logo: "viettinbank", bankNumber: "112678337979")]
    var storeCode = ""
    private var synxNapHanMuc = ""
    
    var code: String = ""
    var provinceCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "NẠP HẠN MỨC"
        setupView()
    }
    private func initUI(){
        lbTopTitle = POMaker.makeLabel(text: "PAYNET VIỆT NAM hỗ trợ nạp hạn mức qua hình thức chuyển khoản ngân hàng với nội dung chuyển khoản", font: .helvetica.withSize(16), alignment: .center)
        lbSyntaxNote = POMaker.makeLabel(font: .helvetica.withSize(18).desetBold(), color: .darkRed, underLine: true)
        lbBankList = POMaker.makeLabel(text: "Danh sách tài khoản ngân hàng của PAYNET VIỆT NAM", alignment: .center)
        tableView = POMaker.makeTableView(hideSeparator: true)
        copyButton = POMaker.makeButtonIcon(imageName: "copy_ic", tintColor: .darkRed)
        
    }
    private func setupView(){
        let address = StoringService.shared.getAddress()
        if provinceCode.isEmpty {
            self.provinceCode = address?.ProvinceCode.count == 1 ? "0\(address?.ProvinceCode ?? "")" : (address?.ProvinceCode ?? "")
        }else if provinceCode.count < 2 {
            self.provinceCode = "0\(provinceCode)"
        }
        
        if code.isEmpty{
            synxNapHanMuc = "NAPHM <Mã tài khoản hạn mức>"
        }else{
            synxNapHanMuc = "NAPHM \(self.provinceCode)\(code)"
        }
        
        view.addSubview(lbTopTitle)
        lbTopTitle.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 14))
        view.addSubview(lbSyntaxNote)
        lbSyntaxNote.viewConstraints(top: lbTopTitle.bottomAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0), centerX: view.centerXAnchor)
        lbSyntaxNote.text = "\(synxNapHanMuc)"
        lbSyntaxNote.isUserInteractionEnabled = true
        lbSyntaxNote.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copySyntaxDeposit)))
        view.addSubview(copyButton)
        copyButton.viewConstraints(left: lbSyntaxNote.rightAnchor, padding: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0), size: CGSize(width: 18, height: 18), centerY: lbSyntaxNote.centerYAnchor)
        copyButton.addTarget(self, action: #selector(copySyntaxDeposit), for: .touchUpInside)

        view.addSubview(lbBankList)
        lbBankList.viewConstraints(top: lbSyntaxNote.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 14))
        
        view.addSubview(tableView)
        tableView.viewConstraints(top: lbBankList.bottomAnchor, left: view.leftAnchor,bottom: view.safeBottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PaynetBankTableViewCell.self, forCellReuseIdentifier: "PaynetBankTableViewCell")
    }
    
    @objc private func copySyntaxDeposit(){
        let pasteboard = UIPasteboard.general
        pasteboard.string = "\(synxNapHanMuc)"
        if let syntax = pasteboard.string {
            self.showToast(message: "Đã sao chép \(syntax)", delay: 2)
        }
    }
}
extension PaynetBankListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paynetBanks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaynetBankTableViewCell") as! PaynetBankTableViewCell
        cell.model = paynetBanks[indexPath.row]
        cell.copyAction = {
            let pasteboard = UIPasteboard.general
            pasteboard.string = "\(self.paynetBanks[indexPath.row].bankNumber)"
            if let syntax = pasteboard.string {
                self.showToast(message: "Đã sao chép \(syntax)", delay: 2)
            }
        }
        return cell
    }
}
class PaynetBankTableViewCell: UITableViewCell {
    private let viewContent = POMaker.makeView(backgroundColor: .white, radius: 6)
    private let imgLogo = POMaker.makeImage()
    private let lbAcountHolder = POMaker.makeLabel()
    private let lbBankName = POMaker.makeLabel()
    private let lbAccountNumber = POMaker.makeLabel(text: "Tài khoản: ")
    private let lbAccountNumberValue = POMaker.makeLabel(color: .blueColor)
    
    var model = PaynetBank(){
        didSet{
            imgLogo.image = UIImage(named: model.logo)
            lbAcountHolder.text = "Chủ TK: \(model.name)"
            lbBankName.text = model.bankName
            let attributedString = NSMutableAttributedString.init(string: model.bankNumber)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
            lbAccountNumberValue.attributedText = attributedString
        }
    }
    var copyAction: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroundColor
        contentView.addSubview(viewContent)
        viewContent.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 5, left: 12, bottom: 6, right: 12))
        viewContent.addSubviews(views: imgLogo, lbAcountHolder, lbBankName, lbAccountNumber, lbAccountNumberValue)
        imgLogo.viewConstraints(left: viewContent.leftAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0), size: CGSize(width: screenWidth*0.28, height: 100), centerY: viewContent.centerYAnchor)
        
        lbAcountHolder.viewConstraints(top: viewContent.topAnchor, left: imgLogo.rightAnchor, right: viewContent.rightAnchor, padding: UIEdgeInsets(top: 8, left: 6, bottom: 0, right: 6))
        
        lbBankName.viewConstraints(top: lbAcountHolder.bottomAnchor, left: imgLogo.rightAnchor, right: viewContent.rightAnchor, padding: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6))

        lbAccountNumber.viewConstraints(top: lbBankName.bottomAnchor, left: imgLogo.rightAnchor, bottom: viewContent.bottomAnchor, padding: UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 0))
        lbAccountNumber.isUserInteractionEnabled = true
        lbAccountNumber.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyBankNumber_touchUp)))
        
        lbAccountNumberValue.left(toAnchor: lbAccountNumber.rightAnchor)
        lbAccountNumberValue.centerY(toView: lbAccountNumber)
        lbAccountNumberValue.isUserInteractionEnabled = true
        lbAccountNumberValue.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyBankNumber_touchUp)))
        viewContent.buildShadow(radius: 0.5)
        configThemeView()
       
    }
    @objc private func copyBankNumber_touchUp(){
        if let copyAction = copyAction {
            copyAction()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configThemeView(){
        if StoringService.shared.isDarkMode(){
            contentView.backgroundColor = .black
            viewContent.applyViewDarkMode()
            
        }
    }
    
}
