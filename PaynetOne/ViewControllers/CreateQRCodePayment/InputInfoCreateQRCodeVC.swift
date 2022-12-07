//
//  InputInfoCreateQRCodeVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 10/08/2022.
//

import UIKit

class InputInfoCreateQRCodeVC: BaseViewController {
    private var tfAmount : UITextField!
    private var collectionView : UICollectionView!
    private var lbDescriptionTitle : UILabel!
    private var tfDescription :UITextView!
    private var btnConfirm :UIButton!
    private var vnd : UILabel!
    private var amountLine : UIView!
    
    private let suggestMoney = [10000,20000,50000,100000,200000,500000]
    
    var name = ""
    var icon = ""
    var itemSelected = 0
    var amountValue = 0
    var model = ProviderLocal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUITabBar()
        setupTabBar()
        configUI()
        setupView()
       
        
        self.imgTabbar.kfImage(urlStr: model.icon)
        self.lbTitleTabbar.text = model.name
        self.isShowIcon = true
        self.titleView.backgroundColor = .blueColor
       
        resetSelectedPosition()
        configBackgorundColor()
        
        self.tfAmount.becomeFirstResponder()
    }
    
    
    override func configBackgorundColor() {}
    private func resetSelectedPosition(){
        itemSelected = 0
        collectionView.reloadData()
    }
    
    private func configUI(){
        tfAmount = POMaker.makeTextField(placeholder: "0", font: .helvetica.withSize(34).setBold(), borderWidth: 0)
        collectionView = POMaker.makeCollectionView(screenWidth - 50, itemSpacing: 4, itemsInLine: 3, itemHeight: 50)
        lbDescriptionTitle = POMaker.makeLabel(text: "Mô tả", font: .helvetica.withSize(16).setBold(), color: .textBlack)
        tfDescription = POMaker.makeTextView(placeholder: "Nhập mô tả", borderWidth: 1, borderColor: .blueColor, cornerRadius: 10)
        btnConfirm = POMaker.makeButton(title: "Xác nhận")
        vnd = POMaker.makeLabel(text: "đ", font: .helvetica.withSize(16))
        amountLine = POMaker.makeView(backgroundColor: .blueColor)
        if isDarkMode{
            amountLine.backgroundColor = .white
        }else{
            amountLine.backgroundColor = .blueColor
        }
       
    }
    
    private func setupView(){
        view.addSubviews(views: tfAmount, vnd, amountLine, collectionView)
        tfAmount.clearButtonMode = .never
        tfAmount.text = Utils.numberFormatter(number: suggestMoney[0])
        tfAmount.delegate = self
        amountValue = suggestMoney[itemSelected]
        tfAmount.keyboardType = .numberPad
        tfAmount.addTarget(self, action: #selector(tfAmountDidChange), for: .editingChanged)
        tfAmount.viewConstraints(top: view.safeTopAnchor, padding: UIEdgeInsets(top: 20, left: 14, bottom: 0, right: 14), size: CGSize(width: 0, height: 50), centerX: view.centerXAnchor)
        
        vnd.top(toView: tfAmount)
        vnd.left(toAnchor: tfAmount.rightAnchor)
        
        amountLine.centerX(toView: tfAmount, space: 4)
        amountLine.top(toAnchor: tfAmount.bottomAnchor)
        amountLine.size(CGSize(width: 60, height: 1))
        
        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 28, height: 100)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SuggestAmountCollectionViewCell.self, forCellWithReuseIdentifier: "SuggestAmountCollectionViewCell")
        let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.viewConstraints(top: tfAmount.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 18, left: 14, bottom: 0, right: 14), size: CGSize(width: 0, height: contentHeight))
        
        view.addSubview(lbDescriptionTitle)
        lbDescriptionTitle.viewConstraints(top: collectionView.bottomAnchor, left: view.leftAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 0))
        view.addSubview(tfDescription)
        tfDescription.viewConstraints(top: lbDescriptionTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 14, bottom: 0, right: 14), size: CGSize(width: 0, height: 100))
        tfDescription.delegate = self
        
        
        view.addSubview(btnConfirm)
        btnConfirm.viewConstraints(left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 0, left: 14, bottom: 10, right: 14), size: CGSize(width: 0, height: 46))
        btnConfirm.addTarget(self, action: #selector(confirm_touchUp), for: .touchUpInside)
    }
    
    @objc func tfAmountDidChange(_ textField: UITextField) {
        if var str = tfAmount.text {
            str = str.replacingOccurrences(of: ",", with: "")
            if let number = Int("\(str)") {
                if number > 10000000 {
                    tfAmount.text = Utils.numberFormatter(number: 10000000)
                    amountValue = 10000000
                } else {
                    tfAmount.text = Utils.numberFormatter(number: number)
                    amountValue = number
                }
                
                if number == 10000 {
                    self.itemSelected = 0
                    collectionView.reloadData()
                }else if number == 20000 {
                    self.itemSelected = 1
                    collectionView.reloadData()
                }else if number == 50000 {
                    self.itemSelected = 2
                    collectionView.reloadData()
                }else if number == 100000 {
                    self.itemSelected = 3
                    collectionView.reloadData()
                }else if number == 200000 {
                    self.itemSelected = 4
                    collectionView.reloadData()
                }else if number == 500000 {
                    self.itemSelected = 5
                    collectionView.reloadData()
                }else{
                    self.itemSelected = -1
                    collectionView.reloadData()
                }
                vnd.textColor = .black
            } else {
                amountValue = 0
                vnd.textColor = .gray.withAlphaComponent(0.7)
            }
        }
    }
    
    @objc func confirm_touchUp(){
        let rq = CreateQRCodeRequest()
        let user = StoringService.shared.getUserData()
        let config = StoringService.shared.getConfigData()
        rq.providerCode = model.code
        rq.empID = user?.id ?? 0
        rq.paynetID = user?.paynetId ?? 0
        rq.transCategory = Constants.transCategory
        rq.mobileNumber = ""
        rq.paymentCate = Constants.paymentCate
        rq.paymentType = model.paymentType
        rq.serviceID = Constants.serviceID
        rq.amount = amountValue
        rq.fee = Constants.fee
        rq.transAmount = amountValue
        rq.orderDES = tfDescription.text.removeDiacritics()
        rq.channel = Constants.chanel
        rq.merchantID = config?.merchantID ?? 0
        rq.ProviderAcntID = model.id
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestObject(dataRq: rqString, code: "ORDER_ADD_NEW", returnType: CreateQRCodeResponse.self) { result, err in
            self.hideLoading()
            if let result = result {
                if result.returnURL.isEmpty {
                    self.showToast(message: "Không tải được dữ liệu, vui lòng thử lại sau!", delay: 3)
                } else {
                    let vc = InfoQRCreatedVC()
                    vc.model = self.model
                    vc.amount = self.amountValue
                    vc.qrCode = result
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
}
extension InputInfoCreateQRCodeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestMoney.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestAmountCollectionViewCell", for: indexPath) as! SuggestAmountCollectionViewCell
     
        if isDarkMode{
            let borderColor = self.itemSelected == indexPath.row ? UIColor.blueColor : UIColor.white
            cell.cellView.layer.borderColor = borderColor.cgColor
            cell.cellView.layer.borderWidth = self.itemSelected == indexPath.row ? 2 : 0.8
            cell.suggestAmount.textColor = self.itemSelected == indexPath.row ? .blueColor : .white
          
        }else{
            let borderColor = self.itemSelected == indexPath.row ? UIColor.blueColor : UIColor.borderColor
            cell.cellView.layer.borderColor = borderColor.cgColor
            cell.cellView.layer.borderWidth = self.itemSelected == indexPath.row ? 2 : 0.8
            cell.suggestAmount.textColor = self.itemSelected == indexPath.row ? .blueColor : .textBlack
           
        }
        cell.suggestAmount.font = self.itemSelected == indexPath.row ? .helvetica.setBold() : .helvetica
        cell.suggestAmount.text = Utils.currencyFormatter(amount: suggestMoney[indexPath.row])
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.itemSelected = indexPath.row
        self.tfAmount.text = Utils.numberFormatter(number: suggestMoney[indexPath.row])
        self.amountValue = suggestMoney[indexPath.row]
        self.vnd.textColor = isDarkMode == true ? .white :  .black
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
extension InputInfoCreateQRCodeVC: UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength: Int?
        if textField == tfAmount {
            maxLength = 10
        }
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= maxLength!
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var maxLength: Int?
        let allowedCharacters = CharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").inverted
        if textView == tfDescription {
            maxLength = 19
        }
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        let components = text.components(separatedBy: allowedCharacters)
        let filtered = components.joined(separator: "")
        if text == filtered {
            return newLength <= maxLength!
        } else {
            return false
        }
    }
}
struct ProviderInput{
     var id = 0
     var code = ""
     var name = ""
     var type = 0
     var category = 0
     var icon = ""
     var paymentType = 0
     var isActive = ""
     var providerACNTCode = ""
}
