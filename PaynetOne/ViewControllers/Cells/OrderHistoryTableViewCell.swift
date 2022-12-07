//
//  OrderHistoryTableViewCell.swift
//  PaynetOne
//
//  Created by vinatti on 11/01/2022.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell{
    static let identifier = "HistoryOrderTableViewCell"

    let lbOrderId = POMaker.makeLabel(font: UIFont.systemFont(ofSize: 16))
    let bankImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo_vtmoney")?.resized(to: CGSize(width: 50, height: 50))
        img.contentMode = .scaleAspectFill
        return img
    }()
//    let lbNumberPhone: UILabel = {
//        let label = UILabel()
//        label.text = "0987654321"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .gray
//        return label
//    }()
//    let lbDescription = POMaker.makeLabel(text: "description", font: UIFont.systemFont(ofSize: 14), color: .gray, line: 2)
    let lbAmount = POMaker.makeLabel(font: UIFont.systemFont(ofSize: 16))
    let lbDateOrder = POMaker.makeLabel(font: UIFont.systemFont(ofSize: 14), color: .gray)
    let statusOrderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = false
        return view
    }()
    let statusOrderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
//    var statusOrderLabel: String = "" {
//        didSet {
//            statusOrder.buildStatus(string: statusOrderLabel)
//        }
//    }
//    let teststatus = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupView()
        setupConstraint()
    }
    
    func setupView(){
        contentView.addSubview(bankImageView)
        contentView.addSubview(lbOrderId)
        contentView.addSubview(lbAmount)
//        contentView.addSubview(lbNumberPhone)
        contentView.addSubview(lbDateOrder)
//        contentView.addSubview(lbDescription)
        statusOrderView.addSubview(statusOrderLabel)
        contentView.addSubview(statusOrderView)
        
//        contentView.addSubview(teststatus)
    }

    func setupConstraint(){
        bankImageView.viewConstraints(left: contentView.leftAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 50, height: 50), centerY: contentView.centerYAnchor)
        
        lbOrderId.labelConstraints(top: contentView.topAnchor, marginTop: 10, left: bankImageView.rightAnchor, marginLeft: 10)
        lbAmount.labelConstraints(top: contentView.topAnchor, marginTop: 10, right: contentView.rightAnchor, marginRight: -10)
        lbDateOrder.labelConstraints(top: lbOrderId.bottomAnchor, marginTop: 10, left: bankImageView.rightAnchor, marginLeft: 10)
//        lbDateOrder.labelConstraints(top: lbOrderId.bottomAnchor, marginTop: 10, right: contentView.rightAnchor, marginRight: -10)
//        lbDescription.labelConstraints(top: lbOrderId.bottomAnchor, marginTop: 10, left: bankImageView.rightAnchor, marginLeft: 10, bottom: contentView.bottomAnchor, marginBottom: -10, right: statusOrderView.leftAnchor)
//        lbDescription.setContentCompressionResistancePriority(.init(rawValue: 749), for: .horizontal)
        
        statusOrderLabel.labelConstraints(top: statusOrderView.topAnchor, marginTop: 4, left: statusOrderView.leftAnchor, marginLeft: 5, bottom: statusOrderView.bottomAnchor, marginBottom: -4, right: statusOrderView.rightAnchor, marginRight: -5)
        statusOrderView.viewConstraints(top: lbOrderId.bottomAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10))
        
//        teststatus.labelConstraints(top: contentView.topAnchor, left: contentView.leftAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
