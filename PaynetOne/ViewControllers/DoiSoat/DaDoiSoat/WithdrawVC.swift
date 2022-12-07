import Foundation
import UIKit
import ObjectMapper
import IQKeyboardManagerSwift
import PopupDialog

class WithdrawVC: BaseUI,CallbackListenerPayment {
    private var walletView : UIView!
    private var walletImage : UIImageView!
    private var lbTitleDaDS = POMaker.makeLabel(text: "Số tiền đã đối soát", font: .helvetica.withSize(18).setBold())
    private var lbSoDu : UILabel!
    private var lbHinhThucRutTien : UILabel!
    private var tfChonTypeRutTien : UITextField!
    private var lbTaiKhoanRutTien : UILabel!
    private var tfChonTKRutTien : UITextField!
    private var scrollView :UIScrollView!
    private var formStack :UIStackView!
    private var lbBankName : UILabel!
    private var tfBankName : UITextField!
    private var tfSelectWallet :UITextField!
    private var lbSoTaiKhoan  : UILabel!
    private var tfSoTaiKhoan :UITextField!
    private var lbFullName  : UILabel!
    private var tfFullName:UITextField!
    private var lbAmount  : UILabel!
    private var tfAmount :UITextField!
    private var btnConfirm : UIButton!
    private var lbChiNhanh  : UILabel!
    private var tfChonChiNhanh :UITextField!
    private var lbCuaHang  : UILabel!
    private var tfChonCuaHang :UITextField!
    private var lbPosId  : UILabel!
    private var tfPosId :UITextField!
    
    private var wallets = [WalletsModel]()
    private var walletIndex = 0
    private var typeWithdraw = 0
    private var soDu: Int = 0
    private var amountValue = 0
    private var walletSelected: WalletsModel?
    private var merchantMobile: MerchantFileModel?
    private var chiNhanhList = [ChiNhanhStore]()
    private var cuaHangList = [ChiNhanhStore]()
    private var chiNhanhIndex = 0
    private var cuaHangIndex = 0
    var tkIndex = 0
    private var chiNhanh: ChiNhanhStore?
    private var cuaHang: ChiNhanhStore?
    var delegate: UpdateDataDelegate?
    var isNapHM = false
    var balanceType = "P" {//đi từ tab nào, gtgt(C) hay qr(P)
        didSet {
            if balanceType == "C" {
                lbTitleDaDS.text = "Hoa hồng đã đối soát"
            } else {
                lbTitleDaDS.text = "Số tiền đã đối soát"
            }
        }
    }
    var storeModel: HanMucCuaHangList?
    var isSelectTaiKhoan = false
    var balances = Balance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RÚT TIỀN"
        initUI()
        configUI()
        initialData()
        configView()
        setupHeader()
        getPodId()
        getSoDu()
        getChiNhanhCuaHang()
        self.configUIHanMuc()
    }
    
    private func initUI(){
        walletView = POMaker.makeView(backgroundColor: .blueColor, radius: 12)
        walletImage = POMaker.makeImage(image: "da-doi-soat")
        lbTitleDaDS = POMaker.makeLabel(text: "Số tiền đã đối soát", font: .helvetica.withSize(18).setBold())
        lbSoDu = POMaker.makeLabel(text: "Số dư: \(Utils.formatCurrency(amount: 0))", font: .helvetica.withSize(18))
        lbHinhThucRutTien = POMaker.makeLabel(text: "Hình thức rút tiền *", require: true)
        tfChonTypeRutTien = POMaker.makeTextField(placeholder: "Chọn hình thức rút tiền", isSelector: true)
        lbTaiKhoanRutTien = POMaker.makeLabel(text: "Tài khoản rút tiền *", require: true)
        tfChonTKRutTien = POMaker.makeTextField(placeholder: "Chọn tài khoản rút tiền", isSelector: true)
        scrollView = POMaker.makeScrollView()
        formStack = POMaker.makeStackView(spacing: 6,distri: .fill)
        lbBankName = POMaker.makeLabel(text: "Tên ngân hàng *", require: true)
        tfBankName = POMaker.makeTextField()
        tfSelectWallet = POMaker.makeTextField(placeholder: "Chọn ví điện tử", isSelector: true)
        lbSoTaiKhoan = POMaker.makeLabel(text: "Số tài khoản *", require: true)
        tfSoTaiKhoan = POMaker.makeTextField(placeholder: "Nhập số điện thoại")
        lbFullName = POMaker.makeLabel(text: "Họ và tên *", require: true)
        tfFullName = POMaker.makeTextField(placeholder: "Nhập họ và tên")
        lbAmount = POMaker.makeLabel(text: "Số tiền *", require: true)
        tfAmount = POMaker.makeTextField(placeholder: "Nhập số tiền rút")
        btnConfirm = POMaker.makeButton(title: "Xác nhận")
        lbChiNhanh = POMaker.makeLabel(text: "Chi nhánh *", require: true)
        tfChonChiNhanh = POMaker.makeTextField(placeholder: "--Chọn chi nhánh--", isSelector: true)
        lbCuaHang = POMaker.makeLabel(text: "Cửa hàng *", require: true)
        tfChonCuaHang = POMaker.makeTextField(placeholder: "--Chọn cửa hàng--", isSelector: true)
        lbPosId = POMaker.makeLabel(text: "PosID *", require: true)
        tfPosId = POMaker.makeTextField()
    }
    private func configUI(){
        view.addSubviews(views: walletView, lbTitleDaDS, lbSoDu, btnConfirm, scrollView,formStack)
        
        btnConfirm.safeBottom(toView: view, space: 10)
        btnConfirm.horizontal(toView: view, space: 14)
        btnConfirm.height(50)
        btnConfirm.addTarget(self, action: #selector(confirmWithdraw), for: .touchUpInside)
        
        walletView.safeTop(toView: view, space: 20)
        walletView.left(toView: view, space: 14)
        walletView.size(CGSize(width: 60, height: 60))
        walletView.addSubview(walletImage)
        
        walletImage.vertical(toView: walletView)
        walletImage.horizontal(toView: walletView)
        
        lbTitleDaDS.top(toAnchor: walletView.topAnchor)
        lbTitleDaDS.left(toAnchor: walletView.rightAnchor, space: 10)
        lbTitleDaDS.height(30)
        
        lbSoDu.top(toAnchor: lbTitleDaDS.bottomAnchor)
        lbSoDu.left(toAnchor: walletView.rightAnchor, space: 10)
        lbSoDu.height(30)
        
        scrollView.top(toAnchor: walletView.bottomAnchor, space: 14)
        scrollView.horizontal(toView: view)
        scrollView.bottom(toAnchor: btnConfirm.topAnchor, space: 8)
        scrollView.addSubviews(views: formStack)
        
        formStack.vertical(toView: scrollView)
        formStack.horizontal(toView: view, space: 14)
        formStack.addArrangedSubviews(lbHinhThucRutTien, tfChonTypeRutTien, lbTaiKhoanRutTien, tfChonTKRutTien, lbBankName, tfBankName, tfSelectWallet, lbSoTaiKhoan, tfSoTaiKhoan, lbPosId, tfPosId, lbFullName, tfFullName, lbChiNhanh, tfChonChiNhanh, lbCuaHang, tfChonCuaHang, lbAmount, tfAmount)
        
        lbHinhThucRutTien.height(28)
        lbHinhThucRutTien.contentMode = .bottom
        tfChonTypeRutTien.height(50)
        tfChonTypeRutTien.delegate = self
        
        lbTaiKhoanRutTien.height(28)
        lbTaiKhoanRutTien.contentMode = .bottom
        tfChonTKRutTien.height(50)
        tfChonTKRutTien.delegate = self
        
        lbBankName.height(28)
        lbBankName.contentMode = .bottom
        tfBankName.height(50)
        
        tfSelectWallet.height(50)
        tfSelectWallet.delegate = self
        
        lbSoTaiKhoan.height(28)
        lbSoTaiKhoan.contentMode = .bottom
        tfSoTaiKhoan.height(50)
        tfSoTaiKhoan.delegate = self
        
        lbPosId.height(28)
        lbPosId.contentMode = .bottom
        tfPosId.height(50)
        tfPosId.isUserInteractionEnabled = false
        
        lbFullName.height(28)
        lbFullName.contentMode = .bottom
        tfFullName.height(50)
        
        lbChiNhanh.height(28)
        lbChiNhanh.contentMode = .bottom
        tfChonChiNhanh.height(50)
        tfChonChiNhanh.delegate = self
        
        lbCuaHang.height(28)
        lbCuaHang.contentMode = .bottom
        tfChonCuaHang.height(50)
        tfChonCuaHang.delegate = self
        
        lbAmount.height(28)
        lbAmount.contentMode = .bottom
        tfAmount.height(50)
        tfAmount.keyboardType = .numberPad
        tfAmount.addTarget(self, action: #selector(tfMoneyDidChange), for: .editingChanged)
        tfAmount.delegate = self
        
        if balanceType == "C" {
            lbTitleDaDS.text = "Hoa hồng đã đối soát"
        } else {
            lbTitleDaDS.text = "Số tiền đã đối soát"
        }
        
        self.lbSoDu.text = "Số dư: \(Utils.formatCurrency(amount: soDu))"
    }
    
    private func configUIHanMuc(){
        if isNapHM {
            typeWithdraw = 2
            tfChonTypeRutTien.text = Constants.hinhThucRutTien[2].text
            tfChonTypeRutTien.isUserInteractionEnabled = false
            self.configView()
            if storeModel != nil {
                lbChiNhanh.isHidden = true
                tfChonChiNhanh.isHidden = true
                lbCuaHang.isHidden = false
                tfChonCuaHang.isHidden = false
                tfChonCuaHang.isUserInteractionEnabled = false
                tfChonCuaHang.text = storeModel?.Name
            }else{
                self.lbChiNhanh.isHidden = false
                self.tfChonChiNhanh.isHidden = false
                self.lbCuaHang.isHidden = false
                self.tfChonCuaHang.isHidden = false
            }
        }else{
            tfChonTKRutTien.rightView = nil
        }
    }
    private func getChiNhanhCuaHang(){
        let config = StoringService.shared.getConfigData()
        let rq = LayChiNhanhStore()
        rq.parentID = config?.id
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestList(dataRq: rqString, code: "PAYNET_GET_BY_PARENT", returnType: ChiNhanhStore.self, completion: { result, err in
            if let result = result {
                self.chiNhanhList = result
            } else {
                self.lbChiNhanh.isHidden = true
                self.tfChonChiNhanh.isHidden = true
                self.lbCuaHang.isHidden = true
                self.tfChonCuaHang.isHidden = true
                self.tfChonChiNhanh.text = "Chi nhánh số 01"
                self.tfChonCuaHang.text = "Cửa hàng số 01"
            }
        })
    }
    private func getSoDu(){
        let rq = BalanceMerchantRequest()
        let user = StoringService.shared.getUserData()
        rq.paynetID = user?.paynetId
        let rqString = Utils.objToString(rq)
        
        self.showLoading()
        ApiManager.shared.requestObject(dataRq: rqString, code: "MERCHANT_GET_BALANCE", returnType: Balance.self) { result, err in
            self.hideLoading()
            if let result = result {
                self.balances = result
                if self.balanceType == "C" {
                    let balance = result.MerchantBalance.filter({$0.accountType == "C"})
                    if !balance.isEmpty {
                        self.lbSoDu.text = "Số dư: \(Utils.formatCurrency(amount: balance[0].balance))"
                        self.soDu = balance[0].balance
                    }
                } else {
                    let balance = result.MerchantBalance.filter({$0.accountType == "P"})
                    if !balance.isEmpty {
                        self.lbSoDu.text = "Số dư: \(Utils.formatCurrency(amount: balance[0].balance))"
                        self.soDu = balance[0].balance
                    }
                }
            } else {
                //                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    private func initialData(){
        let userData = StoringService.shared.getUserData()
        tfChonTypeRutTien.text = Constants.hinhThucRutTien[typeWithdraw].text
        tfBankName.text = userData?.BankName
        tfBankName.isUserInteractionEnabled = false
        tfSoTaiKhoan.text = userData?.paymentAccNo
        tfSoTaiKhoan.isUserInteractionEnabled = false
        tfFullName.text = userData?.paymentAccName
        tfFullName.isUserInteractionEnabled = false
        //mặc định tk rút tiền là tk đã đs = P
        tfChonTKRutTien.text = Constants.taiKhoanRutTien[tkIndex].text
        tfChonTKRutTien.isUserInteractionEnabled = isSelectTaiKhoan
    }
    private func chonHinhThucRutTien_touchUp(){
        let array = Configs.isXoSo() ? Constants.hinhThucRutTienXS : Constants.hinhThucRutTien
        let pickerValues: [String] = array.map { $0.text }
        let alert = UIAlertController(style: .actionSheet, title: "Chọn hình thức rút tiền")
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: typeWithdraw)
        alert.addPickerView(values: [pickerValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.typeWithdraw = index.row
            self.tfChonTypeRutTien.text = array[index.row].text
            if array[index.row].id == 2 && self.chiNhanhList.isEmpty {
                self.lbChiNhanh.isHidden = true
                self.tfChonChiNhanh.isHidden = true
                self.lbCuaHang.isHidden = true
                self.tfChonCuaHang.isHidden = true
            }
            self.configView()
        }
        alert.addAction(title: "Xong", style: .cancel)
        alert.show()
    }
    private func configView(){
        let array = Configs.isXoSo() ? Constants.hinhThucRutTienXS : Constants.hinhThucRutTien
        switch array[typeWithdraw].id {
        case 0:
            let userData = StoringService.shared.getUserData()
            lbBankName.isHidden = false
            lbBankName.attributedText = "Tên ngân hàng *".attributedLastString()
            tfBankName.isHidden = false
            lbSoTaiKhoan.isHidden = false
            lbSoTaiKhoan.attributedText = "Số tài khoản *".attributedLastString()
            tfSoTaiKhoan.isUserInteractionEnabled = false
            tfSoTaiKhoan.text = userData?.paymentAccNo
            tfSoTaiKhoan.isHidden = false
            lbFullName.isHidden = false
            tfFullName.isUserInteractionEnabled = false
            tfFullName.text = userData?.paymentAccName
            tfFullName.isHidden = false
            tfFullName.backgroundColor = UIColor.textLightGray
            tfFullName.placeholder = ""
            tfFullName.isUserInteractionEnabled = false
            tfSelectWallet.isHidden = true
            lbChiNhanh.isHidden = true
            tfChonChiNhanh.isHidden = true
            lbCuaHang.isHidden = true
            tfChonCuaHang.isHidden = true
            lbPosId.isHidden = true
            tfPosId.isHidden = true
        case 1:
            lbBankName.attributedText = "Tên ví điện tử *".attributedLastString()
            lbBankName.isHidden = false
            tfSelectWallet.isHidden = false
            tfBankName.isHidden = true
            lbSoTaiKhoan.isHidden = false
            lbSoTaiKhoan.attributedText = "Số điện thoại *".attributedLastString()
            tfSoTaiKhoan.isUserInteractionEnabled = true
            tfSoTaiKhoan.keyboardType = .phonePad
            tfFullName.isHidden = false
            tfFullName.isUserInteractionEnabled = true
            tfFullName.text = ""
            tfFullName.placeholder = "Nhập họ và tên"
            tfFullName.backgroundColor = UIColor.clear
            tfSoTaiKhoan.text = ""
            lbFullName.isHidden = false
            tfSoTaiKhoan.isHidden = false
            lbChiNhanh.isHidden = true
            tfChonChiNhanh.isHidden = true
            lbCuaHang.isHidden = true
            tfChonCuaHang.isHidden = true
            lbPosId.isHidden = true
            tfPosId.isHidden = true
        case 2:
            lbBankName.isHidden = true
            tfBankName.isHidden = true
            lbSoTaiKhoan.isHidden = true
            tfSoTaiKhoan.isHidden = true
            lbFullName.isHidden = true
            tfFullName.isHidden = true
            tfSelectWallet.isHidden = true
            lbPosId.isHidden = true
            tfPosId.isHidden = true
            
            if chiNhanhList.count > 0  {
                lbChiNhanh.isHidden = false
                tfChonChiNhanh.isHidden = false
                lbCuaHang.isHidden = false
                tfChonCuaHang.isHidden = false
            }
            
            
        case 3:
            lbPosId.isHidden = false
            tfPosId.isHidden = false
            lbFullName.isHidden = false
            tfFullName.isHidden = false
            tfFullName.isUserInteractionEnabled = true
            tfFullName.text = ""
            tfFullName.placeholder = "Nhập họ và tên"
            tfFullName.backgroundColor = UIColor.clear
            lbBankName.isHidden = true
            tfBankName.isHidden = true
            lbSoTaiKhoan.isHidden = true
            tfSoTaiKhoan.isHidden = true
            tfFullName.isUserInteractionEnabled = true
            tfSelectWallet.isHidden = true
        default:
            break
        }
    }
    private func selectWallet_touchUp(){
        if wallets.isEmpty {
            self.showLoading()
            ApiManager.shared.requestList(code: "DIC_GET_WALLET", returnType: WalletsModel.self) { result, err in
                self.hideLoading()
                if let result = result {
                    self.wallets = result
                    self.selectWallet()
                    self.walletIndex = 0
                    self.tfSelectWallet.text = result[self.walletIndex].name
                    self.walletSelected = result[self.walletIndex]
                } else {
                    self.showToast(message: err ?? "", delay: 2)
                }
            }
        } else {
            self.walletSelected = self.wallets[walletIndex]
            self.selectWallet()
        }
    }
    private func selectWallet(){
        let pickerValues: [String] = wallets.map { $0.name }
        let alert = UIAlertController(style: .actionSheet, title: "Chọn ví điện tử")
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: walletIndex)
        alert.addPickerView(values: [pickerValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.walletIndex = index.row
            self.tfSelectWallet.text = self.wallets[index.row].name
            self.walletSelected = self.wallets[index.row]
        }
        alert.addAction(title: "Xong", style: .cancel)
        alert.show()
    }
    private func setupHeader(){
        let rightButton = UIBarButtonItem(image: UIImage(named: "history")?.resized(to: CGSize(width: 28, height: 28)), style: UIBarButtonItem.Style.plain, target: self, action: #selector(toHistoryWithdraw))
        navigationItem.rightBarButtonItem = rightButton
    }
    private func getPodId(){
        let userData = StoringService.shared.getUserData()
        let data = CheckPhoneRequestModel()
        data.mobileNumber = userData?.phoneNumber
        guard let dataString = Mapper().toJSONString(data) else { return }
        ApiManager.shared.createRequest(data: dataString, code: "MERCHANT_GET_BY_MOBILE_NUMBER") { stt, data in
            if stt == true {
                let dataObj = MerchantFileModel(JSONString: data)
                self.merchantMobile = dataObj
                self.tfPosId.text = dataObj?.posID
            }
        }
    }
    private func chonChiNhanh_touchUp(){
        self.tfChonChiNhanh.text = self.chiNhanhList[chiNhanhIndex].Name
        self.chiNhanh = self.chiNhanhList[chiNhanhIndex]
        let pickerValues: [String] = chiNhanhList.map { $0.Name }
        let alert = UIAlertController(style: .actionSheet, title: "Chọn chi nhánh")
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: chiNhanhIndex)
        alert.addPickerView(values: [pickerValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            if self.chiNhanh?.ID != self.chiNhanhList[index.row].ID {
                self.cuaHangIndex = 0
                self.chiNhanhIndex = index.row
                self.tfChonChiNhanh.text = self.chiNhanhList[index.row].Name
                self.chiNhanh = self.chiNhanhList[index.row]
                self.cuaHang = nil
                self.tfChonCuaHang.text = ""
            }
        }
        alert.addAction(title: "Xong", style: .cancel)
        alert.show()
    }
    private func chonCuaHang_touchUp(){
        if chiNhanh == nil {
            self.showToast(message: "Bạn chưa chọn chi nhánh", delay: 2)
            return
        }
        let rq = LayChiNhanhStore()
        rq.parentID = chiNhanh?.ID
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestList(dataRq: rqString, code: "PAYNET_GET_BY_PARENT", returnType: ChiNhanhStore.self, completion: { result, err in
            self.hideLoading()
            if let result = result {
                self.tfChonCuaHang.text = result[self.cuaHangIndex].Name
                self.cuaHang = result[self.cuaHangIndex]
                let pickerValues: [String] = result.map { $0.Name }
                let alert = UIAlertController(style: .actionSheet, title: "Chọn cửa hàng")
                let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: self.cuaHangIndex)
                alert.addPickerView(values: [pickerValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
                    self.cuaHangIndex = index.row
                    self.tfChonCuaHang.text = result[index.row].Name
                    self.cuaHang = result[index.row]
                }
                alert.addAction(title: "Xong", style: .cancel)
                alert.show()
            }else{
                self.showToast(message: err ?? "", delay: 2)
            }
        })
    }
    private func chonTaiKhoanRut_touchUp(){
        let pickerValues: [String] = Constants.taiKhoanRutTien.map { $0.text }
        let alert = UIAlertController(style: .actionSheet, title: "Chọn tài khoản rút tiền")
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: tkIndex)
        alert.addPickerView(values: [pickerValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.tkIndex = index.row
            self.tfChonTKRutTien.text = Constants.taiKhoanRutTien[index.row].text
            self.balanceType = Constants.taiKhoanRutTien[index.row].type
            let balance = self.balances.MerchantBalance.filter({$0.accountType == Constants.taiKhoanRutTien[index.row].type})
            if !balance.isEmpty {
                self.lbSoDu.text = "Số dư: \(Utils.formatCurrency(amount: balance[0].balance))"
            }else{
                self.lbSoDu.text = "Số dư: \(Utils.formatCurrency(amount: 0))"
            }
        }
        alert.addAction(title: "Xong", style: .cancel)
        alert.show()
    }
    @objc private func tfMoneyDidChange(_ textField: UITextField) {
        if var str = tfAmount.text {
            str = str.replacingOccurrences(of: ",", with: "")
            if let number = Int("\(str)") {
                tfAmount.text = Utils.numberFormatter(number: number)
                amountValue = number
            } else {
                amountValue = 0
            }
        }
    }
    @objc private func confirmWithdraw(){
        if typeWithdraw == 1 {
            if walletSelected == nil {
                self.showToast(message: "Bạn chưa chọn ví điện tử nhận tiền", delay: 2)
                return
            }
            if tfSoTaiKhoan.text == ""{
                self.showToast(message: "Bạn chưa nhập số điện thoại", delay: 2)
                return
            }
            if !(tfSoTaiKhoan.text ?? "").starts(with: "0") || tfSoTaiKhoan.text?.count != 10{
                self.showToast(message: "Số điện thoại không hợp lệ", delay: 2)
                return
            }
            if tfSoTaiKhoan.text == "" {
                tfSoTaiKhoan.becomeFirstResponder()
                return
            }
            if tfFullName.text == "" {
                tfFullName.becomeFirstResponder()
                return
            }
            
            
        } else if typeWithdraw == 2 && storeModel == nil {
            if tfChonChiNhanh.text?.isEmpty == true {
                self.showToast(message: "Bạn chưa chọn chi nhánh", delay: 2)
                return
            }
            if tfChonCuaHang.text?.isEmpty == true{
                self.showToast(message: "Bạn chưa chọn cửa hàng", delay: 2)
                return
            }
        } else if typeWithdraw == 3 {
            if tfFullName.text == "" {
                self.showToast(message: "Bạn chưa nhập họ tên.", delay: 2)
                return
            }
        }
        if tfAmount.text == "" {
            tfAmount.becomeFirstResponder()
            return
        }
        var nameMethod = ""
        if typeWithdraw == 0 {
            nameMethod = "tài khoản ngân hàng"
        } else if typeWithdraw == 1 {
            nameMethod = "tài khoản ví điện tử"
        } else if typeWithdraw == 2 {
            nameMethod = "tài khoản hạn mức"
        } else {
            nameMethod = "tài khoản Vietlott"
        }
        
        let modal = ConfirmModalView()
        modal.message = "Bạn có chắc chắn muốn rút số tiền \(Utils.formatCurrency(amount: amountValue)) về \(nameMethod) không?"
        self.popupWithView(vc: modal,cancelBtnTitle: "Huỷ bỏ", cancelAction:{
           
        }, okBtnTitle: "Đồng ý", okAction: {
            self.okWithdraw()
        })
    }
    private func okWithdraw(){
        let array = Configs.isXoSo() ? Constants.hinhThucRutTienXS : Constants.hinhThucRutTien
        let userString = StoringService.shared.getUserData()
        let config = StoringService.shared.getConfigData()
        let rq = WithdrawRequestModel()
        rq.merchantID = config?.merchantID
        rq.paynetID = userString?.paynetId
        rq.transDetail = ""
        rq.amount = amountValue
        rq.fee = 0
        rq.transAmount = amountValue
        rq.transReason = ""
        //        data.ProviderAcntID =
        let shopId = storeModel == nil ? cuaHang?.LinkID : storeModel?.LinkID
        rq.ShopID = "\(shopId ?? 0)"
        rq.BalanceType = balanceType
        if typeWithdraw == 0 {
            rq.bankID = userString?.bankId
            rq.accountNumber = userString?.paymentAccNo
        } else if typeWithdraw == 1 {
            rq.mobileNumber = tfSoTaiKhoan.text
            rq.walletID = walletSelected?.id
        } else {
            rq.posID = merchantMobile?.posID
        }
        rq.fullName = tfFullName.text
        rq.withdrawCategory = array[typeWithdraw].value
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.createRequest(data: rqString, code: Constants.withdrawCode) { stt, data in
            self.hideLoading()
            if stt == true {
//                let alert = UIAlertController(title: "THÔNG BÁO", message: "Yêu cầu rút tiền của bạn đã được ghi nhận và xử lý trong vòng không quá 24 giờ làm việc.", preferredStyle: .alert)
//                let okaction = UIAlertAction(title: "OK", style: .default) { _ in
//                    self.navigationController?.popViewController(animated: true)
//                }
                
                let vc = SuccessPaymentVC()
                vc.callBackListener = self
                vc.titile = "Thành công"
                vc.message = "Yêu cầu rút tiền của bạn đã được ghi nhận và xử lý trong vòng không quá 24 giờ làm việc."
                let popup = PopupDialog(viewController: vc,
                                        buttonAlignment: .horizontal,
                                        transitionStyle: .fadeIn,
                                        tapGestureDismissal: true,
                                        panGestureDismissal: true)
                self.present(popup, animated: true, completion: nil)
                if let delegate = self.delegate {
                    delegate.update()
                }
                SwiftEventBus.post("UpdateData", sender: NotifyData.UPDATE)
            } else {
                self.view.makeToast(data, duration: 2, position: .center)
            }
        }
    }
    func onClose() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func toHistoryWithdraw(){
        let vcv = HistoryWithdrawVC()
        vcv.balanceType = balanceType
        navigationController?.pushViewController(vcv, animated: true)
    }
}
extension WithdrawVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfChonTypeRutTien {
            chonHinhThucRutTien_touchUp()
            return false
        }
        if textField == tfSelectWallet {
            selectWallet_touchUp()
            return false
        }
        if textField == tfChonChiNhanh {
            chonChiNhanh_touchUp()
            return false
        }
        if textField == tfChonCuaHang {
            chonCuaHang_touchUp()
            return false
        }
        if textField == tfChonTKRutTien {
            chonTaiKhoanRut_touchUp()
            return false
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfAmount {
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Xác nhận"
            let invocation = IQInvocation(self, #selector(confirmWithdraw))
            textField.keyboardToolbar.doneBarButton.invocation = invocation
        } else {
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Xong"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let array = Configs.isXoSo() ? Constants.hinhThucRutTienXS : Constants.hinhThucRutTien
        if array[typeWithdraw].id == 1 && textField == tfSoTaiKhoan {
            return textField.maxLength(range: range, string: string, max: 10)
        } else if textField == tfAmount {
            return textField.maxLength(range: range, string: string, max: 11)
        } else {
            return false
        }
    }
}
protocol UpdateDataDelegate {
    func update()
}
enum NotifyData{
    case  NOTHING,UPDATE
}
