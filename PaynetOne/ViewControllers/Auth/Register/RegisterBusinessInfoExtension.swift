//
//  RegisterBusinessInfoExtension.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 08/09/2022.
//

import UIKit
import SwiftTheme


extension RegisterBusinessInfoVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("++++++++++++++++++++", textField.isFocused)
        switch textField {
        case tfSelectTypeBusiness:
            dismissKeyboard()
            selectTypeBusiness()
            return false
        case tfSelectFormBusiness:
            dismissKeyboard()
            selectFormBusiness()
            return false
        case tfService:
            dismissKeyboard()
            selectServiceType()
            return false
        case tfServiceRequire:
            dismissKeyboard()
            selectQRCodeType()
            return false
        case tfMerchandise:
            dismissKeyboard()
            chooseMerService()
            return false
        case tfCity:
            dismissKeyboard()
            chooseCity()
            return false
        case tfDistrict:
            dismissKeyboard()
            chooseDistrict()
            return false
        case tfWard:
            dismissKeyboard()
            chooseWard()
            return false
        case tfImageCanCuoc:
            dismissKeyboard()
            pickImagePIDBefore()
            return false
        case tfImagePIDSau:
            dismissKeyboard()
            pickImagePIDAfter()
            return false
        case tfBank:
            dismissKeyboard()
            selectBank()
            return false
        case tfChungTuDangKy:
            dismissKeyboard()
            pickImageChungNhanRegisterKinhDoanh()
            return false
        case tfHinhChup:
            dismissKeyboard()
            pickImageSellArea()
            return false
        case tfImageMaSoThue:
            dismissKeyboard()
            pickImageTaxCode()
            return false
        case tfChungTuKhac:
            dismissKeyboard()
            pickImgeCHungTuKhac()
            return false
        case tfImageApp:
            dismissKeyboard()
            pickImgeApp()
            return false
        default:
            return true
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 0
        if textField == tfDaiDienPhone {
            maxLength = 10
        }
        return textField.maxLength(range: range, string: string, max: maxLength)
    }
    private func selectTypeBusiness(){
        let pickerValues: [String] = Constants.businessType.map { $0.name }
        alertSelect(title: "Chọn loại hình kinh doanh", row: self.businessType, pickerValues: pickerValues) { index in
            self.tfSelectTypeBusiness.text = Constants.businessType[index].name
            self.businessType = index
            self.businessTypeSelected = Constants.businessType[index].id
        }
    }
    private func selectFormBusiness(){
//        let pickerValues: [String] = Constants.formalityType.map { $0.name }
//        alertSelect(title: "Chọn hình thức kinh doanh", row: self.formalityType, pickerValues: pickerValues) { index in
//            self.tfSelectFormBusiness.text = Constants.formalityType[index].name
//            self.formalityType = index
//        }
        let pickerData : [[String:String]] = [[
                        "value":"1",
                        "display":"Kinh doanh Online"],
                    ["value":"2",
                    "display": "Kinh doanh Offline"]]
        MultiPickerDialog().show(title: "Chọn hình thức kinh doanh",doneButtonTitle:"OK", cancelButtonTitle:"HỦY" ,options: pickerData, selected:  self.selectedFormalityType) {values -> Void in
            self.selectedFormalityType.removeAll()
            var finalText = ""
            var finalId = ""
            if values.isEmpty {
                return
            }
            for (index,value) in values.enumerated() {
                self.selectedFormalityType.append(value["value"]!)
                finalText = finalText  + value["display"]! + (index < values.count - 1 ? ", ": "")
                finalId = finalId  + value["value"]! + (index < values.count - 1 ? ";": "")
            }
            self.tfSelectFormBusiness.text = finalText
            self.hinhThucKinhDoanh = finalId
        }
    }
    private func selectServiceType(){
//        let pickerValues: [String] = Constants.serviceType.map { $0.name }
//        alertSelect(title: "Chọn dịch vụ", row: self.serviceType, pickerValues: pickerValues) { index in
//            self.tfService.text = Constants.serviceType[index].name
//            self.serviceType = index
//        }
        let pickerData : [[String:String]] = [
                    [
                        "value":"1",
                        "display":"Thanh toán QR"
                    ],
                    [
                        "value":"2",
                        "display": "Mua ngay - trả sau"
                    ]
                ]
        MultiPickerDialog().show(title: "Chọn dịch vụ",doneButtonTitle:"OK", cancelButtonTitle:"HỦY" ,options: pickerData, selected: self.selectedServiceType) { values -> Void in
            self.selectedServiceType.removeAll()
            var finalText = ""
            var finalId = ""
            if values.isEmpty {
                return
            }
            for (index,value) in values.enumerated() {
                self.selectedServiceType.append(value["value"]!)
                finalText = finalText  + value["display"]! + (index < values.count - 1 ? ", ": "")
                finalId = finalId  + value["value"]! + (index < values.count - 1 ? ";": "")
            }
            self.tfService.text = finalText
            self.dichVu = finalId
        }
    }
    private func selectQRCodeType(){
//        let pickerValues: [String] = Constants.qrCodeType.map { $0.name }
//        alertSelect(title: "Chọn dịch vụ yêu cầu cung cấp", row: self.qrCodeType, pickerValues: pickerValues) { index in
//            self.tfServiceRequire.text = Constants.qrCodeType[index].name
//            self.qrCodeType = index
//        }
        let pickerData : [[String:String]] = [
                    [
                        "value":"1",
                        "display":"QR code tĩnh"
                    ],
                    [
                        "value":"2",
                        "display":"QR code động"
                    ]
                ]
        MultiPickerDialog().show(title: "Chọn dịch vụ yêu cầu cung cấp",doneButtonTitle:"OK", cancelButtonTitle:"HỦY" ,options: pickerData, selected: self.dvYcCc) { values -> Void in
            self.dvYcCc.removeAll()
            var finalText = ""
            var finalId = ""
            if values.isEmpty {
                return
            }
            for (index,value) in values.enumerated() {
                self.dvYcCc.append(value["value"]!)
                finalText = finalText  + value["display"]! + (index < values.count - 1 ? ", ": "")
                finalId = finalId  + value["value"]! + (index < values.count - 1 ? ";": "")
            }
            self.tfServiceRequire.text = finalText
            self.dichVuYcCc = finalId
        }
    }
    private func alertSelect(title: String, row: Int, pickerValues: [String], callBack: @escaping (_ index: Int) -> Void){
        let alert = UIAlertController(style: .actionSheet, title: title)
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: row)
        alert.addPickerView(values: [pickerValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            callBack(index.row)
        }
        alert.addAction(title: "Xong", style: .cancel)
        alert.show()
    }
    //chọn hàng hóa kinh doanh
    private func chooseMerService(){
        let vc = SelectBusinessServiceVC()
        vc.data = self.merchandiseService
        vc.selectMerService = {model in
            self.tfMerchandise.text = model.name
            self.merService = model
        }
        self.present(vc, animated: true)
    }
    private func chooseCity(){
        let alert = UIAlertController(style: .actionSheet, message: "Chọn Tỉnh/Thành phố")
        alert.addAreaPicker(model: self.provinces) { area in
            if self.province?.id != area?.id {
                self.province = area
                self.tfCity.text = area?.name
                self.district = nil
                self.ward = nil
                if self.businessTypeSelected == "4" ||  self.businessTypeSelected == "5" {
                    self.getPostID(cityId: area?.id)
                }
            }
        }
        alert.addAction(title: "OK", style: .cancel)
        alert.show()
    }
    func getPostID(cityId: Int?){
        let rq = ConfigRequestModel()
        rq.id = cityId
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestList(dataRq: rqString, code: "DIC_GET_POS", returnType: DicGetPos.self) { result, err in
            if let result = result {
                self.posCodeModel = result
                let tfleftview = POMaker.makeLabel()
                tfleftview.theme_textColor = ThemeColorPicker(colors: "#FFF","#000")
                tfleftview.text = "  \(result[0].PosCode)  "
                self.tfPosId.leftView = tfleftview
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    private func chooseDistrict(){
        if let province = self.province {
            let rq = RequestAddressById()
            rq.id = province.id
            let rqString = Utils.objToString(rq)
            ApiManager.shared.requestList(dataRq: rqString, code: "DIC_GET_DISTRICT", returnType: AreaModel.self) { result, err in
                if let result = result {
                    let alert = UIAlertController(style: .actionSheet, message: "Chọn Quận/Huyện")
                    alert.addAreaPicker(model: result) { area in
                        if self.district?.id != area?.id {
                            self.district = area
                            self.ward = nil
                        }
                    }
                    alert.addAction(title: "OK", style: .cancel)
                    alert.show()
                } else {
                    self.showToast(message: err ?? "", delay: 2)
                }
            }
        } else {
            showToast(message: "Vui lòng chọn Tỉnh/Thành phố trước", delay: 2)
        }
    }
    private func chooseWard(){
        if let district = self.district {
            let rq = RequestAddressById()
            rq.id = district.id
            let rqString = Utils.objToString(rq)
            ApiManager.shared.requestList(dataRq: rqString, code: "DIC_GET_WARD", returnType: AreaModel.self) { result, err in
                if let result = result {
                    let alert = UIAlertController(style: .actionSheet, message: "Chọn Xã/Phường")
                    alert.addAreaPicker(model: result) { area in
                        self.ward = area
                    }
                    alert.addAction(title: "OK", style: .cancel)
                    alert.show()
                } else {
                    self.showToast(message: err ?? "", delay: 2)
                }
            }
        } else {
            showToast(message: "Vui lòng chọn Quận/Huyện trước", delay: 2)
        }
    }
    private func pickImagePIDBefore(){
        isTakePhotoPIDBefore = true
        chooseImage { isTake, fotoName in
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + (fotoName ?? "")
            self.imagePIDBefore.kfImage(urlStr: photoUrl)
            self.photoPIDBefore = fotoName ?? ""
            self.isTakePhotoPIDBefore = isTake
        }
    }
    private func pickImagePIDAfter(){
        isTakePhotoPIDAfter = true
        chooseImage { isTake, fotoName in
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + (fotoName ?? "")
            self.imagePIDAfter.kfImage(urlStr: photoUrl)
            self.photoPIDAfter = fotoName ?? ""
            self.isTakePhotoPIDAfter = isTake
        }
    }
    private func chooseImage(callBack: @escaping (_ isTake: Bool, _ fotoName: String?) -> Swift.Void){
        let alert = UIAlertController(style: .actionSheet)
        alert.addPhotoLibraryPicker(flow: .vertical, paging: false, selection: .single(action: { image in
            if let image = image {
                print("asset",image.mediaType)
                let image = getAssetThumbnail(asset: image)
                guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
                ApiManager.shared.uploadImage(image: imageData, name: "font") { stt, resData in
                    if stt == true {
                        let name = UploadImageResModel(JSONString: resData)
                        callBack(false, name?.fileName)
                    } else {
                        print("error upload image",resData)
                    }
                }
            }
        }))
        alert.addAction(title: "Đóng", style: .cancel)
        alert.addAction(title: "Chụp ảnh", style: .default) {_ in
            self.imagePicker?.pick()
        }
        alert.show()
    }
    private func selectBank(){
        let alert = UIAlertController(style: .actionSheet, message: "Chọn ngân hàng")
        alert.addBankPicker(model: self.bankList) { bank in
            self.tfBank.text = bank?.shortName
            self.bankSelected = bank
        }
        alert.addAction(title: "OK", style: .cancel)
        alert.show()
    }
    //ảnh chứng nhận đăng ký kinh doanh/hộ kinh doanh
    private func pickImageChungNhanRegisterKinhDoanh(){
        isTakePhotoRegisterBusiness = true
        chooseImage { isTake, fotoName in
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + (fotoName ?? "")
            self.imageChungNhanDangKy.kfImage(urlStr: photoUrl)
            self.photoRegisterBusiness = fotoName ?? ""
            self.isTakePhotoRegisterBusiness = isTake
        }
    }
    private func pickImageSellArea(){
        isTakePhotoSellArea = true
        chooseImage { isTake, fotoName in
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + (fotoName ?? "")
            self.imageAreaSell.kfImage(urlStr: photoUrl)
            self.photoSellArea = fotoName ?? ""
            self.isTakePhotoSellArea = isTake
        }
    }
    private func pickImageTaxCode(){
        isTakePhotoTaxCode = true
        chooseImage { isTake, fotoName in
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + (fotoName ?? "")
            self.imageTaxCode.kfImage(urlStr: photoUrl)
            self.photoTaxCode = fotoName ?? ""
            self.isTakePhotoTaxCode = isTake
        }
    }
    private func pickImgeCHungTuKhac(){
        isTakePhotoChungTuKhac = true
        chooseImage { isTake, fotoName in
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + (fotoName ?? "")
            self.imageChungTuKhac.kfImage(urlStr: photoUrl)
            self.photoChungTuKhac = fotoName ?? ""
            self.isTakePhotoChungTuKhac = isTake
        }
    }
    private func pickImgeApp(){
        isTakePhotoApp = true
        chooseImage { isTake, fotoName in
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + (fotoName ?? "")
            self.imageApp.kfImage(urlStr: photoUrl)
            self.photoApp = fotoName ?? ""
            self.isTakePhotoApp = isTake
        }
    }
}
extension RegisterBusinessInfoVC: ImagePickerDelegate {
    func didSelect(image: UIImage?, imageId: String) {
        if imageId != "" {
            let photoUrl = Constants.fileUploadUrl + Constants.photoIDPath + imageId
            if self.isTakePhotoPIDBefore {
                self.imagePIDBefore.kfImage(urlStr: photoUrl)
                self.photoPIDBefore = imageId
                isTakePhotoPIDBefore = false
            }
            if isTakePhotoPIDAfter {
                self.imagePIDAfter.kfImage(urlStr: photoUrl)
                self.photoPIDAfter = imageId
                isTakePhotoPIDAfter = false
            }
            if isTakePhotoRegisterBusiness {
                self.imageChungNhanDangKy.kfImage(urlStr: photoUrl)
                self.photoRegisterBusiness = imageId
                isTakePhotoRegisterBusiness = false
            }
            if isTakePhotoSellArea {
                self.imageAreaSell.kfImage(urlStr: photoUrl)
                self.photoSellArea = imageId
                isTakePhotoSellArea = false
            }
            if isTakePhotoTaxCode {
                self.imageTaxCode.kfImage(urlStr: photoUrl)
                self.photoTaxCode = imageId
                isTakePhotoTaxCode = false
            }
            if isTakePhotoChungTuKhac {
                self.imageChungTuKhac.kfImage(urlStr: photoUrl)
                self.photoChungTuKhac = imageId
                isTakePhotoChungTuKhac = false
            }
            if isTakePhotoApp {
                self.imageApp.kfImage(urlStr: photoUrl)
                self.photoApp = imageId
                isTakePhotoApp = false
            }
        } else {
            isTakePhotoPIDBefore = false
            isTakePhotoPIDAfter = false
            isTakePhotoRegisterBusiness = false
            isTakePhotoSellArea = false
            isTakePhotoTaxCode = false
            isTakePhotoChungTuKhac = false
            isTakePhotoApp = false
        }
    }
}
