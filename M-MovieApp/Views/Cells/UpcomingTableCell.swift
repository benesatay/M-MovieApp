//
//  UpcomingTableCell.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

import UIKit

class UpcomingTableCell: UITableViewCell {
    
    lazy private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy private var poster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.bold(15).font
        label.textColor = Constants.Color.textBlack
        return label
    }()
    
    lazy private var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.medium(13).font
        label.textColor = Constants.Color.textGray
        label.numberOfLines = 2
        return label
    }()
    
    lazy private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.medium(12).font
        label.textColor = Constants.Color.textGray
        return label
    }()
    
    lazy private var rightArrowImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage.setIcon(.arrow_icon)
        return image
    }()
    
    public var data: Result? {
        didSet {
            if let data = data {
                self.updateUI(data.posterPath, data.title, data.overview, data.releaseDate)
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
        titleLabel.text = nil
        overviewLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.Gap.large)
        }
        
        containerView.addSubview(poster)
        poster.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.size.equalTo(self.snp.height).inset(Constants.Gap.large)
        }
        
        containerView.addSubview(rightArrowImage)
        rightArrowImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(poster.snp.trailing).offset(Constants.Gap.medium)
            make.top.equalTo(poster.snp.top).offset(Constants.Gap.medium)
            make.trailing.equalTo(rightArrowImage.snp.leading).offset(-Constants.Gap.large)
        }
        
        containerView.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Gap.medium)
            make.trailing.equalTo(titleLabel)
            
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(Constants.Gap.large)
            make.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
    }
    
    private func updateUI(_ posterPath: String?, _ title: String?, _ description: String?, _ dateString: String?) {
        if let posterPath = posterPath {
            let urlString = Service.type.image(posterPath, .w500).url
            if let url = URL(string: urlString) {
                poster.kf.setImage(with: url)
            }
        }
        
        let date = Utilities.setDate(dateString, with: Constants.DateFormat.year)
        titleLabel.text = String(format: Constants.StringFormat.titleFormatWithDate, title ?? "", date)
        overviewLabel.text = description
        let fullDate = Utilities.setDate(dateString, with: Constants.DateFormat.full)
        dateLabel.text = fullDate
    }
}









































