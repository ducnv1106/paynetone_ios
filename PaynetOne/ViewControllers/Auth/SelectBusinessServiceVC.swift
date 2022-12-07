//
//  SelectBusinessServiceVC.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 16/02/2022.
//

import UIKit

protocol SelectBusinessDelegate: AnyObject {
    func setBusiness(data: BusinessServiceModel)
}

class SelectBusinessServiceVC: UIViewController {

    var data = [BusinessServiceModel]()
    var delegate: SelectBusinessDelegate?
    var filterdBusiness: [BusinessServiceModel] = []
    var selectMerService: ((_ model: BusinessServiceModel) -> ())?
    
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Chọn loại dịch vụ hàng hóa"
        lb.textColor = .white
        return lb
    }()
    let viewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primaryColor
        return view
    }()
    let imgClose: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "xmark")
        img.tintColor = .white
        img.contentMode = .scaleAspectFit
        return img
    }()
    let tableBusiness = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeader()
        setupSearchController()
        setupTable()
        hideKeyboardWhenTappedOutside()
        
        // Add a tap gesture to our view
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        self.view.addGestureRecognizer(gesture)
        
    }
    
    // Called when the tap gesture fires
    @objc func didTap(gesture: UITapGestureRecognizer) {
        
        // We get rid of our keyboard on screen
        searchController.resignFirstResponder()
        
        // Find the location of the touch relative to the tableView
        let touch = gesture.location(in: self.tableBusiness)
        
        // Convert that touch point to an index path
        if let indexPath = tableBusiness.indexPathForRow(at: touch) {
            
            // Here I am just calling the delegate method directly which you shouldn't do.
            // You should just do whatever you want to do with the indexPath here.
            //               tableView(tableBusiness, didSelectRowAtIndexPath: indexPath)
            tableView(tableBusiness, didSelectRowAt: indexPath)
            
        }
        
    }
    
    func setupTable(){
        tableBusiness.dataSource = self
        tableBusiness.delegate = self
        tableBusiness.register(SelectBusinessTVC.self, forCellReuseIdentifier: SelectBusinessTVC.identifier)
        view.addSubview(tableBusiness)
        tableBusiness.tableConstraints(top: viewHeader.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Tìm kiếm"
        searchController.searchBar.setValue("Hủy", forKey: "cancelButtonText")
        definesPresentationContext = true
        tableBusiness.tableHeaderView = searchController.searchBar
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
    
    @objc func onClose(){
        self.dismiss(animated: true)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filterdBusiness = data.filter({ (business: BusinessServiceModel) -> Bool in
            return (business.name?.lowercased().contains(searchText.lowercased()))!
        })
        tableBusiness.reloadData()
    }
}
extension SelectBusinessServiceVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.searchBar.text != "" {
            return filterdBusiness.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectBusinessTVC.identifier, for: indexPath) as! SelectBusinessTVC
        let business: BusinessServiceModel
        if searchController.searchBar.text != "" {
            business = filterdBusiness[indexPath.row]
        } else {
            business = data[indexPath.row]
        }
        cell.lbTitle.text = business.name
        return cell
    }
}
extension SelectBusinessServiceVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let business: BusinessServiceModel
        if searchController.searchBar.text != "" {
            business = filterdBusiness[indexPath.row]
        } else {
            business = data[indexPath.row]
        }
        if let selectMerServce = self.selectMerService {
            selectMerServce(business)
        }
        self.dismiss(animated: true)
    }
}
extension SelectBusinessServiceVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
