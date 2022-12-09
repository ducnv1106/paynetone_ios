//
//  AreaPicker.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 09/09/2022.
//

import UIKit

extension UIAlertController {
    func addAreaPicker(model: [AreaModel], selection: @escaping AreaPickerViewController.Selection) {
        let vc = AreaPickerViewController(model: model, selection: { new in
            selection(new)
            self.dismiss(animated: true)
        })
        set(vc: vc)
    }
}

final class AreaPickerViewController: UIViewController {
    struct UI {
        static let rowHeight = CGFloat(50)
        static let separatorColor: UIColor = UIColor.lightGray.withAlphaComponent(0.4)
    }
    
    // MARK: Properties
    
    public typealias Selection = (AreaModel?) -> Swift.Void
    
    fileprivate var selection: Selection?
    fileprivate var model: [AreaModel]
    fileprivate var orderedInfo = [String: [LocaleInfo]]()
    fileprivate var sortedInfoKeys = [String]()
    fileprivate var filteredInfo: [AreaModel] = []
    fileprivate var selectedInfo: AreaModel?
    
    //fileprivate var searchBarIsActive: Bool = false
    
    fileprivate lazy var searchView: UIView = UIView()
    
    fileprivate lazy var searchController: UISearchController = { [unowned self] in
        $0.searchResultsUpdater = self
        $0.searchBar.delegate = self
        $0.dimsBackgroundDuringPresentation = false
        /// true if search bar in tableView header
        $0.hidesNavigationBarDuringPresentation = true
        $0.searchBar.searchBarStyle = .minimal
        if isDarkMode{
            $0.searchBar.textField?.textColor = .white
        }else{
            $0.searchBar.textField?.textColor = .black
        }
       
        $0.searchBar.textField?.clearButtonMode = .whileEditing
        return $0
    }(UISearchController(searchResultsController: nil))
    
    fileprivate lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UI.rowHeight
        $0.separatorColor = UI.separatorColor
        $0.bounces = true
        $0.backgroundColor = nil
        $0.tableFooterView = UIView()
        $0.sectionIndexBackgroundColor = .clear
        $0.sectionIndexTrackingBackgroundColor = .clear
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    fileprivate lazy var indicatorView: UIActivityIndicatorView = {
        $0.color = .lightGray
        return $0
    }(UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large))
    
    // MARK: Initialize
    
    required init(model: [AreaModel], selection: @escaping Selection) {
        self.model = model
        self.selection = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // http://stackoverflow.com/questions/32675001/uisearchcontroller-warning-attempting-to-load-the-view-of-a-view-controller/
        let _ = searchController.view
        Log("has deinitialized")
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(indicatorView)
        
        searchController.searchBar.setValue("Huỷ", forKey: "cancelButtonText")
        searchController.searchBar.placeholder = "Tìm kiếm"
        searchView.addSubview(searchController.searchBar)
        tableView.tableHeaderView = searchView
        
        //extendedLayoutIncludesOpaqueBars = true
        //edgesForExtendedLayout = .bottom
        definesPresentationContext = true
        
        tableView.register(AreaTableViewCell.self, forCellReuseIdentifier: AreaTableViewCell.identifier)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.tableHeaderView?.height = 57
        searchController.searchBar.sizeToFit()
        searchController.searchBar.frame.size.width = searchView.frame.size.width
        searchController.searchBar.frame.size.height = searchView.frame.size.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        indicatorView.center = view.center
        preferredContentSize.height = tableView.contentSize.height
    }
    
    func info(at indexPath: IndexPath) -> AreaModel? {
        if searchController.isActive {
            return filteredInfo[indexPath.row]
        } else {
            return model[indexPath.row]
        }
    }
    
    func indexPathOfSelectedInfo() -> IndexPath? {
        guard let selectedInfo = selectedInfo else { return nil }
        if searchController.isActive {
            for row in 0 ..< filteredInfo.count {
                if filteredInfo[row].name == selectedInfo.name {
                    return IndexPath(row: row, section: 0)
                }
            }
        }
        return nil
    }
}

// MARK: - UISearchResultsUpdating

extension AreaPickerViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchController.isActive {
            filteredInfo = []
            if searchText.trimmingCharacters(in: .whitespaces).count > 0 {
                filteredInfo.append(contentsOf: model.filter { $0.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil })
            } else {
                model.forEach { value in
                    filteredInfo.append(value)
                }
            }
        }
        tableView.reloadData()
        
        guard let selectedIndexPath = indexPathOfSelectedInfo() else { return }
        Log("selectedIndexPath = \(selectedIndexPath)")
        tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
    }
}

// MARK: - UISearchBarDelegate

extension AreaPickerViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}

// MARK: - TableViewDelegate

extension AreaPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let info = info(at: indexPath) else { return }
        selectedInfo = info
        selection?(selectedInfo)
    }
}

// MARK: - TableViewDataSource

extension AreaPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredInfo.count
        } else {
            return model.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let info = info(at: indexPath) else { return UITableViewCell() }
        let cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: AreaTableViewCell.identifier) as! AreaTableViewCell
        cell.textLabel?.text = info.name
        return cell
    }
}

