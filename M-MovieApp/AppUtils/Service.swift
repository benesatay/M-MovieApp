//
//  Service.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 7.05.2022.
//


struct Service {
    
    static let baseUrl = "https://api.themoviedb.org"
    static let imageBaseUrl = "https://image.tmdb.org"
    static let imdbBaseUrl = "https://www.imdb.com/title"

    static let version = "3"
    static let title = "movie"
    static let apiKey = "6b88449d2e1d52d486d9bf09c0206aa4"
    static let language = "en-US"
    static let page = "1"
    
    enum type {
        case nowPlaying
        case upcoming
        case image(String, ImageSize)
        case detail(String)
        case imdb(String)
        var url: String {
            switch self {
            case .nowPlaying:
                return String(format: "%@/%@/%@/%@?api_key=%@&language=%@&page=%@", Service.baseUrl, Service.version, Service.title, "now_playing", Service.apiKey, Service.language, Service.page)
            case .upcoming:
                return String(format: "%@/%@/%@/%@?api_key=%@&language=%@&page=%@", Service.baseUrl, Service.version, Service.title, "upcoming", Service.apiKey, Service.language, Service.page)
            case .image(let path, let size):
                return String(format: "%@/%@/%@/%@%@", Service.imageBaseUrl, "t", "p", size.rawValue, path)
            case .detail(let movieId):
                return String(format: "%@/%@/%@/%@?api_key=%@&language=%@&page=%@", Service.baseUrl, Service.version, Service.title, movieId, Service.apiKey, Service.language, Service.page)
            case .imdb(let imdbId):
                return String(format: "%@/%@", Service.imdbBaseUrl, imdbId)
            }
        }
    }
    
    enum ImageSize: String {
        case original = "original"
        case w500 = "w500"
    }
}
