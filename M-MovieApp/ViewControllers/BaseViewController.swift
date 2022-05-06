//
//  BaseViewController.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy private var contentView = UIView()
    
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
        
        contentView.backgroundColor = .white
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
