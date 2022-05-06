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
}
