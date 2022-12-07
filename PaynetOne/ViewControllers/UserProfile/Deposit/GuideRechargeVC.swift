//
//  GuideRechargeVC.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 15/11/2022.
//

import UIKit

class GuideRechargeVC: BaseUI {
    
    private var viewContent : UIView!
    private var lbTitle : UILabel!
    private var content1 : UILabel!
    private var content2 : UILabel!
    private var lbContentPayment = POMaker.makeLabel(text: "NAPHM<Mã tài khoản hạn mức>", font: .helvetica.withSize(15), color:.blueColor, alignment: .center)
    private var content3 : UILabel!
    private var btnConfirm : UIButton!
    
    var contentPayment : String = "" {
        didSet{
            lbContentPayment.text = contentPayment
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        configUI()
        configThemeView()

        // Do any additional setup after loading the view.
    }
    private func initUI(){
        viewContent = POMaker.makeView(backgroundColor: .backgroundColor)
        lbTitle = POMaker.makeLabel(text: "LƯU Ý", font: .helvetica.withSize(15), color: .black, alignment: .center)
        content1 = POMaker.makeLabel(text: "Khi nạp hạn mức bằng hình thức chuyển khoản ngân hàng:", font: .helvetica.withSize(15), color:.black, alignment: .left)
        content2 = POMaker.makeLabel(text: "+ Nội dung chuyển khoản", font: .helvetica.withSize(15), color:.black, alignment: .left)
        lbContentPayment = POMaker.makeLabel(text: "NAPHM<Mã tài khoản hạn mức>", font: .helvetica.withSize(15), color:.blueColor, alignment: .center)
        content3 = POMaker.makeLabel(text: "+ Số tiền tối thiểu mỗi lần chuyển là 200.000đ", font: .helvetica.withSize(15), color:.black, alignment: .left)
        btnConfirm = POMaker.makeButton(title: "Xác nhận", font: .helvetica.withSize(18), color: .white, textAlignment: .center, backgroundColor: .blueColor, borderWidth: 0, borderColor: .clear, cornerRadius: 0)
        
        lbContentPayment.text = contentPayment
    }
    
    private func configThemeView(){
        if isDarkMode {
            view.applyViewDarkMode()
        }
    }
    private func configUI(){
        view.addSubviews(views: viewContent,btnConfirm)
        view.bottom(toView: btnConfirm)
        
        viewContent.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        viewContent.addSubviews(views: lbTitle,content1,content2,lbContentPayment,content3)
        
        lbTitle.viewConstraints(top: viewContent.topAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor)
        
        content1.viewConstraints(top: lbTitle.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        content2.viewConstraints(top: content1.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
        lbContentPayment.viewConstraints(top: content2.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
        content3.viewConstraints(top: lbContentPayment.bottomAnchor, left: viewContent.leftAnchor, bottom: viewContent.bottomAnchor, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
        btnConfirm.viewConstraints(top: viewContent.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        btnConfirm.height(40)
        btnConfirm.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
    }
    
    @objc private func closeVC(){
        self.dismiss(animated: true)
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
