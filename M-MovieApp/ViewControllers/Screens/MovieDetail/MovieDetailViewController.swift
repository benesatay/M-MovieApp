//
//  MovieDetailViewController.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    private var viewModel = MovieDetailViewModel()
    private var movieDetailModel: MovieDetailModels.ViewModel? = nil
    private var movieId: Int = 0
    
    lazy private var customNavigationView = NavigationView()
    
    lazy private var poster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy private var backView = UIView()

    lazy private var imdbImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.setIcon(.imdb_logo)
        image.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imdbImageTapped))
        image.addGestureRecognizer(tapGesture)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy private var rateImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.setIcon(.rate_icon)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy private var ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.Font.medium(13).font
        label.textColor = Constants.Color.textBlack
        return label
    }()
    
    lazy private var dotView: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.Color.darkYellow
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.medium(13).font
        label.textColor = Constants.Color.textBlack
        return label
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.Font.bold(20).font
        label.textColor = Constants.Color.textBlack
        return label
    }()
    
    lazy private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.Font.regular(15).font
        textView.textColor = Constants.Color.textBlack
        textView.isScrollEnabled = false
        return textView
    }()
    
    init(_ movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.controller = self
        showIndicator()
        fetchDetail()
        setupView()
    }
    
    
    //MARK: - Private Methods
    private func fetchDetail() {
        viewModel.fetchDetail(self.movieId)
    }
    
    private func setupView() {
        view.addSubview(customNavigationView)
        customNavigationView.delegate = self
        customNavigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(topHeight)
        }
        
        self.addSubview(poster)
        self.addSubview(backView)
        backView.backgroundColor = .white
        poster.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topHeight)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Height.nowPlayingCellHeight)
        }
        
        backView.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualToSuperview()
            make.top.equalTo(poster.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        backView.addSubview(imdbImage)
        imdbImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Gap.large)
            make.leading.equalToSuperview().inset(Constants.Gap.large)
            make.height.equalTo(24)
        }
        
        backView.addSubview(rateImage)
        rateImage.snp.makeConstraints { make in
            make.leading.equalTo(imdbImage.snp.trailing).offset(Constants.Gap.small)
            make.centerY.equalTo(imdbImage)
        }
        
        backView.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateImage.snp.trailing).offset(Constants.Gap.small)
            make.centerY.equalTo(imdbImage)
        }
        
        backView.addSubview(dotView)
        dotView.snp.makeConstraints { make in
            make.leading.equalTo(ratingLabel.snp.trailing).offset(Constants.Gap.medium)
            make.size.equalTo(4)
            make.centerY.equalTo(imdbImage)
        }
        
        backView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(dotView.snp.trailing).offset(Constants.Gap.medium)
            make.centerY.equalTo(imdbImage)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Gap.large)
            make.top.equalTo(imdbImage.snp.bottom).offset(Constants.Gap.large)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        backView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Gap.large)
            make.leading.trailing.equalToSuperview().inset(Constants.Gap.large)
            make.bottom.lessThanOrEqualToSuperview()
        }

    }
 
    @objc func imdbImageTapped() {
        if let imdbId = movieDetailModel?.imdbID {
            Utilities.openURL(Service.type.imdb(imdbId).url)
        }
    }
    
    private func updateUI(_ posterPath: String?, _ rating: Double?, date: String?, _ title: String?, _ description: String? = "") {
        if let posterPath = posterPath {
            let urlString = Service.type.image(posterPath, .original).url
            if let url = URL(string: urlString) {
                poster.kf.setImage(with: url)
            }
        }
        
        if let rating = rating {
            let upperVote = "/10"
            ratingLabel.text = String(format: "%.1f\(upperVote)", rating)
            ratingLabel.setColor(of: upperVote, Constants.Color.darkGray)
        }
        
        let yearDate = Utilities.setDate(date, with: Constants.DateFormat.year)
        let fullTitle = String(format: Constants.StringFormat.titleFormatWithDate, title ?? "", yearDate)
        titleLabel.text = fullTitle
        customNavigationView.title = fullTitle

        let fullDate = Utilities.setDate(date, with: Constants.DateFormat.full)
        dateLabel.text = fullDate

        descriptionTextView.text = description
    }
}

//MARK: - MovieDetailViewModelDelegate
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func displayDetail(viewModel: MovieDetailModels.ViewModel) {
        self.movieDetailModel = viewModel
        updateUI(viewModel.posterPath, viewModel.voteAverage, date: viewModel.releaseDate, viewModel.title, viewModel.overview)
        hideIndicator()
    }
    
    func displayError(message: String) {
        presentAlert(with: message)
        hideIndicator()
    }
}

//MARK: - NavigationViewDelegate
extension MovieDetailViewController: NavigationViewDelegate {
    func leftButtonTapped() {
        backPreviousController()
    }
}
