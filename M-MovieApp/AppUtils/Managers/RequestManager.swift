//
//  RequestManager.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import Foundation

class RequestManager {        
    class func fetchUpcoming(_ type: Service.type, completion: @escaping(MovieListModels.ViewModel?, String?) -> Void) {
          BaseRequestManager.request(type, method: .get) { data, error in
            do {
                if let data = data {
                    let responseModel = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                    let viewModel = MovieListModels.ViewModel(movies: responseModel.results, count: responseModel.results?.count ?? 0)
                    completion(viewModel, nil)
                } else if let error = error {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error.localizedDescription)
            }

        }
    }
    
    class func fetchNowplaying(_ type: Service.type, completion: @escaping(MovieListModels.ViewModel?, String?) -> Void) {
         BaseRequestManager.request(type, method: .get) { data, error in
            do {
                if let data = data {
                    let responseModel = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                    let viewModel = MovieListModels.ViewModel(movies: responseModel.results, count: responseModel.results?.count ?? 0)
                    completion(viewModel, nil)
                } else if let error = error {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    class func fetchDetail(_ type: Service.type, completion: @escaping(MovieDetailModels.ViewModel?, String?) -> Void) {
        BaseRequestManager.request(type, method: .get) { data, error in
            do {
                if let data = data {
                    let responseModel = try JSONDecoder().decode(MovieDetailResponseModel.self, from: data)
                    let viewModel = MovieDetailModels.ViewModel(
                        imdbID: responseModel.imdbID,
                        title: responseModel.title,
                        overview: responseModel.overview,
                        voteAverage: responseModel.voteAverage,
                        posterPath: responseModel.posterPath,
                        releaseDate: responseModel.releaseDate
                    )
                    completion(viewModel, nil)
                } else if let error = error {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
    }
}
