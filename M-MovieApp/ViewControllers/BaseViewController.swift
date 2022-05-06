//
//  BaseViewController.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import UIKit
import SnapKit
import Kingfisher

class BaseViewController: UIViewController {
    
    public var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0
    }
    
    public var topSafeAreaHeight: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        return (keyWindow?.safeAreaInsets.top ?? 0)
    }
    
    public var topHeight: CGFloat {
        return topSafeAreaHeight + navigationBarHeight
    }
    
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy private var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .black
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.bounces = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func addSubview(_ subview: UIView) {
        contentView.addSubview(subview)
    }
    
    public func push(to controller: BaseViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    public func backPreviousController() {
        navigationController?.popViewController(animated: true)
    }
    
    public func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    public func showIndicator() {
        indicator.startAnimating()
    }
    
    public func hideIndicator() {
        indicator.stopAnimating()
    }
    
    
}

extension BaseViewController: UIScrollViewDelegate {
    
}
