//
//  POMaker.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 05/04/2022.
//

import Foundation
import UIKit
import UITextView_Placeholder

var screenWidth: CGFloat { return UIScreen.main.bounds.width }
var screenHeight: CGFloat {return UIScreen.main.bounds.height}
var topInset: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height




enum BorderOnly {
    case all
    case top
    case left
    case bottom
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

struct POMaker {
    static func makeScrollView(backgroundColor: UIColor = .clear) -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = backgroundColor
        if isDarkMode {
            view.backgroundColor = .black
        }else{
            view.backgroundColor = backgroundColor
        }
        return view
    }
    static func makeButtonSelect(text: String? = nil) -> ButtonSelector {
        let button = ButtonSelector()
        button.lbTitle.text = text
        return button
    }
    static func makeTableView(style: UITableView.Style = .plain, radius: CGFloat = 0, hideSeparator: Bool = false) -> UITableView
    {
        let view = UITableView(frame: .zero, style: style)
        view.layer.cornerRadius = radius
        if isDarkMode {
            view.backgroundColor = .black
        }else{
            view.backgroundColor = .backgroundColor
        }
        if hideSeparator {
            view.separatorStyle = .none
        }
        return view
    }
    static func makeLabel(text: String? = nil,
                          font: UIFont? = .helvetica,
                          color: UIColor = .textBlack,
                          alignment: NSTextAlignment = .left,
                          underLine: Bool = false,
                          line: Int = 0,
                          require: Bool = false
                        ) -> UILabel
    {
        let label = VerticalAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        if isDarkMode {
//            label.backgroundColor = .black
            label.textColor = .white
        }else{
//            label.backgroundColor = .backgroundColor
            label.textColor = color
        }
        label.textAlignment = alignment
        label.font = font
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = line
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        if underLine {
            let attributedString = NSMutableAttributedString.init(string: text ?? "")
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        }
        if require {
            let attributedString = NSMutableAttributedString.init(string: text ?? "")
            let myRange = NSRange.init(location: attributedString.length - 1, length: 1)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: myRange)
            label.attributedText = attributedString
        }
        return label
    }
    
    static func makeButton(title: String? = nil,
                           font: UIFont = .helvetica.withSize(16).setBold(),
                           color: UIColor = .white,
                           textAlignment: NSTextAlignment = .center,
                           backgroundColor: UIColor = .blueColor,
                           borderWidth: CGFloat = 0,
                           borderColor: UIColor = UIColor.clear,
                           cornerRadius: CGFloat = 10) -> UIButton
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        
        if let title = title
        {
            button.setTitle(title, for: .normal)
        }
        
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        button.titleLabel?.minimumScaleFactor = 0.1
        button.titleLabel?.textAlignment = textAlignment
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.sizeToFit()
        
        if borderWidth > 0
        {
            button.layer.borderWidth = borderWidth
            button.layer.borderColor = borderColor.cgColor
            button.layer.masksToBounds = true
        }
        button.layer.cornerRadius = cornerRadius
        return button
    }
    
    static func makeStackView(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 20, distri: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = distri
        return stack
    }
    
    static func makeImageView(image: UIImage? = nil,
                              contentMode: UIView.ContentMode = .scaleAspectFill,
                              backgroundColor: UIColor = .clear,
                              borderWidth: CGFloat = 0,
                              borderColor: UIColor = .clear,
                              cornerRadius: CGFloat = 0) -> UIImageView
    {
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = contentMode
        iv.clipsToBounds = true
        iv.backgroundColor = backgroundColor
        iv.layer.borderWidth = borderWidth
        iv.layer.borderColor = borderColor.cgColor
        iv.layer.cornerRadius = cornerRadius
        return iv
    }
    static func makeImage(image: String = "",
                              contentMode: UIView.ContentMode = .scaleAspectFit,
                              backgroundColor: UIColor = .clear,
                              borderWidth: CGFloat = 0,
                              borderColor: UIColor = .clear,
                              cornerRadius: CGFloat = 0) -> UIImageView
    {
        let iv = UIImageView(image: UIImage(named: image))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = contentMode
        iv.clipsToBounds = true
        iv.backgroundColor = backgroundColor
        iv.layer.borderWidth = borderWidth
        iv.layer.borderColor = borderColor.cgColor
        iv.layer.cornerRadius = cornerRadius
        return iv
    }
    static func makeImage(image: String = "",
                          tintColor: UIColor = .blueColor,
                              contentMode: UIView.ContentMode = .scaleAspectFit,
                              backgroundColor: UIColor = .clear,
                              borderWidth: CGFloat = 0,
                              borderColor: UIColor = .clear,
                              cornerRadius: CGFloat = 0) -> UIImageView
    {
        let iv = UIImageView(image: UIImage(named: image)?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = tintColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = contentMode
        iv.clipsToBounds = true
        iv.backgroundColor = backgroundColor
        iv.layer.borderWidth = borderWidth
        iv.layer.borderColor = borderColor.cgColor
        iv.layer.cornerRadius = cornerRadius
        return iv
    }
    
    static func makeCollectionView(_ collectionWith: CGFloat, itemSpacing: CGFloat = 0, itemsInLine: CGFloat = 0, itemHeight: CGFloat) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let totalWidth: CGFloat = collectionWith - (itemsInLine + 1) * itemSpacing
        layout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        layout.itemSize = CGSize(width: totalWidth/itemsInLine, height: itemHeight)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        if isDarkMode{
            collection.backgroundColor = .black
        }else{
            collection.backgroundColor = .backgroundColor
        }
     
        return collection
    }
    
    static func makeCollectionView() -> UICollectionView
    {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func makeView(backgroundColor: UIColor = .white, borderWidth: CGFloat = 0, borderColor: UIColor = .black, radius: CGFloat = 0, radiusOnly: BorderOnly = .all) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if isDarkMode{
            view.backgroundColor = .black
            view.layer.borderColor = UIColor.white.cgColor
        }else{
            view.backgroundColor = backgroundColor
            view.layer.borderColor = borderColor.cgColor
        }
        view.layer.masksToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = radius
        
        switch radiusOnly {
        case .top:
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .left:
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .bottom:
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .right:
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .topLeft:
            view.layer.maskedCorners = [.layerMinXMinYCorner]
        case .topRight:
            view.layer.maskedCorners = [.layerMaxXMinYCorner]
        case .bottomLeft:
            view.layer.maskedCorners = [.layerMinXMaxYCorner]
        case .bottomRight:
            view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        case .all:
            break
        }
        return view
    }
    
    static func paymentItem(logo: String, name: String) -> UIView {
        let btn = UIView()
        let logoView = makeView(backgroundColor: .white, borderWidth: 0.5, borderColor: .blueColor, radius: 14)
        let imgLogo = makeImageView(image: UIImage(named: logo), contentMode: .scaleAspectFit)
        let lbName = makeLabel(text: name, color: .textColor, alignment: .center)
        btn.addSubview(logoView)
        logoView.viewConstraints(top: btn.topAnchor, left: btn.leftAnchor, right: btn.rightAnchor, size: CGSize(width: (screenWidth - 80)/4, height: (screenWidth - 80)/4))
        logoView.addSubview(imgLogo)
        imgLogo.viewConstraints(top: logoView.topAnchor, left: logoView.leftAnchor, bottom: logoView.bottomAnchor, right: logoView.rightAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        
        btn.addSubview(lbName)
        lbName.viewConstraints(top: logoView.bottomAnchor, left: logoView.leftAnchor, bottom: btn.bottomAnchor, right: logoView.rightAnchor, padding: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
        return btn
    }
    
    static func makeTextField(
        text: String? = nil,
        placeholder: String? = nil,
        font: UIFont = UIFont.helvetica,
        textColor: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        backgroundColor: UIColor = .clear,
        borderWidth: CGFloat = 0.5,
        borderColor: UIColor = .blueColor,
        cornerRadius: CGFloat = 8,
        isPass: Bool = false,
        isSelector: Bool = false) -> UITextField
    {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = text
        textField.placeholder = placeholder
        textField.font = font
        if isDarkMode {
            textField.textColor = .white
            textField.backgroundColor = .black
        }else{
            textField.textColor = textColor
            textField.backgroundColor = backgroundColor
        }
        textField.textAlignment = textAlignment
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.cornerRadius = cornerRadius
        textField.layer.masksToBounds = true
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftViewMode = .always
            
        if textAlignment == .right
        {
            textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
            textField.rightViewMode = .always
        }
        if isSelector {
            let rightView = UIView()
            let image = UIImageView(image: UIImage(systemName: "chevron.down"))
            rightView.addSubview(image)
            image.horizontal(toView: rightView, space: 8)
            image.vertical(toView: rightView)
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
        if isPass {
            textField.isSecureTextEntry = true
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
            textField.rightView = rightView
            textField.rightViewMode = .always
            let btnShowHide = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
            btnShowHide.setImage(UIImage(named: "eye_showing")?.resized(to: CGSize(width: 24, height: 24)).withRenderingMode(.alwaysTemplate), for: .normal)
            btnShowHide.imageView?.tintColor = .gray
            btnShowHide.addTarget(self, action: #selector(textField.showHidePassword), for: .touchUpInside)
            rightView.addSubview(btnShowHide)
        }
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.addDoneButtonOnKeyBoardWithControl()
        return textField
    }

    static func makeTextView(text: String = "",
                             placeholder: String = "",
                             font: UIFont = .helvetica,
                             textColor: UIColor = .textBlack,
                             textAlignment: NSTextAlignment = .justified,
                             maximumNumberOfLines: Int = 4,
                             borderWidth: CGFloat = 1,
                             borderColor: UIColor = .borderColor,
                             cornerRadius: CGFloat = 6) -> UITextView
    {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        textView.attributedText = NSAttributedString(string: text, attributes: attributes)
        
        textView.text = text
        textView.placeholder = placeholder
        textView.font = font
        if isDarkMode {
            textView.textColor  = .white
        }else{
            textView.textColor = textColor
        }
        
        textView.textAlignment = textAlignment
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textContainer.maximumNumberOfLines = maximumNumberOfLines
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.autocorrectionType = .no
        textView.layer.borderWidth = borderWidth
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.cornerRadius = cornerRadius
        textView.isMultipleTouchEnabled = true
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.addDoneButtonOnKeyBoardWithControl()
        return textView
    }
    static func makeButtonIcon(
        imageName: String = "",
        tintColor: UIColor = .black,
        imageEdgeInsets: UIEdgeInsets = .zero,
        backgroundColor: UIColor = .clear,
        cornerRadius: CGFloat = 0) -> UIButton
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: imageName)
        {
            let templateImage = image.withRenderingMode(.alwaysTemplate)
            button.setImage(templateImage, for: .normal)
        }
        
        if isDarkMode {
            button.imageView?.tintColor = .white
        }else{
            button.imageView?.tintColor = tintColor
        }
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = imageEdgeInsets
        button.backgroundColor = backgroundColor
        
        if cornerRadius > 0
        {
            button.layer.cornerRadius = cornerRadius
        }
        button.clipsToBounds = true
        return button
    }
}
