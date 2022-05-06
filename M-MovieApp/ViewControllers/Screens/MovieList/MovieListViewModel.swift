//
//  MovieListViewModel.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//


protocol MovieListViewModelDelegate: AnyObject {
    func displayUpcoming(viewModel: MovieListModels.ViewModel)
    func displayNowPlaying(viewModel: MovieListModels.ViewModel)
    func displayError(message: String)
}

class MovieListViewModel {
    
    weak var controller: MovieListViewModelDelegate?
    
    init() {}
    
    func fetchUpcoming() {
        RequestManager.fetchUpcoming(.upcoming) { [weak self] viewModel, error in
            guard let self = self else { return }
            if let viewModel = viewModel {
                self.controller?.displayUpcoming(viewModel: viewModel)
            } else if let error = error {
                self.controller?.displayError(message: error)
            }
        }
    }

    func fetchNowplaying() {
        RequestManager.fetchNowplaying(.nowPlaying) { [weak self] viewModel, error in
            guard let self = self else { return }
            if let viewModel = viewModel {
                self.controller?.displayNowPlaying(viewModel: viewModel)
            } else if let error = error {
                self.controller?.displayError(message: error)
            }
        }
    }
}
