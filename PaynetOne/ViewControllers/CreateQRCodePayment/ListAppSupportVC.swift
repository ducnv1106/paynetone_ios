//
//  ListAppSupportVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 16/08/2022.
//

import UIKit

class ListAppSupportVC: BaseViewController {
    private let titleSupport = POMaker.makeLabel(font: .helvetica.setBold(),alignment: .center)
    private let collectionView = POMaker.makeCollectionView((screenWidth - 40) > 340 ? 340 : screenWidth - 40 , itemSpacing: 1, itemsInLine: 3, itemHeight: 80)
    
    var model = ProviderLocal() {
        didSet{
            var appName = ""
            if model.paymentType == 6 {
                appName = model.name
            } else if model.paymentType == 8 {
                appName = "VietQR"
            }
            titleSupport.text = "Các ứng dụng hỗ trợ \(appName)"
        }
    }

    let vnpaySupportList = ["vietcombank", "agribank", "bidv", "viettinbank", "techcombank", "abbank", "acb", "bac_abank", "vietcapitalbank", "bao_vietbank", "coop_bank", "dong_abank", "eximbank", "GPbank", "hdbank", "indovina_bank", "kienlongbank", "lienvietpostbank", "mbbank", "msb", "ncb", "namabank", "ocb", "oceanbank", "pgbank", "publicbank", "pvcombank", "scb", "shb", "vpbank", "vietabank", "vietbank"]
//    let vietQRSupportList = ["abbank","acb","bac_abank","bidv", "bao_vietbank", "cakebypvbank", "cbbank", "cimbbank", "coop_bank", "dbs", "dong_abank","eximbank","GPbank","hdbank", "hong_leong_bank", "hsbc", "ibk", "viettinbank","indovina_bank", "kbbank", "kasikorn", "kienlongbank","lienvietpostbank","mbbank","msb","namabank","ncb", "nongHyupBank", "ocb","oceanbank","publicbank","pgbank", "pvcombank","scb", "standardchartered", "seabank", "saigonbank", "shb","shinhanbank", "sacombank", "techcombank", "tpbank", "uob", "ubankbypvbank", "vietabank","agribank","vietcombank", "vietcapitalbank","vib", "vietbank","vpbank","vrb", "wooribank"]
    let vietQRSupportList = ["abbank","acb","bac_abank","bidv", "bao_vietbank", "cakebypvbank", "cbbank", "cimbbank", "coop_bank", "dbs", "dong_abank","eximbank","GPbank","hdbank", "hong_leong_bank", "hsbc", "ibk", "viettinbank","indovina_bank", "kbbank", "kasikorn", "kienlongbank","lienvietpostbank","mbbank","msb","namabank","ncb", "nongHyupBank", "ocb","oceanbank","publicbank", "pvcombank","scb", "standardchartered", "seabank", "saigonbank", "shb","shinhanbank", "sacombank", "techcombank", "tpbank", "uob", "ubankbypvbank", "vietabank","agribank","vietcombank", "vietcapitalbank","vib", "vietbank","vpbank","vrb", "wooribank","pgbank"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleSupport)
        titleSupport.viewConstraints(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        view.addSubview(collectionView)
        collectionView.viewConstraints(top: titleSupport.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: screenHeight*0.7))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AppSupportPayCollectionViewCell.self, forCellWithReuseIdentifier: "AppSupportPayCollectionViewCell")
        
        configBackgorundColor()
    }
    
    override func configBackgorundColor() {
        if isDarkMode {
            self.view.applyViewDarkMode()
        }else{
            self.view.backgroundColor = .backgroundColor
        }
    }

}
extension ListAppSupportVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = model.paymentType == 6 ? vnpaySupportList : vietQRSupportList
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppSupportPayCollectionViewCell", for: indexPath) as! AppSupportPayCollectionViewCell
        let data = model.paymentType == 6 ? vnpaySupportList : vietQRSupportList
        cell.imageBank.image = UIImage(named: data[indexPath.row])
        return cell
    }
}
class AppSupportPayCollectionViewCell: UICollectionViewCell {
    let imageBank = POMaker.makeImageView(contentMode: .scaleAspectFit)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageBank)
        imageBank.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        
        contentView.backgroundColor = .backgroundColor
        contentView.buildShadow(radius: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
