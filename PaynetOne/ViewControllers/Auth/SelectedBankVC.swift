//
//  SelectedBankVC.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 18/02/2022.
//

import UIKit

protocol SelectBankDelegate: AnyObject {
    func setBank(data: BanksModel)
}

class SelectedBankVC: UIViewController {
    
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Chọn ngân hàng"
        lb.textColor = .white
        return lb
    }()
    let imgClose: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "xmark")
        img.tintColor = .white
        img.contentMode = .scaleAspectFit
        return img
    }()
    let viewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primaryColor
        return view
    }()
    let tableBanks = UITableView()
    var data = [BanksModel]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredBank: [BanksModel] = []
    var delegate: SelectBankDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeader()
        setupSearchController()
        setupTable()
    }
    
    func setupHeader() {
        viewHeader.addSubview(lbTitle)
        viewHeader.addSubview(imgClose)
        view.addSubview(viewHeader)
        lbTitle.labelConstraints(top: viewHeader.topAnchor, bottom: viewHeader.bottomAnchor, centerX: view.centerXAnchor)
        viewHeader.viewConstraints(top: view.topAnchor, left: view.leftAnchor, size: CGSize(width: view.frame.width, height: 50))
        
        
        imgClose.viewConstraints(top: viewHeader.topAnchor, left: viewHeader.leftAnchor, bottom: viewHeader.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClose))
        imgClose.isUserInteractionEnabled = true
        imgClose.addGestureRecognizer(tap)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Tìm kiếm"
        definesPresentationContext = true
        tableBanks.tableHeaderView = searchController.searchBar
    }
    
    @objc func onClose(){
        self.dismiss(animated: true)
    }
    
    func setupTable(){
        tableBanks.dataSource = self
        tableBanks.delegate = self
        tableBanks.register(SelectBankTVC.self, forCellReuseIdentifier: SelectBankTVC.identifier)
        view.addSubview(tableBanks)
        tableBanks.tableConstraints(top: viewHeader.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBank = data.filter({ (bank: BanksModel) -> Bool in
            return bank.name.lowercased().contains(searchText.lowercased()) || bank.shortName.lowercased().contains(searchText.lowercased())
        })
        tableBanks.reloadData()
    }
}
extension SelectedBankVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.searchBar.text != "" {
            return filteredBank.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectBankTVC.identifier, for: indexPath) as! SelectBankTVC
        let bank: BanksModel
        if searchController.searchBar.text != "" {
            bank = filteredBank[indexPath.row]
        } else {
            bank = data[indexPath.row]
        }
        cell.lbShortName.text = bank.shortName
        cell.lbName.text = bank.name
        return cell
    }
}
extension SelectedBankVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank: BanksModel
        if searchController.searchBar.text != "" {
            bank = filteredBank[indexPath.row]
        } else {
            bank = data[indexPath.row]
        }
        if let delegate = delegate {
            delegate.setBank(data: bank)
        }
        self.dismiss(animated: true)
    }
}
extension SelectedBankVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
