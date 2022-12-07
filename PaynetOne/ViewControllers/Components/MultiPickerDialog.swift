//
//  MultiPickerDialog.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 07/10/2022.
//

import Foundation
import UIKit
import QuartzCore
import ObjectiveC
import SwiftTheme


class MultiPickerDialog: UIView, UITableViewDelegate, UITableViewDataSource {
    
    typealias MultiPickerCallback = (_ values: [[String: String]]) -> Void
    
    /* Constants */
    private let kPickerDialogDefaultButtonHeight:       CGFloat = 50
    private let kPickerDialogDefaultButtonSpacerHeight: CGFloat = 1
    private let kPickerDialogCornerRadius:              CGFloat = 7
    private let kPickerDialogDoneButtonTag:             Int     = 1
    
    /* Views */
    private var dialogView:   UIView!
    private var titleLabel:   UILabel!
    private var picker:       UITableView!
    private var cancelButton: UIButton!
    private var doneButton:   UIButton!
    private var viewLine1 = POMaker.makeView(backgroundColor: .backgroundColor)
    private var viewLine2 = POMaker.makeView(backgroundColor: .backgroundColor)
    private var viewLine3 = POMaker.makeView(backgroundColor: .backgroundColor)
    
    /* Variables */
    private var pickerData =         [[String: String]]()
    private var selectedPickerValues: [String]?
    private var callback:            MultiPickerCallback?
    
    
    /* Overrides */
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.dialogView = createContainerView()
        
        self.dialogView!.layer.shouldRasterize = true
        self.dialogView!.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.dialogView!.layer.opacity = 0.5
        self.dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        picker.delegate = self
        picker.dataSource = self
        picker.allowsMultipleSelection = true
        picker.separatorStyle = .none
        
        /*
         NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
         [self tableView:tableViewList didSelectRowAtIndexPath:selectedCellIndexPath];
         [tableViewList selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
         */
        
        self.addSubview(self.dialogView!)
        
        
    }
    
    /* Handle device orientation changes */
    @objc func deviceOrientationDidChange(notification: NSNotification) {
        close() // For now just close it
    }
    
    /* Helper to find row of selected value */
    func findIndicesForValues(values: [String], array: [[String: String]]) -> [Int] {
        var selectedIndices : [Int] = []
        for (index, dictionary) in array.enumerated() {
            for selectedOption in values {
                if dictionary["value"] == selectedOption {
                    selectedIndices.append(index)
                }
            }
            
        }
        return selectedIndices
    }
    
    /* Create the dialog view, and animate opening the dialog */
    func show(title: String, doneButtonTitle: String = "Select", cancelButtonTitle: String = "Cancel", options: [[String: String]], selected: [String]? = nil, callback: @escaping MultiPickerCallback) {
        self.titleLabel.text = title
        self.pickerData = options
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        self.callback = callback
        
        if selected != nil {
            self.selectedPickerValues = selected
            let selectedIndices = findIndicesForValues(values: selected!, array: options)
            print("selectedIndices \(selectedIndices)")
            for index in selectedIndices{
                let selectedCellIndexPath = IndexPath.init(row: index, section: 0)
                self.tableView(picker, didSelectRowAt: selectedCellIndexPath)
                picker.selectRow(at: selectedCellIndexPath as IndexPath, animated: true, scrollPosition: .none)
            }
        }
        
        let scene = UIApplication.shared.connectedScenes.first
        guard let sceneDelegate = scene?.delegate as? SceneDelegate else{
            return
        }
        
        sceneDelegate.window?.addSubview(self)
        sceneDelegate.window?.bringSubviewToFront(self)
        sceneDelegate.window?.endEditing(true)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MultiPickerDialog.deviceOrientationDidChange(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
        },
            completion: nil
        )
    }
    
    /* Dialog close animation then cleaning and removing the view from the parent */
    private func close() {
        NotificationCenter.default.removeObserver(self)
        
        let currentTransform = self.dialogView.layer.transform
        
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + Double.pi * 270 / 180), 0, 0, 0)
        
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.opacity = 0
        }) { (finished: Bool) -> Void in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            
            self.removeFromSuperview()
        }
    }
    
    /* Creates the container view here: create the dialog, then add the custom content and buttons */
    private func createContainerView() -> UIView {
        let screenSize = countScreenSize()
        let dialogSize = CGSize.init(
            width: 300,
            height: 242
                + kPickerDialogDefaultButtonHeight)
        
        // For the black background
        self.frame = CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        // This is the dialog's container; we attach the custom content and the buttons to this one
        let dialogContainer = UIView(frame: CGRect.init(x: (screenSize.width - dialogSize.width) / 2, y: (screenSize.height - dialogSize.height) / 2, width: dialogSize.width, height: dialogSize.height))
        
        // First, we style the dialog to match the iOS8 UIAlertView >>>
        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
        gradient.frame = dialogContainer.bounds
        gradient.colors = [UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor,
                           UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor,
                           UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor]
        
        let cornerRadius = kPickerDialogCornerRadius
        gradient.cornerRadius = cornerRadius
        dialogContainer.layer.insertSublayer(gradient, at: 0)
        
        dialogContainer.layer.cornerRadius = cornerRadius
        dialogContainer.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        dialogContainer.layer.borderWidth = 1
        dialogContainer.layer.shadowRadius = cornerRadius + 5
        dialogContainer.layer.shadowOpacity = 0.1
        dialogContainer.layer.shadowOffset = CGSize.init(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        dialogContainer.layer.shadowColor = UIColor.black.cgColor
        dialogContainer.layer.shadowPath = UIBezierPath(roundedRect: dialogContainer.bounds, cornerRadius: dialogContainer.layer.cornerRadius).cgPath
        
        // There is a line above the button
//        let lineView = UIView(frame: CGRect.init(x: 0, y: dialogContainer.bounds.size.height - kPickerDialogDefaultButtonHeight - kPickerDialogDefaultButtonSpacerHeight, width: dialogContainer.bounds.size.width, height: kPickerDialogDefaultButtonSpacerHeight))
//        lineView.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
//        dialogContainer.addSubview(lineView)
        // ˆˆˆ
        
        //Title
        self.titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 300, height: 50))
        self.titleLabel.textAlignment = NSTextAlignment.center
       
        self.titleLabel.font = .helvetica.withSize(18)
        dialogContainer.addSubview(self.titleLabel)
        
        self.viewLine1 = UIView(frame: CGRect.init(x: 0, y: 50, width: 300, height: 1))
        
        dialogContainer.addSubview(self.viewLine1)
        
        self.picker = UITableView(frame: CGRect.init(x: 0, y: 51, width: 10, height: 10))
        //self.picker.setValue(UIColor(hex: 0x333333), forKeyPath: "textColor")
        self.picker.autoresizingMask = UIView.AutoresizingMask.flexibleRightMargin
        self.picker.frame.size.width = 300
        self.picker.frame.size.height = 190
        
        if StoringService.shared.isDarkMode(){
            self.titleLabel.textColor = .white
            self.titleLabel.backgroundColor = .black
            self.viewLine1.backgroundColor  = .white
            self.picker.backgroundColor = .black
            
        }else{
            self.titleLabel.textColor = .black
            self.titleLabel.backgroundColor = .backgroundColor
            self.viewLine1.backgroundColor  = .backgroundColor
            self.picker.backgroundColor = .backgroundColor
        }
    
        dialogContainer.addSubview(self.picker)
        
        
        
        // Add the buttons
        addButtonsToView(container: dialogContainer)
        
        return dialogContainer
    }
    
    /* Add buttons to container */
    private func addButtonsToView(container: UIView) {
        let buttonWidth = container.bounds.size.width / 2
        
        self.cancelButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        self.cancelButton.frame = CGRect.init(x: 0, y: 242, width: buttonWidth-0.5, height: kPickerDialogDefaultButtonHeight)
        
        
        if StoringService.shared.isDarkMode(){
            self.cancelButton.setTitleColor(.white, for: .normal)
            self.cancelButton.setTitleColor(.white, for: .highlighted)
            self.cancelButton.backgroundColor = .black

        }else{
            self.cancelButton.setTitleColor(.black, for: .normal)
            self.cancelButton.setTitleColor(.black, for: .highlighted)
            self.cancelButton.backgroundColor = .backgroundColor
        }
        self.cancelButton.titleLabel!.font = .helvetica.withSize(15)//UIFont(name: "AvenirNext-Medium", size: 15
        self.cancelButton.addTarget(self, action: #selector(MultiPickerDialog.buttonTapped(sender:)), for: UIControl.Event.touchUpInside)
        container.addSubview(self.cancelButton)
        
        self.doneButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        self.doneButton.frame = CGRect.init(x: buttonWidth+0.5, y: 242, width: buttonWidth-0.5, height: kPickerDialogDefaultButtonHeight)
        
        
        self.doneButton.tag = kPickerDialogDoneButtonTag
        if StoringService.shared.isDarkMode(){
            self.doneButton.setTitleColor(.white, for: .normal)
            self.doneButton.setTitleColor(.white, for: .highlighted)
            self.doneButton.backgroundColor = .black

        }else{
            self.doneButton.setTitleColor(.black, for: .normal)
            self.doneButton.setTitleColor(.black, for: .highlighted)
            self.doneButton.backgroundColor = .backgroundColor
        }
        self.doneButton.titleLabel!.font = .helvetica.withSize(15)
//        self.doneButton.layer.cornerRadius = kPickerDialogCornerRadius
        self.doneButton.addTarget(self, action: #selector(MultiPickerDialog.buttonTapped(sender:)), for: .touchUpInside)
        container.addSubview(self.doneButton)
        
        
        self.viewLine2 = UIView(frame: CGRect.init(x: 0, y:241, width: 300, height: 1))
       
        container.addSubview(self.viewLine2)
        
        self.viewLine3 = UIView(frame: CGRect.init(x: 0, y:241, width: 1, height: kPickerDialogDefaultButtonHeight))
        container.addSubview(self.viewLine3)
        if StoringService.shared.isDarkMode(){
            viewLine2.backgroundColor = .white
            viewLine3.backgroundColor = .white
           
        }else{
            viewLine2.backgroundColor = .backgroundColor
            viewLine3.backgroundColor = .backgroundColor
        }
    }
    
    @objc func buttonTapped(sender: UIButton!) {
        if sender.tag == kPickerDialogDoneButtonTag {
            var theSelectedValues : [[String: String]] = []
            
            if let indexPathsForSelectedRows = self.picker.indexPathsForSelectedRows{
                for indexPath  in indexPathsForSelectedRows{
                    let cell = self.picker.cellForRow(at: indexPath)
                    theSelectedValues.append(["value":(cell?.contnetIdentifier)!, "display":(cell?.textLabel?.text)!])
                }
            }
            
            self.callback?(theSelectedValues)
        }
        
        close()
    }
    
    func countScreenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    /* Helper function: count and return the screen's size */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "cell")
        if ((cell == nil)) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        let theCell = cell!
        
        theCell.textLabel?.text = self.pickerData[indexPath.row]["display"]
        theCell.contnetIdentifier = self.pickerData[indexPath.row]["value"]
        theCell.textLabel?.textAlignment = .left
        theCell.selectionStyle = .none
        if StoringService.shared.isDarkMode(){
            theCell.backgroundColor = .black
            theCell.textLabel?.textColor = .white
        }else{
            theCell.backgroundColor = .backgroundColor
            theCell.textLabel?.textColor = .black
        }
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
        theCell.accessoryType = rowIsSelected ? .checkmark : .none
        
        
        return theCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pickerData.count
    }
    
    
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.selected = true
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    internal func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
    }
    
    
    
}

var AssociatedObjectHandleOfCellContnetIdentifier: UInt8 = 0

extension UITableViewCell {
    var contnetIdentifier:String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandleOfCellContnetIdentifier) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandleOfCellContnetIdentifier, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
