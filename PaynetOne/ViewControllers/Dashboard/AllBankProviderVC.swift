//
//  AllBankProviderVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 29/08/2022.
//

import UIKit
import SwiftTheme

class AllBankProviderVC: BaseUI {
    var bankProvider = [ProviderLocal]()
    var providerFilter = [ProviderLocal]()
    var isFilter = false
    
    private var tfSearch = POMaker.makeTextField(placeholder: "Nhập tên ngân hàng", borderWidth: 0.5, borderColor: .borderColor, cornerRadius: 10)
    private var collectionView = POMaker.makeCollectionView(screenWidth - 50, itemSpacing: 4, itemsInLine: 4, itemHeight: (screenWidth - 70)/4+30)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tất cả ngân hàng"
        self.initUI()
        setupSearch()
        setupCollectionView()
        configThemeView()
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.view.subviews.map({ $0.removeFromSuperview() })
            self.initUI()
            self.setupSearch()
            self.setupCollectionView()
            self.configThemeView()
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    private func initUI(){
        tfSearch = POMaker.makeTextField(placeholder: "Nhập tên ngân hàng", borderWidth: 0.5, borderColor: .borderColor, cornerRadius: 10)
        
        collectionView = POMaker.makeCollectionView(screenWidth - 50, itemSpacing: 4, itemsInLine: 4, itemHeight: (screenWidth - 70)/4+30)
    }
    
    private func configThemeView(){
        if StoringService.shared.isDarkMode(){
            tfSearch.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    
    private func setupSearch(){
        view.addSubview(tfSearch)
        tfSearch.safeTop(toView: view, space: 16)
        tfSearch.horizontal(toView: view, space: 14)
        tfSearch.size(CGSize(width: 0, height: 44))
        let leftView = POMaker.makeView(backgroundColor: .clear)
        let iconSearch = POMaker.makeImageView(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
        iconSearch.tintColor = .gray.withAlphaComponent(0.7)
        leftView.addSubview(iconSearch)
        iconSearch.vertical(toView: leftView, space: 5)
        iconSearch.horizontal(toView: leftView, space: 5)
        leftView.size(CGSize(width: 44, height: 36))
        tfSearch.leftView = leftView
        tfSearch.addTarget(self, action: #selector(search_editingChange), for: .editingChanged)
    }
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QRPaymentCollectionViewCell.self, forCellWithReuseIdentifier: "QRPaymentCollectionViewCell")
        collectionView.top(toAnchor: tfSearch.bottomAnchor, space: 14)
        collectionView.horizontal(toView: view, space: 14)
        collectionView.bottom(toView: view,space: 20)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    @objc private func search_editingChange(){
        if let searchText = tfSearch.text?.trimmingCharacters(in: .whitespaces) {
            if !searchText.isEmpty {
                self.isFilter = true
                providerFilter = self.bankProvider.filter{$0.name.range(of: searchText, options: .caseInsensitive) != nil}
            } else {
                self.isFilter = false
            }
        }
        collectionView.reloadData()
    }
}
extension AllBankProviderVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = isFilter ? providerFilter : bankProvider
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QRPaymentCollectionViewCell", for: indexPath) as! QRPaymentCollectionViewCell
        let model = isFilter ? providerFilter : bankProvider
        cell.model = model[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = isFilter ? providerFilter[indexPath.row] : bankProvider[indexPath.row]
        let vc = InputInfoCreateQRCodeVC()
        vc.model = model
        if model.isActive == "N" {
            self.showPopupDevelop()
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
