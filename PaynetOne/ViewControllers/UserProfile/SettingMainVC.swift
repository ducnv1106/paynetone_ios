//
//  SettingMainVC.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 10/11/2022.
//

import UIKit
import SwiftUI
//import KDDragAndDropCollectionViews
import SwiftReorder
import SwiftTheme


class SettingMainVC: BaseUI {

    private var firtsTabMain = StoringService.shared.getData("KEY_TAB_MAIN").isEmpty ? "1" : StoringService.shared.getData("KEY_TAB_MAIN")
    private var tabMains: [TabMainModel] = []
    private var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CÀI ĐẶT TRANG CHỦ"
        initUI()
        setupTableView()
        tabMains.removeAll()
        initData()
        tableView.reloadData()
       
        if isDarkMode{
            tableView.backgroundColor = .black
        }else{
            tableView.backgroundColor = .white
        }

        // Do any additional setup after loading the view.
    }
    override func configBackgorundColor() {
        super.configBackgorundColor()
        if isDarkMode {
            tableView.backgroundColor = .black
        }
    }
    
    private func initUI(){
        tableView = POMaker.makeTableView()
    }

    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reorder.delegate = self

        tableView.backgroundColor = .white
        tableView.register(SettingMailTableCell.self, forCellReuseIdentifier: "SettingMailTableCell")
        tableView.tableFooterView = UIView()

        view.addSubview(tableView)
        tableView.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        
        tableView.reloadData()

    }
    override func leftBarButtonTouchUpInside() {
        if firtsTabMain != "\(tabMains[0].type)"{
            let modal = ConfirmModalView()
            modal.message = "Bạn có muốn thay đổi không?"
            self.popupWithView(vc: modal,cancelBtnTitle: "Huỷ bỏ", cancelAction:{
                self.navigationController?.popViewController(animated: true)
            }, okBtnTitle: "Đồng ý", okAction: {
                StoringService.shared.saveData(user: "\(self.tabMains[0].type)", key: "KEY_TAB_MAIN")
                SceneDelegate.shared.rootViewController.switchToMain()
            })

        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
//        let modal = ConfirmModalView()
//        modal.message = "Thay đổi mật khẩu thành công!"
//        self.popupWithView(vc: modal,cancelBtnTitle: "Huỷ bỏ", cancelAction:{
//            self.navigationController?.popViewController(animated: true)
//        }, okBtnTitle: "Đồng ý", okAction: {
//
//        })
    }
    
    private func initData(){
        let dataTab = StoringService.shared.getData("KEY_TAB_MAIN")
        if dataTab.isEmpty || dataTab == "1"{
            tabMains.insert([TabMainModel(name: "Thanh toán QR", type: 1),
                             TabMainModel(name: "Dịch vụ gia tăng", type: 2)], at: 0)
        }else{
            tabMains.insert([TabMainModel(name: "Dịch vụ gia tăng", type: 2),
                             TabMainModel(name: "Thanh toán QR", type: 1)], at: 0)
        }
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
extension SettingMainVC: UITableViewDataSource, UITableViewDelegate,TableViewReorderDelegate {
    func tableView(_ tableView: UITableView, reorderRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.tabMains.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        self.tableView.reloadData()
//        SceneDelegate.shared.rootViewController.switchToMain()
    
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabMains.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingMailTableCell", for: indexPath) as! SettingMailTableCell
        if tabMains.count > 0 {
            cell.itemCell = tabMains[indexPath.row]
            cell.position = indexPath.row
        }
        cell.selectionStyle = .none
        return cell

    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

class SettingMailTableCell: UITableViewCell {
    private let viewContent = POMaker.makeView()

    private var imageMenu = POMaker.makeImage(image: "ic_menu")
    private let tvNamePage = POMaker.makeLabel(text: "Thanh toán Qr",font:.helvetica.withSize(15))
    private let numberPage = POMaker.makeLabel(text: "Trang 1", font:.helvetica.withSize(12), color: .white, alignment: .center)
    
    
    var itemCell: TabMainModel? {
        didSet {
            if let itemCell = itemCell {
                tvNamePage.text = itemCell.name
                
            }
        }
    }
    var position: Int = 0 {
        didSet{
            numberPage.text = "Trang \(position+1)"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        
        if StoringService.shared.isDarkMode(){
            viewContent.theme_backgroundColor = ThemeColorPicker(colors: "#000","#FFF")
            tvNamePage.theme_textColor = ThemeColorPicker(colors:"#FFF")
   
            imageMenu = POMaker.makeImage(image: "ic_menu",tintColor: .white)

        }

        contentView.addSubview(viewContent)
        viewContent.addSubviews(views: tvNamePage,numberPage,imageMenu)

        viewContent.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10))

        imageMenu.viewConstraints(top: viewContent.topAnchor, left: nil, bottom: viewContent.bottomAnchor, right: viewContent.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10),size: CGSize(width: 18, height: 18) )

        tvNamePage.viewConstraints(top: viewContent.topAnchor, left: viewContent.leftAnchor, bottom: viewContent.bottomAnchor, right: nil)

        numberPage.viewConstraints(top: viewContent.topAnchor, left: tvNamePage.rightAnchor, bottom: nil, right: nil,padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        numberPage.height(20)
        numberPage.width(70)
        numberPage.backgroundColor = .blueColor
        numberPage.clipsToBounds = true
        numberPage.layer.cornerRadius = 5
        
        if isDarkMode {
            contentView.backgroundColor = .black
            viewContent.backgroundColor = .black
        }else{
            contentView.backgroundColor = .white
        }
    

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}

struct TabMainModel {
    var name = ""
    var type = 0
}

class ConfirmModalView: BaseUI {
    private var imgSuccess : UIImageView!
    private var titleSuccess = POMaker.makeLabel(text: "Thông báo", font: .helvetica.withSize(18), color: .white, alignment: .center)
    private var lbMessage = POMaker.makeLabel(text: "Bạn có muốn thay đổi cài đặt!", font: .helvetica.withSize(15), alignment: .center)
    var message = "" {
        didSet {
            lbMessage.text = message
        }
    }
    var messgeTitle = ""{
        didSet{
            titleSuccess.text = messgeTitle
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        configUI()
        configBackgorundColor()
    }
    
    private func configUI(){
        view.addSubviews(views: titleSuccess, lbMessage)
        titleSuccess.top(toView: view, space: 0)
        titleSuccess.horizontal(toView: view)
        titleSuccess.height(50)
        
        lbMessage.top(toAnchor: titleSuccess.bottomAnchor, space: 16)
        lbMessage.horizontal(toView: view, space: 14)
        lbMessage.bottom(toView: view, space: 20)
    }
    private func initUI(){
        imgSuccess = POMaker.makeImage(image: "checked_success")
        titleSuccess.backgroundColor = .blueColor
    }
    
    override func configBackgorundColor() {
        if isDarkMode{
            view.applyViewDarkMode()
        }else{
            view.backgroundColor = .backgroundColor
        }
    }
}


