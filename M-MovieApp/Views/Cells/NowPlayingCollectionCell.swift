//
//  NowPlayingCollectionCell.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

import UIKit

class NowPlayingCollectionCell: UICollectionViewCell {
    
    lazy private var poster: UIImageView = {
        let image = UIImageView()
        image.layer.opacity = 0.4
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.bold(20).font
        label.textColor = .white
        return label
    }()
    
    lazy private var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.medium(12).font
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    public var data: Result? {
        didSet {
            if let data = data {
                self.updateUI(data.posterPath, data.title, data.releaseDate, data.overview)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
        titleLabel.text = nil
        overviewLabel.text = nil
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        self.addSubview(poster)
        self.addSubview(titleLabel)
        self.addSubview(overviewLabel)
        
        poster.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let bottomInset = Constants.Height.nowPlayingCellHeight/6
        overviewLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bottomInset)
            make.leading.trailing.equalToSuperview().inset(Constants.Gap.large)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(overviewLabel.snp.top)
            make.leading.trailing.equalToSuperview().inset(Constants.Gap.large)
        }
    }
    
    private func updateUI(_ posterPath: String?, _ title: String?, _ dateString: String?, _ overview: String?) {
        if let posterPath = posterPath {
            let urlString = Service.type.image(posterPath).url
            if let url = URL(string: urlString) {
                poster.kf.setImage(with: url)
            }
        }
        
        let date = Utilities.setDate(dateString, with: Constants.DateFormat.year)
        titleLabel.text = String(format: Constants.StringFormat.titleFormatWithDate, title ?? "", date)
        overviewLabel.text = overview
    }
    


}
