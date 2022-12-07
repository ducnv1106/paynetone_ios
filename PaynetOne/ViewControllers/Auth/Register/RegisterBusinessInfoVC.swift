//
//  RegisterBusinessInfoVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 07/09/2022.
//

import UIKit
import SwiftTheme

class RegisterBusinessInfoVC: BaseUI {
    private var lbTitle = POMaker.makeLabel(text: "2. Thông tin kinh doanh", font: .helvetica.withSize(16).setBold())
    private var scrollView = POMaker.makeScrollView()
    private var btnUpdate = POMaker.makeButton(title: "Xác nhận")
    private var lbSelectTypeBusiness = POMaker.makeLabel(text: "Chọn loại hình kinh doanh")
    var tfSelectTypeBusiness = POMaker.makeTextField()
    private var lbSelectFormBusiness = POMaker.makeLabel(text: "Chọn hình thức kinh doanh")
    var tfSelectFormBusiness = POMaker.makeTextField()
    private var lbService = POMaker.makeLabel(text: "Dịch vụ *", require: true)
    var tfService = POMaker.makeTextField()
    private var lbServiceRequire = POMaker.makeLabel(text: "Dịch vụ yêu cầu cung cấp *", require: true)
    var tfServiceRequire = POMaker.makeTextField()
    
    private var lbInfoBusiness = POMaker.makeLabel(text: "Thông tin đăng ký kinh doanh", font: .helvetica.withSize(16).setBold())
    private var lbPhoneNumber = POMaker.makeLabel(text: "Số điện thoại *", require: true)
    private var tfPhoneNumber = POMaker.makeTextField()
    private var lbTaxCode = POMaker.makeLabel(text: "Mã số thuế *", require: true)
    private var tfTaxCode = POMaker.makeTextField(placeholder: "Nhập mã số thuế")
    private var lbFax = POMaker.makeLabel(text: "Fax")
    private var tfFax = POMaker.makeTextField(placeholder: "Nhập số fax")
    private var lbFamilyBusinessNumber = POMaker.makeLabel(text: "Mã số đăng ký hộ kinh doanh")
    private var tfFamilyBusinessNumber = POMaker.makeTextField(placeholder: "Nhập mã số đăng ký hộ kinh doanh")
    private var lbCompanyName = POMaker.makeLabel(text: "Tên công ty *", require: true)
    private var tfCompanyName = POMaker.makeTextField(placeholder: "Nhập tên công ty")
    private var lbQRName = POMaker.makeLabel(text: "Tên in trên QR *", require: true)
    private var tfQRName = POMaker.makeTextField(placeholder: "Nhập tên in trên QR")
    private var lbMerchandise = POMaker.makeLabel(text: "Hàng hóa kinh doanh *", require: true)
    var tfMerchandise = POMaker.makeTextField(placeholder: "Chọn Loại dịch vụ hàng hóa", isSelector: true)
    private var lbCity = POMaker.makeLabel(text: "Tỉnh/Thành phố *", require: true)
    var tfCity = POMaker.makeTextField(placeholder: "Chọn Tỉnh/Thành phố", isSelector: true)
    private var lbDistrict = POMaker.makeLabel(text: "Quận/Huyện *", require: true)
    var tfDistrict = POMaker.makeTextField(placeholder: "Chọn Quận/Huyện", isSelector: true)
    private var lbWard = POMaker.makeLabel(text: "Xã/Phường *", require: true)
    var tfWard = POMaker.makeTextField(placeholder: "Chọn Xã/Phường", isSelector: true)
    private var lbAddress = POMaker.makeLabel(text: "Địa chỉ *", require: true)
    private var tfAddress = POMaker.makeTextField(placeholder: "Nhập địa chỉ")
    private var lbPosId = POMaker.makeLabel(text: "PosID *", require: true)
    var tfPosId = POMaker.makeTextField(placeholder: "Nhập PosID")
    
    private var lbRepresentativeInfo = POMaker.makeLabel(text: "Thông tin người đại diện", font: .helvetica.withSize(16).setBold())
    private var lbRepresentativeName = POMaker.makeLabel(text: "Họ và tên *", require: true)
    private var tfRepresentativeName = POMaker.makeTextField(placeholder: "Nhập họ và tên")
    private var lbChucVu = POMaker.makeLabel(text: "Chức vụ")
    private var tfChucVu = POMaker.makeTextField(placeholder: "Nhập chức vụ")
    private var lbDaiDienPhone = POMaker.makeLabel(text: "Số điện thoại *", require: true)
    var tfDaiDienPhone = POMaker.makeTextField(placeholder: "Nhập số điện thoại")
    private var lbSoGTTT = POMaker.makeLabel(text: "Số GTTT *", require: true)
    private var tfSoGTTT = POMaker.makeTextField(placeholder: "Nhập số giấy tờ tùy thân")
    
    private var lbImageCanCuoc = POMaker.makeLabel(text: "Ảnh CMND/CCCD/Hộ chiếu mặt trước *", require: true)
    var tfImageCanCuoc = POMaker.makeTextField()
    var imagePIDBefore = POMaker.makeImage(image: "default_image", tintColor: .blueColor)
    private var lbImagePIDSau = POMaker.makeLabel(text: "Ảnh CMND/CCCD/Hộ chiếu mặt sau *", require: true)
    var tfImagePIDSau = POMaker.makeTextField()
    var imagePIDAfter = POMaker.makeImage(image: "default_image", tintColor: .blueColor)
    private var lbNguoiDaiDien = POMaker.makeLabel(text: "Người đại diện có phải người ký hợp đồng")
    private var isRepresentative = SelectTruFalse()
    
    private var lbInfoPayment = POMaker.makeLabel(text: "Thông tin thanh toán", font: .helvetica.withSize(16).setBold())
    private var lbAccountHolder = POMaker.makeLabel(text: "Tên chủ tài khoản *", require: true)
    private var tfAccountHolder = POMaker.makeTextField(placeholder: "Nhập tên chủ tài khoản")
    private var lbBankNumber = POMaker.makeLabel(text: "Số tài khoản *", require: true)
    private var tfBankNumber = POMaker.makeTextField(placeholder: "Nhập số tài khoản")
    private var lbBank = POMaker.makeLabel(text: "Ngân hàng *", require: true)
    var tfBank = POMaker.makeTextField(placeholder: "Chọn ngân hàng", isSelector: true)
    private var lbBankBranch = POMaker.makeLabel(text: "Chi nhánh")
    var tfBankBranch = POMaker.makeTextField(placeholder: "Nhập chi nhánh")
    
    private var lbChungTu = POMaker.makeLabel(text: "Chứng từ cần thiết", font: .helvetica.withSize(16).setBold())
    private var lbChungTuDangKy = POMaker.makeLabel(text: "Chứng nhận đăng ký kinh doanh/hộ kinh doanh *", require: true)
    var tfChungTuDangKy = POMaker.makeTextField()
    var imageChungNhanDangKy = POMaker.makeImage(image: "default_image", tintColor: .blueColor)
    private var lbHinhChup = POMaker.makeLabel(text: "Hình chụp điểm bán hàng *", require: true)
    var tfHinhChup = POMaker.makeTextField()
    var imageAreaSell = POMaker.makeImage(image: "default_image", tintColor: .blueColor)
    private var lbImageMaSoThue = POMaker.makeLabel(text: "Ảnh mã số thuế *", require: true)
    var tfImageMaSoThue = POMaker.makeTextField()
    var imageTaxCode = POMaker.makeImage(image: "default_image", tintColor: .blueColor)
    private var lbChungTuKhac = POMaker.makeLabel(text: "Các chứng từ khác (nếu có)")
    var tfChungTuKhac = POMaker.makeTextField()
    var imageChungTuKhac = POMaker.makeImage(image: "default_image", tintColor: .blueColor)
    
    private var lbBusinessOnline = POMaker.makeLabel(text: "Kinh doanh Online", font: .helvetica.withSize(16).setBold(), alignment: .center)
    private var lbLinkWebsite = POMaker.makeLabel(text: "Link website, link tải app *", require: true)
    private var tfLinkWebsite = POMaker.makeTextField(placeholder: "Nhập link website, link tải app")
    private var lbImageApp = POMaker.makeLabel(text: "Hình chụp app")
    var tfImageApp = POMaker.makeTextField()
    var imageApp = POMaker.makeImage(image: "default_image", tintColor: .blueColor)
    
    private var businessInfoStack = POMaker.makeStackView(spacing: 6, distri: .fill)
    private var representativeInfoStack = POMaker.makeStackView(spacing: 6, distri: .fill)
    private var chungTuInfoStack = POMaker.makeStackView(spacing: 6, distri: .fill)
    private var kinhDoanhOnlineStack = POMaker.makeStackView(spacing: 6, distri: .fill)
    
    private var viewTrangThaiHoSo = POMaker.makeView()
    private var lbTrangThaiHoSo = POMaker.makeLabel(text: "Trạng thái hồ sơ")
    private var trangThaiView = StatusView()
    
    private var lbEditProfile = POMaker.makeLabel(text: "Bổ sung hồ sơ")
    private var tfEditPorfile = POMaker.makeTextField(text: "Bổ sung", placeholder: "Bổ sung")
    private var viewEditProfile = POMaker.makeView()
    
    var merchandiseService = [BusinessServiceModel]()
    var merService: BusinessServiceModel?
    var provinces = [AreaModel]()
    var businessType = 0
    var businessTypeSelected = "" {
        didSet {
            configUI()
            switch businessTypeSelected {
            case "1": businessType = 0
            case "2": businessType = 1
            case "3": businessType = 2
            case "4": businessType = 3
            case "5": businessType = 4
            default:
                break
            }
        }
    }
    var qrCodeType = ""
    //    var formalityType = 0
    //    var serviceType = 0
    //    var qrCodeType = 0
    var province: AreaModel?
    var district: AreaModel? {
        didSet {
            self.tfDistrict.text = district?.name
        }
    }
    var ward: AreaModel? {
        didSet{self.tfWard.text = ward?.name}
    }
    var imagePicker: ImagePicker?
    var isTakePhotoPIDBefore = false
    var photoPIDBefore = ""
    var bankList = [BanksModel]()
    var isTakePhotoPIDAfter = false
    var photoPIDAfter = ""
    var bankSelected: BanksModel?
    var isTakePhotoRegisterBusiness = false
    var photoRegisterBusiness = ""
    var isTakePhotoSellArea = false
    var photoSellArea = ""
    var isTakePhotoTaxCode = false
    var photoTaxCode = ""
    var isTakePhotoChungTuKhac = false
    var photoChungTuKhac = ""
    var isTakePhotoApp = false
    var photoApp = ""
    var mobileNumber = "" {
        didSet{
            tfPhoneNumber.text = mobileNumber
        }
    }
    var name = ""
    var email = ""
    var isUpdateMerchant = true {
        didSet{
            if !isUpdateMerchant {
                viewEditProfile.isHidden = true
                self.viewEditProfile.height(0)
                self.view.layoutIfNeeded()
            }
        }
    }
    var titleBtnUpdate = ""{
        didSet{
            btnUpdate.setTitle(titleBtnUpdate, for: .normal)
        }
    }
    //    var isEditMer = false
    var merchantFile: MerchantFileModel? {
        didSet {
            if merchantFile?.status == "A" {
                if merchantFile?.addInfoStatus == "A" {
                    trangThaiView.label.text = "Bổ sung hồ sơ"
                    trangThaiView.backgroundColor = Colors.green
                } else {
                    trangThaiView.label.text = "Chờ phê duyệt"
                    trangThaiView.backgroundColor = .blueColor
                }
            } else if merchantFile?.status == "P" {
                trangThaiView.label.text = "Đã phê duyệt"
                trangThaiView.backgroundColor = Colors.green
            } else {
                trangThaiView.label.text = "Đã hủy"
                trangThaiView.backgroundColor = .red
            }
            
            if merchantFile?.addInfoStatus == "A" {
                tfEditPorfile.text = merchantFile?.addInfo ?? ""
                viewEditProfile.isHidden = false
                
            }else{
                viewEditProfile.isHidden = true
                self.viewEditProfile.height(0)
                self.view.layoutIfNeeded()
            }
            
            name = merchantFile?.name ?? ""
            email = merchantFile?.email ?? ""
            
        }
    }
    var selectedFormalityType: [String] = ["1"]
    var hinhThucKinhDoanh = "1" { //default kinh doanh online là id 1
        didSet {
            configHinhThucKinhDoanh()
        }
    }
    var selectedServiceType: [String] = []
    var dichVu = "1" //default thanh toán QR là id 1
    var dvYcCc: [String] = []
    var dichVuYcCc = "2" //default QR code tĩnh là id 1
    var posCodeModel = [DicGetPos]()
    let isDarkMode = StoringService.shared.isDarkMode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ĐĂNG KÝ TÀI KHOẢN"
        setupView()
        setupRegisterBusinessInfo()
        setupViewRepresentative()
        setupInfoPayment()
        setupViewKinhDoanhOnline()
        configUI()
        fetchData()
        getProvince()
        getListBank()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        setupValue()
//        configThemeView()
        configBackgorundColor()
        
    }
    

    
     override func configBackgorundColor() {
        super.configBackgorundColor()
         if StoringService.shared.isDarkMode(){
             viewEditProfile.backgroundColor = .black
         }else{
             viewEditProfile.backgroundColor = .backgroundColor
         }
    }
    
    
    private func setupValue(){
        tfSelectTypeBusiness.text = Constants.businessType[businessType].name
        //        tfSelectFormBusiness.text = Constants.formalityType[formalityType].name
        tfSelectFormBusiness.text = "Kinh doanh Online"
        //        tfService.text = Constants.serviceType[serviceType].name
        tfService.text = "Thanh toán QR"
        tfServiceRequire.text = "QR code động"//Constants.qrCodeType[qrCodeType].name
        if merchantFile != nil {
            // load hình thức  kinh doanh
            businessTypeSelected = merchantFile?.businessType ?? ""
            tfSelectTypeBusiness.text = Constants.businessTypeString(merchantFile?.businessType ?? "")
            selectedFormalityType.removeAll()
            if let formType = merchantFile?.formalityType?.split(separator: ";"), !formType.isEmpty {
                var formTypeString = ""
                for (idx, item) in formType.enumerated() {
                    selectedFormalityType.append(String(item))
                    formTypeString += Constants.fomalityString(String(item)) + (idx < formType.count - 1 ? ", " : "")
                }
                tfSelectFormBusiness.text = formTypeString
            }
            
            
            // load dịch vụ
            dichVu = merchantFile?.serviceType ?? ""
            if let serverTypes = merchantFile?.serviceType?.split(separator: ";"),serverTypes.count>0{
                var contentServices = ""
                for (idx, item) in serverTypes.enumerated() {
                    contentServices += Constants.serviceTypeString(String(item)) + (idx < serverTypes.count - 1 ? ", " : "")
                    if String(item) == "1" || String(item) == "2"{
                        selectedServiceType.append(String(item))
                    }
                }
                tfService.text = contentServices
            }
            // load qr code
            dichVuYcCc = merchantFile?.qrOption ?? ""
            if let qrOptions = merchantFile?.qrOption?.split(separator: ";"),qrOptions.count>0{
                var contentQr = ""
                for (idx, item) in qrOptions.enumerated() {
                    contentQr += Constants.qrOptionString(String(item)) + (idx < qrOptions.count - 1 ? ", " : "")
                    if String(item) == "1" || String(item) == "2" {
                        dvYcCc.append(String(item))
                    }
                }
                tfServiceRequire.text = contentQr
            }
            
            hinhThucKinhDoanh = merchantFile?.formalityType ?? ""
            mobileNumber = merchantFile?.mobileNumber ?? ""
            tfQRName.text = merchantFile?.printQRName
            tfMerchandise.text = merchantFile?.businessServiceName
            let merServiceObj = BusinessServiceModel()
            merServiceObj.id = merchantFile?.businessServiceID
            merServiceObj.name = merchantFile?.businessServiceName
            merService = merServiceObj
            tfCity.text = merchantFile?.provinceName
            let cityData = AreaModel()
            cityData.id = merchantFile?.provinceID ?? 0
            cityData.name = merchantFile?.provinceName ?? ""
            province = cityData
            
            tfDistrict.text = merchantFile?.districtName
            let districtData = AreaModel()
            districtData.id = merchantFile?.districtID ?? 0
            districtData.name = merchantFile?.districtName ?? ""
            district = districtData
            
            tfWard.text = merchantFile?.wardName
            let wardData = AreaModel()
            wardData.id = merchantFile?.wardID ?? 0
            wardData.name = merchantFile?.wardName ?? ""
            ward = wardData
            tfAddress.text = merchantFile?.address
            tfRepresentativeName.text = merchantFile?.representativeName
            tfSoGTTT.text = merchantFile?.representativePIDNumber
            imagePIDBefore.kfImage(urlStr: Constants.fileUploadUrl + Constants.photoIDPath + (merchantFile?.representativePIDImageBefore ?? ""))
            photoPIDBefore = merchantFile?.representativePIDImageBefore ?? ""
            
            imagePIDAfter.kfImage(urlStr: Constants.fileUploadUrl + Constants.photoIDPath + (merchantFile?.representativePIDImageAfter ?? ""))
            photoPIDAfter = merchantFile?.representativePIDImageAfter ?? ""
            tfAccountHolder.text = merchantFile?.paymentAccountName
            tfBankNumber.text = merchantFile?.paymentAccountNumber
            tfBankBranch.text = merchantFile?.paymentAccountBranch
            tfLinkWebsite.text = merchantFile?.linkWebsite
            tfTaxCode.text = merchantFile?.taxCode
            tfFax.text = merchantFile?.fax//BanksModel
            tfCompanyName.text = merchantFile?.companyName
            tfChucVu.text = merchantFile?.representativePosition
            tfDaiDienPhone.text = merchantFile?.representativeMobile
            if let imageOther = merchantFile?.documents?.split(separator: ";"), !imageOther.isEmpty {
                if imageOther.count == 1 {
                    self.imageChungNhanDangKy.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[0])
                    self.photoRegisterBusiness = String(imageOther[0])
                }
                if imageOther.count == 2 {
                    self.imageChungNhanDangKy.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[0])
                    self.imageAreaSell.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[1])
                    self.photoRegisterBusiness = String(imageOther[0])
                    self.photoSellArea = String(imageOther[1])
                }
                if imageOther.count == 3 {
                    self.imageChungNhanDangKy.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[0])
                    self.imageAreaSell.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[1])
                    self.imageTaxCode.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[2])
                    self.photoRegisterBusiness = String(imageOther[0])
                    self.photoSellArea = String(imageOther[1])
                    self.photoTaxCode = String(imageOther[2])
                }
                if imageOther.count == 4 {
                    self.imageChungNhanDangKy.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[0])
                    self.imageAreaSell.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[1])
                    self.imageTaxCode.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[2])
                    self.imageChungTuKhac.kfImage(urlStr: Constants.imageUrl + "/" + imageOther[3])
                    self.photoRegisterBusiness = String(imageOther[0])
                    self.photoSellArea = String(imageOther[1])
                    self.photoTaxCode = String(imageOther[2])
                    self.photoChungTuKhac = String(imageOther[3])
                }
            }
            if merchantFile?.imagesApp != "" {
                imageApp.kfImage(urlStr: Constants.imageUrl + "/" + (merchantFile?.imagesApp ?? ""))
            }
            if merchantFile?.addInfoStatus == "A" && merchantFile?.status == "A"  {
                btnUpdate.setTitle("Cập nhật", for: .normal)
            } else {
                btnUpdate.height(0)
                btnUpdate.isHidden = true
            }
            title = "HỒ SƠ MERCHANT"
            viewTrangThaiHoSo.height(40)
        } else {
            viewTrangThaiHoSo.height(0)
        }
        //        if isUpdateMerchant {
        //            btnUpdate.setTitle("Cập nhật", for: .normal)
        //        }
        if merchantFile == nil{
            lbFamilyBusinessNumber.isHidden = true
            tfFamilyBusinessNumber.isHidden = true
        }
        
        tfPosId.text = merchantFile?.posID
        if merchantFile?.businessType ?? "" == "4" || merchantFile?.businessType ?? "" == "5" {
            lbPosId.isHidden = false
            tfPosId.isHidden = false
        }else{
            lbPosId.isHidden = true
            tfPosId.isHidden = true
        }
        
    }
    private func setupView(){
        view.addSubviews(views: lbTitle, viewTrangThaiHoSo, btnUpdate, scrollView)
        lbTitle.safeTop(toView: view, space: 14)
        lbTitle.left(toView: view, space: 14)
        
        viewTrangThaiHoSo.top(toAnchor: lbTitle.bottomAnchor, space: 10)
        viewTrangThaiHoSo.horizontal(toView: view)
        viewTrangThaiHoSo.backgroundColor = .clear
        viewTrangThaiHoSo.addSubviews(views: lbTrangThaiHoSo, trangThaiView)
        lbTrangThaiHoSo.left(toView: viewTrangThaiHoSo, space: 14)
        lbTrangThaiHoSo.centerY(toView: viewTrangThaiHoSo)
        trangThaiView.right(toView: viewTrangThaiHoSo, space: 14)
        trangThaiView.centerY(toView: viewTrangThaiHoSo)
        
        btnUpdate.safeBottom(toView: view, space: 10)
        btnUpdate.horizontal(toView: view, space: 16)
        btnUpdate.height(50)
        btnUpdate.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        scrollView.top(toAnchor: viewTrangThaiHoSo.bottomAnchor, space: 10)
        scrollView.bottom(toAnchor: btnUpdate.topAnchor, space: 10)
        scrollView.horizontal(toView: view)
        
        scrollView.addSubviews(views: viewEditProfile,lbSelectTypeBusiness, tfSelectTypeBusiness, lbSelectFormBusiness, tfSelectFormBusiness, lbService, tfService, lbServiceRequire, tfServiceRequire)
        
        viewEditProfile.viewConstraints(top: scrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        
        viewEditProfile.addSubviews(views:lbEditProfile,tfEditPorfile)
//        viewEditProfile.backgroundColor = .backgroundColor
        
        lbEditProfile.viewConstraints(top: viewEditProfile.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, padding: UIEdgeInsets(top: 4, left: 14, bottom: 0, right: 0) )
        
        tfEditPorfile.viewConstraints(top: lbEditProfile.bottomAnchor, left: view.leftAnchor, bottom: viewEditProfile.bottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 14, bottom: 0, right: 14) )
        tfEditPorfile.height(50)
        tfEditPorfile.isUserInteractionEnabled = false
        

        
        
        lbSelectTypeBusiness.top(toAnchor: viewEditProfile.bottomAnchor, space: 10)
        lbSelectTypeBusiness.left(toView: view, space: 14)
        tfSelectTypeBusiness.top(toAnchor: lbSelectTypeBusiness.bottomAnchor, space: 6)
        tfSelectTypeBusiness.horizontal(toView: view, space: 14)
        tfSelectTypeBusiness.height(50)
        tfSelectTypeBusiness.delegate = self
        
        lbSelectFormBusiness.top(toAnchor: tfSelectTypeBusiness.bottomAnchor, space: 14)
        lbSelectFormBusiness.left(toView: view, space: 14)
        tfSelectFormBusiness.top(toAnchor: lbSelectFormBusiness.bottomAnchor, space: 6)
        tfSelectFormBusiness.horizontal(toView: view, space: 14)
        tfSelectFormBusiness.height(50)
        tfSelectFormBusiness.delegate = self
        
        lbService.top(toAnchor: tfSelectFormBusiness.bottomAnchor, space: 14)
        lbService.left(toView: view, space: 14)
        tfService.top(toAnchor: lbService.bottomAnchor, space: 6)
        tfService.horizontal(toView: view, space: 14)
        tfService.height(50)
        tfService.delegate = self
        
        lbServiceRequire.top(toAnchor: tfService.bottomAnchor, space: 14)
        lbServiceRequire.left(toView: view, space: 14)
        tfServiceRequire.top(toAnchor: lbServiceRequire.bottomAnchor, space: 6)
        tfServiceRequire.horizontal(toView: view, space: 14)
        tfServiceRequire.height(50)
        tfServiceRequire.delegate = self
    }
    private func setupRegisterBusinessInfo(){
        scrollView.addSubviews(views: lbInfoBusiness, businessInfoStack)
        lbInfoBusiness.top(toAnchor: tfServiceRequire.bottomAnchor, space: 18)
        lbInfoBusiness.centerX(toView: view)
        
        businessInfoStack.top(toAnchor: lbInfoBusiness.bottomAnchor, space: 4)
        businessInfoStack.horizontal(toView: view, space: 14)
        
        businessInfoStack.addArrangedSubviews(lbPhoneNumber, tfPhoneNumber, lbTaxCode, tfTaxCode, lbFax, tfFax, lbFamilyBusinessNumber, tfFamilyBusinessNumber, lbCompanyName, tfCompanyName, lbQRName, tfQRName, lbMerchandise, tfMerchandise, lbCity, tfCity, lbDistrict, tfDistrict, lbWard, tfWard, lbAddress, tfAddress, lbPosId, tfPosId)
        lbPhoneNumber.height(28)
        lbPhoneNumber.contentMode = .bottom
        tfPhoneNumber.height(50)
        tfPhoneNumber.isUserInteractionEnabled = false
        
        lbTaxCode.height(28)
        lbTaxCode.contentMode = .bottom
        tfTaxCode.height(50)
        tfTaxCode.keyboardType = .numberPad
        
        lbFax.height(28)
        lbFax.contentMode = .bottom
        tfFax.height(50)
        tfFax.keyboardType = .numberPad
        
        lbFamilyBusinessNumber.height(28)
        lbFamilyBusinessNumber.contentMode = .bottom
        tfFamilyBusinessNumber.height(50)
        
        lbCompanyName.height(28)
        lbCompanyName.contentMode = .bottom
        tfCompanyName.height(50)
        
        lbQRName.height(28)
        lbQRName.contentMode = .bottom
        tfQRName.height(50)
        
        lbMerchandise.height(28)
        lbMerchandise.contentMode = .bottom
        tfMerchandise.height(50)
        tfMerchandise.delegate = self
        
        lbCity.height(28)
        lbCity.contentMode = .bottom
        tfCity.height(50)
        tfCity.delegate = self
        
        lbDistrict.height(28)
        lbDistrict.contentMode = .bottom
        tfDistrict.height(50)
        tfDistrict.delegate = self
        
        lbWard.height(28)
        lbWard.contentMode = .bottom
        tfWard.height(50)
        tfWard.delegate = self
        
        lbAddress.height(28)
        lbAddress.contentMode = .bottom
        tfAddress.height(50)
        
        lbPosId.height(28)
        lbPosId.contentMode = .bottom
        tfPosId.height(50)
        tfPosId.keyboardType = .numberPad
    }
    private func setupViewRepresentative(){
        scrollView.addSubviews(views: lbRepresentativeInfo, representativeInfoStack)
        
        lbRepresentativeInfo.top(toAnchor: businessInfoStack.bottomAnchor, space: 18)
        lbRepresentativeInfo.centerX(toView: view)
        representativeInfoStack.top(toAnchor: lbRepresentativeInfo.bottomAnchor, space: 14)
        representativeInfoStack.horizontal(toView: view, space: 14)
        representativeInfoStack.addArrangedSubviews(lbRepresentativeName, tfRepresentativeName, lbChucVu, tfChucVu, lbDaiDienPhone, tfDaiDienPhone, lbSoGTTT, tfSoGTTT, lbImageCanCuoc, tfImageCanCuoc, lbImagePIDSau, tfImagePIDSau, lbNguoiDaiDien, isRepresentative)
        
        lbRepresentativeName.height(28)
        lbRepresentativeName.contentMode = .bottom
        tfRepresentativeName.height(50)
        
        lbChucVu.height(28)
        lbChucVu.contentMode = .bottom
        tfChucVu.height(50)
        
        lbDaiDienPhone.height(28)
        lbDaiDienPhone.contentMode = .bottom
        tfDaiDienPhone.height(50)
        tfDaiDienPhone.keyboardType = .phonePad
        tfDaiDienPhone.delegate = self
        
        lbSoGTTT.height(28)
        lbSoGTTT.contentMode = .bottom
        tfSoGTTT.height(50)
        
        lbImageCanCuoc.height(28)
        lbImageCanCuoc.contentMode = .bottom
        tfImageCanCuoc.delegate = self
        tfImageCanCuoc.addSubview(imagePIDBefore)
        imagePIDBefore.vertical(toView: tfImageCanCuoc, space: 6)
        imagePIDBefore.centerX(toView: tfImageCanCuoc)
        imagePIDBefore.tintColor = .blueColor
        imagePIDBefore.size(CGSize(width: 60, height: 60))
        
        
        lbImagePIDSau.height(28)
        lbImagePIDSau.contentMode = .bottom
        tfImagePIDSau.addSubview(imagePIDAfter)
        imagePIDAfter.vertical(toView: tfImagePIDSau, space: 6)
        imagePIDAfter.centerX(toView: tfImagePIDSau)
        imagePIDAfter.tintColor = .blueColor
        imagePIDAfter.size(CGSize(width: 60, height: 60))
        tfImagePIDSau.delegate = self
        
        lbNguoiDaiDien.height(28)
        lbNguoiDaiDien.contentMode = .bottom
        isRepresentative.height(50)
    }
    private func setupInfoPayment(){
        scrollView.addSubviews(views: lbInfoPayment, lbAccountHolder, tfAccountHolder, lbBankNumber, tfBankNumber, lbBank, tfBank, lbBankBranch, tfBankBranch, lbChungTu, chungTuInfoStack)
        lbInfoPayment.top(toAnchor: representativeInfoStack.bottomAnchor, space: 14)
        lbInfoPayment.centerX(toView: view)
        
        lbAccountHolder.top(toAnchor: lbInfoPayment.bottomAnchor, space: 14)
        lbAccountHolder.left(toView: view, space: 14)
        tfAccountHolder.top(toAnchor: lbAccountHolder.bottomAnchor, space: 6)
        tfAccountHolder.horizontal(toView: view, space: 14)
        tfAccountHolder.height(50)
        
        lbBankNumber.top(toAnchor: tfAccountHolder.bottomAnchor, space: 14)
        lbBankNumber.left(toView: view, space: 14)
        tfBankNumber.top(toAnchor: lbBankNumber.bottomAnchor, space: 6)
        tfBankNumber.horizontal(toView: view, space: 14)
        tfBankNumber.height(50)
        tfBankNumber.keyboardType = .numberPad
        
        lbBank.top(toAnchor: tfBankNumber.bottomAnchor, space: 14)
        lbBank.left(toView: view, space: 14)
        tfBank.top(toAnchor: lbBank.bottomAnchor, space: 6)
        tfBank.horizontal(toView: view, space: 14)
        tfBank.height(50)
        tfBank.delegate = self
        
        lbBankBranch.top(toAnchor: tfBank.bottomAnchor, space: 14)
        lbBankBranch.left(toView: view, space: 14)
        tfBankBranch.top(toAnchor: lbBankBranch.bottomAnchor, space: 6)
        tfBankBranch.horizontal(toView: view, space: 14)
        tfBankBranch.height(50)
        
        lbChungTu.top(toAnchor: tfBankBranch.bottomAnchor, space: 14)
        lbChungTu.centerX(toView: view)
        
        chungTuInfoStack.top(toAnchor: lbChungTu.bottomAnchor, space: 14)
        chungTuInfoStack.horizontal(toView: view, space: 14)
        chungTuInfoStack.addArrangedSubviews(lbChungTuDangKy, tfChungTuDangKy, lbHinhChup, tfHinhChup, lbImageMaSoThue, tfImageMaSoThue, lbChungTuKhac, tfChungTuKhac)
        
        lbChungTuDangKy.height(28)
        lbChungTuDangKy.contentMode = .bottom
        tfChungTuDangKy.delegate = self
        tfChungTuDangKy.addSubview(imageChungNhanDangKy)
        imageChungNhanDangKy.vertical(toView: tfChungTuDangKy, space: 6)
        imageChungNhanDangKy.centerX(toView: tfChungTuDangKy)
        imageChungNhanDangKy.tintColor = .blueColor
        imageChungNhanDangKy.size(CGSize(width: 60, height: 60))
        
        lbHinhChup.height(28)
        lbHinhChup.contentMode = .bottom
        tfHinhChup.delegate = self
        tfHinhChup.addSubview(imageAreaSell)
        imageAreaSell.vertical(toView: tfHinhChup, space: 6)
        imageAreaSell.centerX(toView: tfHinhChup)
        imageAreaSell.tintColor = .blueColor
        imageAreaSell.size(CGSize(width: 60, height: 60))
        
        lbImageMaSoThue.height(28)
        lbImageMaSoThue.contentMode = .bottom
        tfImageMaSoThue.delegate = self
        tfImageMaSoThue.addSubview(imageTaxCode)
        imageTaxCode.vertical(toView: tfImageMaSoThue, space: 6)
        imageTaxCode.centerX(toView: tfImageMaSoThue)
        imageTaxCode.tintColor = .blueColor
        imageTaxCode.size(CGSize(width: 60, height: 60))
        
        lbChungTuKhac.height(28)
        lbChungTuKhac.contentMode = .bottom
        tfChungTuKhac.delegate = self
        tfChungTuKhac.addSubview(imageChungTuKhac)
        imageChungTuKhac.vertical(toView: tfChungTuKhac, space: 6)
        imageChungTuKhac.centerX(toView: tfChungTuKhac)
        imageChungTuKhac.tintColor = .blueColor
        imageChungTuKhac.size(CGSize(width: 60, height: 60))
    }
    private func setupViewKinhDoanhOnline(){
        scrollView.addSubviews(views: kinhDoanhOnlineStack)
        kinhDoanhOnlineStack.top(toAnchor: chungTuInfoStack.bottomAnchor, space: 14)
        kinhDoanhOnlineStack.horizontal(toView: view, space: 14)
        kinhDoanhOnlineStack.bottom(toView: scrollView, space: 20)
        
        kinhDoanhOnlineStack.addArrangedSubviews(lbBusinessOnline, lbLinkWebsite, tfLinkWebsite, lbImageApp, tfImageApp)
        lbBusinessOnline.height(50)
        lbBusinessOnline.horizontal(toView: kinhDoanhOnlineStack)
        
        lbLinkWebsite.height(28)
        lbLinkWebsite.contentMode = .bottom
        tfLinkWebsite.height(50)
        
        lbImageApp.height(28)
        lbImageApp.contentMode = .bottom
        tfImageApp.delegate = self
        tfImageApp.addSubview(imageApp)
        imageApp.vertical(toView: tfImageApp, space: 6)
        imageApp.centerX(toView: tfImageApp)
        imageApp.tintColor = .blueColor
        imageApp.size(CGSize(width: 60, height: 60))
    }
    private func configUI(){
        switch businessTypeSelected {
        case "1"://Doanh nghiệp
            lbFamilyBusinessNumber.isHidden = true
            tfFamilyBusinessNumber.isHidden = true
            
            if StoringService.shared.isDarkMode() {
                lbHinhChup.text = "Hình chụp điểm bán hàng *"
                lbChungTuDangKy.text = "Chứng nhận đăng ký kinh doanh/hộ kinh doanh *"
                lbImageMaSoThue.text = "Ảnh mã số thuế *"
                lbTaxCode.text = "Mã số thuế *"
            }else{
                lbImageMaSoThue.attributedText = "Ảnh mã số thuế *".attributedLastString()
                lbTaxCode.attributedText = "Mã số thuế *".attributedLastString()
                lbChungTuDangKy.attributedText = "Chứng nhận đăng ký kinh doanh/hộ kinh doanh *".attributedLastString()
                lbHinhChup.attributedText = "Hình chụp điểm bán hàng *".attributedLastString()
            }
            lbFax.isHidden = false
            tfFax.isHidden = false
            tfSelectFormBusiness.isUserInteractionEnabled = true
            if StoringService.shared.isDarkMode() {
                tfSelectFormBusiness.backgroundColor = .black
                tfService.backgroundColor = .black
            }else{
                tfSelectFormBusiness.backgroundColor = .backgroundColor
                tfService.backgroundColor = .backgroundColor

            }
            
            //            formalityType = 0
            //            tfSelectFormBusiness.text = Constants.formalityType[formalityType].name
            hinhThucKinhDoanh = "1"
            tfSelectFormBusiness.text = "Kinh doanh Online"
            tfService.isUserInteractionEnabled = true
           
            //            tfService.text = Constants.serviceType[serviceType].name
            dichVu = "1"
            tfService.text = "Thanh toán QR"
            tfTaxCode.isHidden = false
            lbTaxCode.isHidden = false
            lbCompanyName.isHidden = false
            tfCompanyName.isHidden = false
            lbChucVu.isHidden = false
            tfChucVu.isHidden = false
            lbDaiDienPhone.isHidden = false
            tfDaiDienPhone.isHidden = false
            lbNguoiDaiDien.isHidden = false
            isRepresentative.isHidden = false
            lbBusinessOnline.isHidden = false
            lbLinkWebsite.isHidden = false
            tfLinkWebsite.isHidden = false
            lbImageApp.isHidden = false
            tfImageApp.isHidden = false
            lbImageMaSoThue.isHidden = false
            tfImageMaSoThue.isHidden = false
            lbPosId.isHidden = true
            tfPosId.isHidden = true
            selectedFormalityType = ["1"]
        case "2"://hộ kinh doanh
            lbFamilyBusinessNumber.isHidden = false
            tfFamilyBusinessNumber.isHidden = false
            lbTaxCode.text = "Mã số thuế"
            lbImageMaSoThue.text = "Ảnh mã số thuế"
            lbFax.isHidden = true
            tfFax.isHidden = true
            tfSelectFormBusiness.isUserInteractionEnabled = true
            
            if StoringService.shared.isDarkMode() {
                tfSelectFormBusiness.backgroundColor = .black
                tfService.backgroundColor = .black
            }else{
                tfSelectFormBusiness.backgroundColor = .backgroundColor
                tfService.backgroundColor = .backgroundColor

            }
            //            formalityType = 0
            //            tfSelectFormBusiness.text = Constants.formalityType[formalityType].name
            hinhThucKinhDoanh = "1"
            tfSelectFormBusiness.text = "Kinh doanh Online"
            tfService.isUserInteractionEnabled = true
            //            tfService.text = Constants.serviceType[serviceType].name
            dichVu = "1"
            tfService.text = "Thanh toán QR"
            tfTaxCode.isHidden = false
            lbTaxCode.isHidden = false
            lbCompanyName.isHidden = false
            tfCompanyName.isHidden = false
            lbChucVu.isHidden = false
            tfChucVu.isHidden = false
            lbDaiDienPhone.isHidden = false
            tfDaiDienPhone.isHidden = false
            lbNguoiDaiDien.isHidden = false
            isRepresentative.isHidden = false
            lbBusinessOnline.isHidden = false
            lbLinkWebsite.isHidden = false
            tfLinkWebsite.isHidden = false
            lbImageApp.isHidden = false
            tfImageApp.isHidden = false
            lbImageMaSoThue.isHidden = false
            tfImageMaSoThue.isHidden = false
            lbChungTuDangKy.attributedText = "Chứng nhận đăng ký kinh doanh/hộ kinh doanh *".attributedLastString()
            lbHinhChup.attributedText = "Hình chụp điểm bán hàng *".attributedLastString()
            lbPosId.isHidden = true
            tfPosId.isHidden = true
            selectedFormalityType = ["1"]
        case "3"://cá nhân kinh doanh
            tfSelectFormBusiness.isUserInteractionEnabled = false
            tfSelectFormBusiness.backgroundColor = .lightGray
            //            formalityType = 1
            //            tfSelectFormBusiness.placeholder = Constants.formalityType[formalityType].name
            hinhThucKinhDoanh = "2"
            tfSelectFormBusiness.placeholder = "Kinh doanh Offline"
            tfSelectFormBusiness.text = ""
            //            serviceType = 0
            dichVu = "1"
            tfService.isUserInteractionEnabled = false
            tfService.backgroundColor = .lightGray
            //            tfService.placeholder = Constants.serviceType[serviceType].name
            tfService.placeholder = "Thanh toán QR"
            tfService.text = ""
            tfTaxCode.isHidden = true
            tfFamilyBusinessNumber.isHidden = true
            tfCompanyName.isHidden = true
            tfFax.isHidden = true
            lbFax.isHidden = true
            lbTaxCode.isHidden = true
            lbCompanyName.isHidden = true
            lbFamilyBusinessNumber.isHidden = true
            lbChucVu.isHidden = true
            tfChucVu.isHidden = true
            lbDaiDienPhone.isHidden = true
            tfDaiDienPhone.isHidden = true
            lbNguoiDaiDien.isHidden = true
            isRepresentative.isHidden = true
            lbBusinessOnline.isHidden = true
            lbLinkWebsite.isHidden = true
            tfLinkWebsite.isHidden = true
            lbImageApp.isHidden = true
            tfImageApp.isHidden = true
            lbImageMaSoThue.isHidden = true
            tfImageMaSoThue.isHidden = true
            lbChungTuDangKy.text = "Chứng nhận đăng ký kinh doanh/hộ kinh doanh"
            lbHinhChup.text = "Hình chụp điểm bán hàng"
            lbPosId.isHidden = true
            tfPosId.isHidden = true
        case "4","5":
            tfSelectFormBusiness.isUserInteractionEnabled = false
            tfSelectFormBusiness.backgroundColor = .lightGray
            //            formalityType = 1
            //            tfSelectFormBusiness.placeholder = Constants.formalityType[formalityType].name
            hinhThucKinhDoanh = "2"
            tfSelectFormBusiness.placeholder = "Kinh doanh Offline"
            tfSelectFormBusiness.text = ""
            //            serviceType = 0
            dichVu = "1"
            tfService.isUserInteractionEnabled = false
            tfService.backgroundColor = .lightGray
            //            tfService.placeholder = Constants.serviceType[serviceType].name
            tfService.placeholder = "Thanh toán QR"
            tfService.text = ""
            tfTaxCode.isHidden = true
            tfFamilyBusinessNumber.isHidden = true
            tfCompanyName.isHidden = true
            tfFax.isHidden = true
            lbFax.isHidden = true
            lbTaxCode.isHidden = true
            lbCompanyName.isHidden = true
            lbFamilyBusinessNumber.isHidden = true
            lbChucVu.isHidden = true
            tfChucVu.isHidden = true
            lbDaiDienPhone.isHidden = true
            tfDaiDienPhone.isHidden = true
            lbNguoiDaiDien.isHidden = true
            isRepresentative.isHidden = true
            lbBusinessOnline.isHidden = true
            lbLinkWebsite.isHidden = true
            tfLinkWebsite.isHidden = true
            lbImageApp.isHidden = true
            tfImageApp.isHidden = true
            lbImageMaSoThue.isHidden = true
            tfImageMaSoThue.isHidden = true
            lbChungTuDangKy.text = "Chứng nhận đăng ký kinh doanh/hộ kinh doanh"
            lbHinhChup.text = "Hình chụp điểm bán hàng"
            lbPosId.isHidden = false
            tfPosId.isHidden = false
            if province != nil {
                self.getPostID(cityId: province?.id)
            }
        default:
            break
        }
    }
    private func configHinhThucKinhDoanh(){
        if hinhThucKinhDoanh == "2" {
            lbBusinessOnline.isHidden = true
            lbLinkWebsite.isHidden = true
            tfLinkWebsite.isHidden = true
            lbImageApp.isHidden = true
            tfImageApp.isHidden = true
        } else {
            lbBusinessOnline.isHidden = false
            lbLinkWebsite.isHidden = false
            tfLinkWebsite.isHidden = false
            lbImageApp.isHidden = false
            tfImageApp.isHidden = false
        }
    }
    private func fetchData(){
        ApiManager.shared.requestList(code: "DIC_BUSINESS_SERVICES", returnType: BusinessServiceModel.self) { result, err in
            if let result = result {
                self.merchandiseService = result
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    private func getProvince(){
        ApiManager.shared.requestList(code: "DIC_GET_PROVINCE", returnType: AreaModel.self) { result, err in
            if let result = result {
                self.provinces = result
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    private func getListBank(){
        ApiManager.shared.requestList(code: "DIC_GET_BANK", returnType: BanksModel.self) { result, err in
            if let result = result {
                if let merchant = self.merchantFile {
                    let bank = result.first(where: {$0.id == merchant.paymentAccountBank})
                    self.tfBank.text = bank?.shortName
                    self.bankSelected = bank
                }
                self.bankList = result
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    @objc private func register(){
        if Constants.businessType[businessType].id == "1" {
            if !validateBusiness().isEmpty {
                self.showToast(message: validateBusiness(), delay: 2)
                return
            }
        } else if Constants.businessType[businessType].id == "2" {
            if !validateGerenal().isEmpty {
                self.showToast(message: validateGerenal(), delay: 2)
                return
            }
        } else if Constants.businessType[businessType].id == "3" {
            if !validatePersonal().isEmpty {
                self.showToast(message: validatePersonal(), delay: 2)
                return
            }
        } else {
            if !validatePersonal().isEmpty {
                self.showToast(message: validatePersonal(), delay: 2)
                return
            }
        }
        onRegisterBusiness()
    }
    private func onRegisterBusiness(){
        let rq = RegisterBusinessInfo()
        rq.id = merchantFile?.id
        rq.provinceID = province?.id
        rq.districtID = district?.id
        rq.wardID = ward?.id
        rq.businessServiceID = merService?.id
        rq.mobileNumber = mobileNumber
        rq.name = name
        rq.email = email
        rq.businessType = Constants.businessType[businessType].id
        rq.businessMobile = mobileNumber
        //        rq.formalityType = Constants.formalityType[formalityType].id
        rq.formalityType = hinhThucKinhDoanh //kinh doanh on hay off
        rq.taxCode = tfTaxCode.text?.trimmingCharacters(in: .whitespaces)
        rq.fax = tfFax.text?.trimmingCharacters(in: .whitespaces)
        rq.contractCode = tfFamilyBusinessNumber.text?.trimmingCharacters(in: .whitespaces)
        rq.companyName = tfCompanyName.text?.trimmingCharacters(in: .whitespaces)
        rq.printQRName = tfQRName.text?.trimmingCharacters(in: .whitespaces)
        rq.serviceType = dichVu//Constants.serviceType[serviceType].id //dich vụ
        rq.address = tfAddress.text?.trimmingCharacters(in: .whitespaces)
        rq.representativeName = tfRepresentativeName.text?.trimmingCharacters(in: .whitespaces)
        rq.representativeMobile = tfDaiDienPhone.text?.trimmingCharacters(in: .whitespaces)
        rq.representativePosition = tfChucVu.text?.trimmingCharacters(in: .whitespaces)
        rq.representativePIDNumber = tfSoGTTT.text?.trimmingCharacters(in: .whitespaces)
        rq.representativePIDImageBefore = photoPIDBefore
        rq.representativePIDImageAfter = photoPIDAfter
        rq.isSignContract = isRepresentative.isSelected ? "Y" : "N"
        rq.qROption = dichVuYcCc ///dich vụ yc cung cap
        rq.paymentAccountNumber = tfBankNumber.text?.trimmingCharacters(in: .whitespaces)
        rq.paymentAccountName = tfAccountHolder.text?.trimmingCharacters(in: .whitespaces)
        rq.paymentAccountBank = String(bankSelected?.id ?? 0)
        rq.paymentAccountBranch = tfBankBranch.text?.trimmingCharacters(in: .whitespaces)
        rq.documents = "\(photoRegisterBusiness);\(photoSellArea);\(photoTaxCode);\(photoChungTuKhac)"
        rq.linkWebsite = tfLinkWebsite.text?.trimmingCharacters(in: .whitespaces)
        rq.imagesApp = photoApp
        var poscode = ""
        if !posCodeModel.isEmpty {
            poscode = "\(posCodeModel[0].PosCode)"
        }
        rq.posID = poscode + (tfPosId.text?.trimmingCharacters(in: .whitespaces) ?? "")
        let rqString = Utils.objToString(rq)
        self.showLoading()
        if isUpdateMerchant{
            ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "MERCHANT_EDIT") { code, message in
                self.hideLoading()
                if code == "00" {
                    SwiftEventBus.post("UpdateMerchantSuccess")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showToast(message: message ?? "", delay: 2)
                }
            }
        } else {
            ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "MERCHANT_ADD_NEW") { code, message in
                self.hideLoading()
                if code == "00" || code == "20" {
                    //                    SwiftEventBus.post("RegisterMerchantSuccess")
                    self.navigationController?.pushViewController(RegisterFormSuccess(), animated: true)
                } else {
                    self.showToast(message: message ?? "", delay: 2)
                }
            }
        }
    }
    private func validateBusiness() -> String {
        if (tfTaxCode.text?.trimmingCharacters(in: .whitespaces)) == "" {
            return "Bạn chưa nhập mã số thuế"
        }
        if (tfCompanyName.text?.trimmingCharacters(in: .whitespaces)) == "" {
            return "Bạn chưa nhập tên Công ty"
        }
        if tfQRName.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập tên in trên QR"
        }
        if merService == nil {
            return "Vui lòng chọn loại dịch vụ hàng hóa"
        }
        if province == nil {
            return "Vui lòng chọn Tỉnh/Thành phố"
        }
        if district == nil {
            return "Vui lòng chọn Quận/Huyện"
        }
        if ward == nil {
            return "Vui lòng chọn Xã/Phường"
        }
        if tfAddress.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Vui lòng nhập địa chỉ"
        }
        if tfRepresentativeName.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập họ tên người đại diện"
        }
        if tfDaiDienPhone.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số điện thoại người đại diện"
        }
        if tfSoGTTT.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số giấy tờ tùy thân người đại diện"
        }
        if photoPIDBefore.isEmpty {
            return "Bạn chưa chụp ảnh giấy tờ tùy thân mặt trước"
        }
        if photoPIDAfter.isEmpty {
            return "Bạn chưa chụp ảnh giấy tờ tùy thân mặt sau"
        }
        if tfAccountHolder.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập tên chủ tài khoản"
        }
        if tfBankNumber.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số tài khoản thanh toán"
        }
        if bankSelected == nil {
            return "Bạn chưa chọn ngân hàng thanh toán"
        }
        if photoRegisterBusiness.isEmpty {
            return "Bạn chưa chụp ảnh chứng nhận đăng ký kinh doanh/hộ kinh doanh"
        }
        if photoSellArea.isEmpty {
            return "Bạn chưa chụp ảnh điểm bán hàng"
        }
        if photoTaxCode.isEmpty {
            return "Bạn chưa chụp ảnh mã số thuế"
        }
        if tfLinkWebsite.text?.trimmingCharacters(in: .whitespaces) == "" && hinhThucKinhDoanh != "2" {
            return "Bạn chưa nhập Link website, link tải app"
        }
        return ""
    }
    private func validateTaxCode() -> String{
        if (tfTaxCode.text?.trimmingCharacters(in: .whitespaces)) == "" {
            return "Bạn chưa nhập mã số thuế"
        }
        if photoTaxCode.isEmpty {
            return "Bạn chưa chụp ảnh mã số thuế"
        }
        return ""
    }
    private func validateGerenal() -> String{
        if (tfCompanyName.text?.trimmingCharacters(in: .whitespaces)) == "" {
            return "Bạn chưa nhập tên Công ty"
        }
        if tfQRName.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập tên in trên QR"
        }
        if merService == nil {
            return "Vui lòng chọn loại dịch vụ hàng hóa"
        }
        if province == nil {
            return "Vui lòng chọn Tỉnh/Thành phố"
        }
        if district == nil {
            return "Vui lòng chọn Quận/Huyện"
        }
        if ward == nil {
            return "Vui lòng chọn Xã/Phường"
        }
        if tfAddress.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Vui lòng nhập địa chỉ"
        }
        if tfRepresentativeName.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập họ tên người đại diện"
        }
        if tfDaiDienPhone.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số điện thoại người đại diện"
        }
        if tfSoGTTT.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số giấy tờ tùy thân người đại diện"
        }
        if photoPIDBefore.isEmpty {
            return "Bạn chưa chụp ảnh giấy tờ tùy thân mặt trước"
        }
        if photoPIDAfter.isEmpty {
            return "Bạn chưa chụp ảnh giấy tờ tùy thân mặt sau"
        }
        if tfAccountHolder.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập tên chủ tài khoản"
        }
        if tfBankNumber.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số tài khoản thanh toán"
        }
        if bankSelected == nil {
            return "Bạn chưa chọn ngân hàng thanh toán"
        }
        if photoRegisterBusiness.isEmpty {
            return "Bạn chưa chụp ảnh chứng nhận đăng ký kinh doanh/hộ kinh doanh"
        }
        if photoSellArea.isEmpty {
            return "Bạn chưa chụp ảnh điểm bán hàng"
        }
        if tfLinkWebsite.text?.trimmingCharacters(in: .whitespaces) == "" && hinhThucKinhDoanh != "2" {
            return "Bạn chưa nhập Link website, link tải app"
        }
        return ""
    }
    private func validatePersonal() -> String{
        if tfQRName.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập tên in trên QR"
        }
        if merService == nil {
            return "Vui lòng chọn loại dịch vụ hàng hóa"
        }
        if province == nil {
            return "Vui lòng chọn Tỉnh/Thành phố"
        }
        if district == nil {
            return "Vui lòng chọn Quận/Huyện"
        }
        if ward == nil {
            return "Vui lòng chọn Xã/Phường"
        }
        if tfAddress.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Vui lòng nhập địa chỉ"
        }
        if (Constants.businessType[businessType].id == "4" || Constants.businessType[businessType].id == "5") {
            var poscode = ""
            if !posCodeModel.isEmpty {
                poscode = "\(posCodeModel[0].PosCode)"
            }
            poscode.append(tfPosId.text ?? "")
            print("postcode:",poscode)
            if poscode.isEmpty{
                return "Bạn chưa nhập PosID"
            }else if poscode.count != 12{
                return "PostID gồm 12 ký tự, Vui lòng nhập đúng định dạng"
            }
            
        }
        if tfRepresentativeName.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập họ tên người đại diện"
        }
        if tfSoGTTT.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số giấy tờ tùy thân người đại diện"
        }
        if photoPIDBefore.isEmpty {
            return "Bạn chưa chụp ảnh giấy tờ tùy thân mặt trước"
        }
        if photoPIDAfter.isEmpty {
            return "Bạn chưa chụp ảnh giấy tờ tùy thân mặt sau"
        }
        if tfAccountHolder.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập tên chủ tài khoản"
        }
        if tfBankNumber.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Bạn chưa nhập số tài khoản thanh toán"
        }
        if bankSelected == nil {
            return "Bạn chưa chọn ngân hàng thanh toán"
        }
        return ""
    }
}
