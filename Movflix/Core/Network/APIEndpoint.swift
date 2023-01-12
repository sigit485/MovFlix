//
//  APIEndpoint.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

extension APIManager {
    public static let baseURL = "https://api.themoviedb.org/3"
    public static let apiKey = "091e5fbd6bca51a32524f3f03d2a0d2e"
    
    public static func selectedMovieEndpoint(of category: MovieCategory) -> String {
        switch category {
        case .nowPlaying:
            return "/movie/now_playing"
        case .topRated:
            return "/movie/top_rated"
        case .popular:
            return "/movie/popular"
        case .genre:
            return "/genre/movie/list"
        }
    }
    
    public static func selectedTVEndpoint(of category: TVCategory) -> String {
        switch category {
        case .onAir:
            return "/tv/on_the_air"
        case .topRated:
            return "/tv/top_rated"
        case .popular:
            return "/tv/popular"
        }
    }
    
}
