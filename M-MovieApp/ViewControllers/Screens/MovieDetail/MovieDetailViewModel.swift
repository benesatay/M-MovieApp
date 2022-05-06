//
//  MovieDetailViewModel.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

protocol MovieDetailViewModelDelegate: AnyObject {
    func displayDetail(viewModel: MovieDetailModels.ViewModel)
    func displayError(message: String)
}

class MovieDetailViewModel {
    
    weak var controller: MovieDetailViewModelDelegate?
    
    init() {}
    
    func fetchDetail(_ movieId: Int) {
        RequestManager.fetchDetail(.detail("\(movieId)")) { [weak self] viewModel, error in
            guard let self = self else { return }
            if let viewModel = viewModel {
                self.controller?.displayDetail(viewModel: viewModel)
            } else if let error = error {
                self.controller?.displayError(message: error)
            }
        }
    }
}
