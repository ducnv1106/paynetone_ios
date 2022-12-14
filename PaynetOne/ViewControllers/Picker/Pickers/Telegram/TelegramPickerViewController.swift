import Foundation
import UIKit
import Photos

public typealias TelegramSelection = (TelegramSelectionType) -> ()

public enum TelegramSelectionType {
    case photo(PHAsset)
}

extension UIAlertController {
    
    /// Add Telegram Picker
    ///
    /// - Parameters:
    ///   - selection: type and action for selection of asset/assets
    
    func addTelegramPicker(selection: @escaping TelegramSelection) {
        let vc = TelegramPickerViewController(selection: selection)
        set(vc: vc)
    }
}

final class TelegramPickerViewController: UIViewController {
    var buttons: [ButtonType] {
        return selectedAssets == nil
            ? [.photoOrVideo]
            : [.sendPhotos]
    }
    enum ButtonType {
        case photoOrVideo
        case sendPhotos
    }
    
    // MARK: UI
    
    struct UI {
        static let rowHeight: CGFloat = 58
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let minimumInteritemSpacing: CGFloat = 6
        static let minimumLineSpacing: CGFloat = 6
        static let maxHeight: CGFloat = UIScreen.main.bounds.width / 2
        static let multiplier: CGFloat = 2
        static let animationDuration: TimeInterval = 0.3
    }
    
    func title(for button: ButtonType) -> String {
        switch button {
        case .photoOrVideo: return "Chọn ảnh từ thư viện"
        case .sendPhotos: return "Đồng ý"
        }
    }
    
    func font(for button: ButtonType) -> UIFont {
        switch button {
        case .sendPhotos: return UIFont.boldSystemFont(ofSize: 20)
        default: return UIFont.systemFont(ofSize: 20) }
    }
    
    var preferredHeight: CGFloat {
        return UI.maxHeight / (selectedAssets == nil ? UI.multiplier : 1) + UI.insets.top + UI.insets.bottom
    }
    
    func sizeFor(asset: PHAsset) -> CGSize {
        let height: CGFloat = UI.maxHeight
        let width: CGFloat = CGFloat(Double(height) * Double(asset.pixelWidth) / Double(asset.pixelHeight))
        return CGSize(width: width, height: height)
    }
    
    func sizeForItem(asset: PHAsset) -> CGSize {
        let size: CGSize = sizeFor(asset: asset)
        if selectedAssets == nil {
            let value: CGFloat = size.height / UI.multiplier
            return CGSize(width: value, height: value)
        } else {
            return size
        }
    }
    // MARK: Properties

    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.allowsMultipleSelection = true
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.decelerationRate = UIScrollView.DecelerationRate.fast
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = UI.insets
        $0.backgroundColor = .clear
        $0.maskToBounds = false
        $0.clipsToBounds = false
        $0.register(ItemWithPhoto.self, forCellWithReuseIdentifier: String(describing: ItemWithPhoto.self))
        
        return $0
        }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    fileprivate lazy var layout: PhotoLayout = { [unowned self] in
        $0.delegate = self
        $0.lineSpacing = UI.minimumLineSpacing
        return $0
        }(PhotoLayout())
    
    fileprivate lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UI.rowHeight
        $0.separatorColor = UIColor.lightGray.withAlphaComponent(0.4)
        $0.separatorInset = .zero
        $0.backgroundColor = nil
        $0.bounces = false
        $0.tableHeaderView = collectionView
        $0.tableFooterView = UIView()
        $0.register(LikeButtonCell.self, forCellReuseIdentifier: LikeButtonCell.identifier)
        
        return $0
        }(UITableView(frame: .zero, style: .plain))
    
    lazy var assets = [PHAsset]()
    var selectedAssets: PHAsset?
    
    var selection: TelegramSelection?
    
    // MARK: Initialize
    
    required init(selection: @escaping TelegramSelection) {
        self.selection = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log("has deinitialized")
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            preferredContentSize.width = UIScreen.main.bounds.width * 0.5
        }
        
        updatePhotos()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    func layoutSubviews() {
        tableView.tableHeaderView?.height = preferredHeight
        preferredContentSize.height = tableView.contentSize.height
    }
    
    func updatePhotos() {
        checkStatus { [unowned self] assets in
            
            self.assets.removeAll()
            self.assets.append(contentsOf: assets)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
        }
    }
    
    func checkStatus(completionHandler: @escaping ([PHAsset]) -> ()) {
        Log("status = \(PHPhotoLibrary.authorizationStatus())")
        switch PHPhotoLibrary.authorizationStatus() {
            
        case .notDetermined:
            /// This case means the user is prompted for the first time for allowing contacts
            Assets.requestAccess { [unowned self] status in
                self.checkStatus(completionHandler: completionHandler)
            }
            
        case .authorized:
            /// Authorization granted by user for this app.
            DispatchQueue.main.async {
                self.fetchPhotos(completionHandler: completionHandler)
            }
            
        case .denied, .restricted:
            /// User has denied the current app to access the contacts.
            let productName = Bundle.main.infoDictionary!["CFBundleName"]!
            let alert = UIAlertController(style: .alert, title: "Permission denied", message: "\(productName) does not have access to contacts. Please, allow the application to access to your photo library.")
            alert.addAction(title: "Settings", style: .destructive) { action in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
            alert.addAction(title: "OK", style: .cancel) { [unowned self] action in
                self.alertController?.dismiss(animated: true)
            }
            alert.show()
        case .limited:
            break
        @unknown default:
            break
        }
    }
    
    func fetchPhotos(completionHandler: @escaping ([PHAsset]) -> ()) {
        Assets.fetch { [unowned self] result in
            switch result {
                
            case .success(let assets):
                completionHandler(assets)
                
            case .error(let error):
                Log("------ error")
                let alert = UIAlertController(style: .alert, title: "Error", message: error.localizedDescription)
                alert.addAction(title: "OK") { [unowned self] action in
                    self.alertController?.dismiss(animated: true)
                }
                alert.show()
            }
        }
    }
    
    func action(withAsset asset: PHAsset, at indexPath: IndexPath) {
//        let previousCount = selectedAssets.count
        
//        selectedAssets.contains(asset)
//            ? selectedAssets.remove(asset)
//            : selectedAssets.append(asset)
        selectedAssets = asset
        selection?(TelegramSelectionType.photo(asset))
        
//        let currentCount = selectedAssets.count

        if selectedAssets != nil {
            UIView.animate(withDuration: 0.25, animations: {
                self.layout.invalidateLayout()
            }) { finished in self.layoutSubviews() }
        } else {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        tableView.reloadData()
    }
    
    func action(for button: ButtonType) {
        switch button {
        case .photoOrVideo:
        alertController?.addPhotoLibraryPicker(flow: .vertical, paging: false, selection: .single(action: { assets in
            if let assets = assets {
                self.selection?(TelegramSelectionType.photo(assets))
            }})
        )
        case .sendPhotos:
            alertController?.dismiss(animated: true) { [unowned self] in
                if let selectedAssets = selectedAssets {
                    self.selection?(TelegramSelectionType.photo(selectedAssets))
                }
            }
        }
    }
}

// MARK: - TableViewDelegate

extension TelegramPickerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        layout.selectedCellIndexPath = layout.selectedCellIndexPath == indexPath ? nil : indexPath
        action(withAsset: assets[indexPath.item], at: indexPath)
    }
}

// MARK: - CollectionViewDataSource

extension TelegramPickerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemWithPhoto.self), for: indexPath) as? ItemWithPhoto else { return UICollectionViewCell() }
        
        let asset = assets[indexPath.item]
        let size = sizeFor(asset: asset)
        
        DispatchQueue.main.async {
            Assets.resolve(asset: asset, size: size) { new in
                item.imageView.image = new
            }
        }
        
        return item
    }
}

// MARK: - PhotoLayoutDelegate

extension TelegramPickerViewController: PhotoLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        let size: CGSize = sizeForItem(asset: assets[indexPath.item])
        //Log("size = \(size)")
        return size
    }
}

// MARK: - TableViewDelegate

extension TelegramPickerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log("indexPath = \(indexPath)")
        DispatchQueue.main.async {
            self.action(for: self.buttons[indexPath.row])
        }
    }
}

// MARK: - TableViewDataSource

extension TelegramPickerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikeButtonCell.identifier) as! LikeButtonCell
        cell.textLabel?.font = font(for: buttons[indexPath.row])
        cell.textLabel?.text = title(for: buttons[indexPath.row])
        return cell
    }
}
