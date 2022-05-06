//
//  MovieListViewController.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    //MARK: - Private Attr
    private let viewModel = MovieListViewModel()
    private let tableCellIdentifier = String(describing: UpcomingTableCell.self)
    private let collectionCellIdentifier = String(describing: NowPlayingCollectionCell.self)
    
    private var upcomingViewModel: MovieListModels.ViewModel? = nil
    private var nowPlayingViewModel: MovieListModels.ViewModel? = nil
    
    lazy private var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.showsVerticalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never
        collection.automaticallyAdjustsScrollIndicatorInsets = false
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.black
        collection.register(NowPlayingCollectionCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        return collection
    }()
    
    lazy private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
        return pageControl
    }()
    
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.register(UpcomingTableCell.self, forCellReuseIdentifier: tableCellIdentifier)
        return table
    }()
    

    override func viewDidLoad() {
        viewModel.controller = self
        super.viewDidLoad()
        showIndicator()
        getUpcomingMovies()
        getNowplayingMovies()
        setupView()
        setTimer()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Private Methods
    private func setupView() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(Constants.Height.nowPlayingCellHeight)
        }
        
        collectionView.createGradientLayer(
            colors: [
                UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor,
                UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1).cgColor
            ],
            viewFrame: collectionView.frame,
            startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.height.equalTo(Constants.Height.nowPlayingCellHeight/6)
            make.width.equalToSuperview().dividedBy(2.4)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collectionView)
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.lessThanOrEqualToSuperview().inset(40)
        }
    }
    
    private func getUpcomingMovies() {
        viewModel.fetchUpcoming()
    }
    
    private func getNowplayingMovies() {
        viewModel.fetchNowplaying()
    }
    
    private func setupTableCell(_ cell: UpcomingTableCell, at indexPath: IndexPath) {
        let data = self.upcomingViewModel?.movies?[indexPath.row]
        cell.data = data
    }
    
    private func setupCollectionCell(_ cell: NowPlayingCollectionCell, at indexPath: IndexPath) {
        cell.data = self.nowPlayingViewModel?.movies?[indexPath.row]
    }
    
    private func scroll(to menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        pageControl.currentPage = menuIndex
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
    
    private func setTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    private func passPageControlCurrentPage(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    private func setPageControl(numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
    private func routeToDetailViewController() {
        let destination = MovieDetailViewController()
        self.push(to: destination)
    }
    
    //MARK: - Actions
    
    @IBAction func scrollAutomatically() {
        let currentIndex: Int = Int(collectionView.contentOffset.x/collectionView.frame.width)
        let indexNumber: Int = Int(collectionView.contentSize.width/collectionView.frame.width)
        var nextIndex: Int = currentIndex
        if currentIndex < indexNumber-1 {
            nextIndex += 1
        } else {
            nextIndex = 0
        }
        scroll(to: nextIndex)
    }
}

//MARK: - MovieListViewModelDelegate
extension MovieListViewController: MovieListViewModelDelegate {
    func displayNowPlaying(viewModel: MovieListModels.ViewModel) {
        self.nowPlayingViewModel = viewModel
        self.setPageControl(numberOfPages: viewModel.count ?? 0)
        collectionView.reloadData()
        hideIndicator()
    }
    
    func displayUpcoming(viewModel: MovieListModels.ViewModel) {
        self.upcomingViewModel = viewModel
        tableView.reloadData()
        hideIndicator()
    }
    
    func displayError(message: String) {
        self.presentAlert(with: message)
        hideIndicator()
    }
}

//MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Height.upcomingCellHeight
    }
}

//MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier) as? UpcomingTableCell {
            setupTableCell(cell, at: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
}

//MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            passPageControlCurrentPage(scrollView)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            passPageControlCurrentPage(scrollView)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as? NowPlayingCollectionCell {
            self.setupCollectionCell(cell, at: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.frame.size
    }
}

