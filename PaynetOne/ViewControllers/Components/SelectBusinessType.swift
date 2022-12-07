//
//  SelectBusinessType.swift
//  PaynetOne
//
//  Created by vinatti on 08/02/2022.
//

import UIKit
///Delegate truyền data từ popup về view cha
protocol SelectBusinessTypeDelegate: AnyObject {
    func setBusinessType(type index: Int)
}

///Popup chọn loại hình kinh doanh đăng ký
class SelectBusinessType: UIViewController {
    let businessTypes = ["Doanh nghiệp", "Hộ kinh doanh", "Cá nhân kinh doanh"]
    weak var delegate: SelectBusinessTypeDelegate?
    let alertView: UIView = {
        let av = UIView()
        av.layer.cornerRadius = 12
        av.layer.masksToBounds = true
        av.backgroundColor = .white
        return av
    }()
    let lbTitle = UILabel()
    let tableBussinessType: UITableView = {
        let table = UITableView()
        return table
    }()
    let btnConfirm: UIButton = {
        let cf = UIButton()
        cf.setTitle("Xác nhận", for: .normal)
        cf.backgroundColor = Colors.primaryColor
        return cf
    }()
    var businessTypeIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAlertView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        setupTableViewInAlert()
    }
        
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
//                self.alertView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
//                self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
//        }, completion: nil)
//    }
        
    func setUpAlertView() {
        alertView.addSubview(lbTitle)
        alertView.addSubview(btnConfirm)
        view.addSubview(alertView)
        alertView.viewConstraints(size: CGSize(width: view.bounds.width * 0.8, height: view.bounds.width * 0.65),centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        lbTitle.labelConstraints(top: alertView.topAnchor, marginTop: 20, centerX: alertView.centerXAnchor)
        btnConfirm.buttonConstraint(left: alertView.leftAnchor, bottom: alertView.bottomAnchor, right: alertView.rightAnchor, size: CGSize(width: 0, height: 50))
        btnConfirm.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    
    func setupTableViewInAlert(){
        view.addSubview(tableBussinessType)
        tableBussinessType.dataSource = self
        tableBussinessType.delegate = self
        tableBussinessType.backgroundColor = .white
        tableBussinessType.register(BusinessTypeCell.self, forCellReuseIdentifier: BusinessTypeCell.identifier)
        tableBussinessType.separatorStyle = .none
        tableBussinessType.tableConstraints(left: alertView.leftAnchor, right: alertView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 50 * businessTypes.count - 6), centerY: alertView.centerYAnchor)
    }
        
    @objc func dismissAlert() {
//        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
//            self.alertView.transform = CGAffineTransform.identity
//            self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
//        }) { (completed) in
//            self.dismiss(animated: true, completion: nil)
//        }
        self.dismiss(animated: true, completion: nil)
        if let delegate = delegate, let index = businessTypeIndex {
            delegate.setBusinessType(type: index)
        }
    }
}
extension SelectBusinessType: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusinessTypeCell.identifier, for: indexPath) as! BusinessTypeCell
        cell.lbTitle.text = businessTypes[indexPath.row]
        if businessTypeIndex == indexPath.row {
            cell.imgLeftIcon.image = UIImage(systemName: "circle.fill")
        } else {
            cell.imgLeftIcon.image = UIImage(systemName: "circle")
        }
        return cell
    }
}
extension SelectBusinessType: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        businessTypeIndex = indexPath.row
        tableBussinessType.reloadData()
    }
}
