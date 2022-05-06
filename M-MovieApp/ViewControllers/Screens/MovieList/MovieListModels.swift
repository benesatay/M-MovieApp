//
//  MovieListModels.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import Foundation

enum MovieListModels {
    struct Response {
        let model: MovieResponseModel?
    }
    
    struct ViewModel {
        let movies: [Result]?
        var count: Int?
    }
}
