//
//  MovieListVM.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation

protocol MovieListViewDelegate {
    func onGetMovieList()
    func onError(error: String)
}

class MovieListVM {
    
    private(set) var movies: [MovieVO] = [] {
        didSet {
            delegate.onGetMovieList()
        }
    }
    
    private let network: NetworkManager = .shared
    
    private let delegate: MovieListViewDelegate
    
    init(delegate: MovieListViewDelegate) {
        self.delegate = delegate
    }
    
    func getLists() {
        network.request(endPoint: .List(
            MovieListRequest.init(search: "godzilla"))
        ) { [weak self] (data: MovieListResponse) in
            self?.movies = data.search
        } onFailure: { [weak self] error in
            print(error)
            self?.delegate.onError(error: "Error")
        }
    }
}
