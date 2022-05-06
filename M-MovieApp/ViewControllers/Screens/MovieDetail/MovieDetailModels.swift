//
//  MovieDetailModels.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

import Foundation

enum MovieDetailModels {
    struct Response {
        let model: MovieDetailResponseModel?
    }
    
    struct ViewModel {
        let imdbID, title, overview: String?
        let voteAverage: Double?
        let posterPath: String?
        let releaseDate: String?        
    }
}
