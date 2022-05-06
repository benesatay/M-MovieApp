//
//  NavigationView.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 7.05.2022.
//

import Foundation
import UIKit

protocol NavigationViewDelegate: AnyObject {
    func leftButtonTapped()
}

final class NavigationView: UIView {
    
    weak var delegate: NavigationViewDelegate?
    
    lazy private var leftButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage.setIcon(.back_arrow_icon), for: .normal)
        button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.Font.bold(15).font
        label.textColor = Constants.Color.textBlack
        label.textAlignment = .center
        return label
    }()
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(leftButton)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.Gap.medium)
        }
        
        leftButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(Constants.Gap.medium)
            make.trailing.lessThanOrEqualTo(titleLabel.snp.leading).offset(-Constants.Gap.medium*3)
        }
    }
    
    @IBAction func leftButtonTapped() {
        delegate?.leftButtonTapped()
    }
}
