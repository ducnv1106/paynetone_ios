//
//  CustomTabController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 08/08/2022.
//

import UIKit

class TabBarItem: UIButton {
    var itemHeight: CGFloat = 0
    var lock = false
    var color: UIColor = UIColor.lightGray {
        didSet {
            guard lock == false else { return }
            iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = color
            iconImageView.contentMode = .scaleAspectFit
            textLabel.textColor = color
    }}
    
    private let iconImageView = POMaker.makeImageView()
    private let textLabel = POMaker.makeLabel(font: .helvetica.withSize(12).setBold(), alignment: .center, line: 1)
    
    convenience init(icon: UIImage, title: String, font: UIFont = UIFont.systemFont(ofSize: 18)) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = icon
        textLabel.text = title
        setupView()
    }
    
    private func setupView() {
        addSubviews(views: iconImageView, textLabel)
        iconImageView.top(toView: self, space: 8)
        iconImageView.centerX(toView: self)
        iconImageView.square()
        
        let iconBottomConstant: CGFloat = textLabel.text == "" ? 2 : 20
        iconImageView.bottom(toView: self, space: iconBottomConstant)
        
        textLabel.bottom(toView: self, space: 2)
        textLabel.centerX(toView: self)
    }
}

class TabBar: UITabBar {
    var po_item = [TabBarItem]()
    convenience init(tabItem: [TabBarItem]) {
        self.init()
        po_item = tabItem
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    override var tintColor: UIColor! {
        didSet {
            for item in po_item {
                item.color = tintColor
    }}}
    
    func setupView() {
        if po_item.count == 0 { return }
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 2
        let itemWidth: CGFloat = screenWidth / CGFloat(po_item.count)
        for i in 0 ..< po_item.count {
            let offsetX = itemWidth * CGFloat(i)
            let item = po_item[i]
            addSubviews(views: item)
            if item.itemHeight == 0 {
                item.vertical(toView: self)
            }
            else {
                item.bottom(toView: self)
                item.height(item.itemHeight)
            }
            item.width(itemWidth)
            if item.lock == false {
                item.color = tintColor
            }
            if i < po_item.count-1 {
                item.addBorders(edges: [.right], color: UIColor.blueColor, inset: 4, thickness: 0.5)
            }
            item.left(toView: self, space: offsetX)
        }
    }
}

class CustomTabController: UITabBarController {
    var myTabBar: TabBar!
    var selectedColor = UIColor.blueColor
//    var tabHeightConstraint: NSLayoutConstraint?
    var tabBottomConstraint: NSLayoutConstraint?
    let duration = 0.5
    var normalColor = UIColor.textGray {
        didSet {
            myTabBar.tintColor = normalColor
        }}
    var currentTab: ((_ index: Int) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.delegate = self
        
        var swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(swipe:)))
//        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(swipe:)))
//        swipe.numberOfTouchesRequired = 1
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        
    }
    
    @objc private func swipeGesture(swipe:UISwipeGestureRecognizer){
        switch swipe.direction{
        case .right:
            if selectedIndex > 0 {
                let oldIndex = self.selectedIndex
                self.selectedIndex = self.selectedIndex - 1
                changeTab(from: oldIndex, to: self.selectedIndex)
            }
            break
        case .left:
            if selectedIndex<3{
                let oldIndex = self.selectedIndex
                self.selectedIndex = self.selectedIndex + 1
                changeTab(from: oldIndex, to: self.selectedIndex)
            }
            break
        default:
            break
        }
        
    }

    func setupView() {}
    
    func setTabBar(items: [TabBarItem]) {
        guard items.count > 0 else { return }
        
        myTabBar = TabBar(tabItem: items)
        guard let bar = myTabBar else { return }
        myTabBar.tintColor = normalColor
        bar.po_item.first?.color = selectedColor
        
        view.addSubviews(views: bar)
        bar.horizontal(toView: view)
        tabBottomConstraint = bar.safeBottom(toView: view)
        bar.height(tabBar.frame.height)
        for i in 0 ..< items.count {
            items[i].tag = i
            items[i].addTarget(self, action: #selector(switchTab), for: .touchUpInside)
        }
    }
    
    @objc func switchTab(button: UIButton) {
        let newIndex = button.tag
        changeTab(from: selectedIndex, to: newIndex)
    }
    
    private func changeTab(from fromIndex: Int, to toIndex: Int) {
        myTabBar.po_item[fromIndex].color = normalColor
        myTabBar.po_item[toIndex].color = selectedColor
        animateSliding(from: fromIndex, to: toIndex)
        if let currentTab = currentTab {
            currentTab(toIndex)
        }
    }
    
    func animateSliding(from fromIndex: Int, to toIndex: Int) {
        guard fromIndex != toIndex else { return }
        guard let fromController = viewControllers?[fromIndex], let toController = viewControllers?[toIndex] else { return }
        let fromView = fromController.view!
        let toView = toController.view!
        let viewSize = fromView.frame
        let scrollRight = fromIndex < toIndex
        fromView.superview?.addSubview(toView)
        toView.frame = CGRect(x: scrollRight ? screenWidth : -screenWidth, y: viewSize.origin.y, width: screenWidth, height: viewSize.height)
            
        func animate() {
            fromView.frame = CGRect(x: scrollRight ? -screenWidth : screenWidth, y: viewSize.origin.y, width: screenWidth, height: viewSize.height)
            toView.frame = CGRect(x: 0, y: viewSize.origin.y, width: screenWidth, height: viewSize.height)
        }
            
        func finished(_ completed: Bool) {
            fromView.removeFromSuperview()
            selectedIndex = toIndex
        }
            
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut, animations: animate, completion: finished)
    }
    
    func hideTabbar(){
        UIView.animate(withDuration: duration) {
            self.tabBottomConstraint?.constant = self.tabBar.frame.height + 4
            self.view.layoutIfNeeded()
        }
    }
    
    func showTabbar(){
        UIView.animate(withDuration: duration) {
            self.tabBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
extension CustomTabController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return TabViewAnimation()
    }
}
class TabViewAnimation : NSObject, UIViewControllerInteractiveTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning) -> TimeInterval{
        return 0.5
    }
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: .to) else {return}
        
        destination.transform = CGAffineTransform(translationX: 0, y: destination.frame.height)
        transitionContext.containerView.addSubview(destination)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {destination.transform = .identity}, completion: {transitionContext.completeTransition($0)})
    }
    
    
}
