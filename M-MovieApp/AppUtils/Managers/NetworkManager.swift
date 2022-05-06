//
//  NetworkManager.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import Foundation

struct Service {
    
    static let baseUrl = "https://api.themoviedb.org"
    static let imageBaseUrl = "https://image.tmdb.org"
    static let version = "3"
    static let title = "movie"

    
    static let apiKey = "6b88449d2e1d52d486d9bf09c0206aa4"
    static let language = "en-US"
    static let page = "1"
    
    
    enum type {
        case nowPlaying
        case upcoming
        case image(String)
        
        var url: String {
            switch self {
            case .nowPlaying:
                return String(format: "%@/%@/%@/%@?api_key=%@&language=%@&page=%@", Service.baseUrl, Service.version, Service.title, "now_playing", Service.apiKey, Service.language, Service.page)
            case .upcoming:
                return String(format: "%@/%@/%@/%@?api_key=%@&language=%@&page=%@", Service.baseUrl, Service.version, Service.title, "upcoming", Service.apiKey, Service.language, Service.page)
            case .image(let path):
                return String(format: "%@/%@/%@/%@%@", Service.imageBaseUrl, "t", "p", "w500", path)
            }
        }
    }
    
//    enum URL {
////        case image(String)
////        case common(Service.type)
////
////        var string: String {
////            switch self {
////            case .common(let type):
////                return String(format: "%@/%@/%@/%@?api_key=%@&language=%@&page=%@", Service.baseUrl, Service.version, Service.title, type.value, Service.apiKey, Service.language, Service.page)
////            case .image(let movieId):
////                return String(format: "%@/%@/%@/%@/%@?api_key=%@", Service.baseUrl, Service.version, Service.title, movieId, Service.type.image.value, Service.apiKey)
////            }
////        }
//    }
    
}
