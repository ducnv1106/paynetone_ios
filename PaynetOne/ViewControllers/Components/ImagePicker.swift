//
//  ImagePicker.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 18/02/2022.
//

import UIKit

protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?, imageId: String)
}

class ImagePicker: NSObject {
    
    let pickerController = UIImagePickerController()
    var presentController = UIViewController()
    weak var delegate: ImagePickerDelegate?
    
    init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        super.init()
        self.presentController = presentationController
        self.delegate = delegate
        
        pickerController.delegate = self
        pickerController.sourceType = .camera
    }
    
    public func pick(){
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
        self.presentController.present(pickerController, animated: true)
    }
    
    private func pickerImage(_ controller: UIImagePickerController ,image: UIImage?, imageId: String) {
        controller.dismiss(animated: true, completion: nil)
        delegate?.didSelect(image: image, imageId: imageId)
    }
}
extension ImagePicker: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("-------------------->>>>>>>")
        pickerImage(picker, image: nil, imageId: "")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return pickerImage(picker, image: nil, imageId: "")
        }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        ApiManager.shared.uploadImage(image: imageData, name: "font") { stt, resData in
            if stt == true {
                let name = UploadImageResModel(JSONString: resData)
                self.pickerImage(picker, image: image, imageId: name?.fileName ?? "")
            } else {
                print("error upload image",resData)
            }
        }
        
    }
}
extension ImagePicker: UINavigationControllerDelegate {
    
}
