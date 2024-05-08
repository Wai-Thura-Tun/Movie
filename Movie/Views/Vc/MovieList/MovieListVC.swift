//
//  MovieList.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import UIKit

class MovieListVC: UIViewController {
    
    @IBOutlet weak var tbMovieList: UITableView!
    @IBOutlet weak var loadidng: UIActivityIndicatorView!
    
    private lazy var vm: MovieListVM = .init(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBindings()
        self.loadidng.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.vm.getLists()
        }
    }
    
    private func setUpViews() {
        tbMovieList.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tbMovieList.dataSource = self
        tbMovieList.delegate = self
    }
    
    private func setUpBindings() {
        
    }
}

extension MovieListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell
        guard let cell = cell else { return UITableViewCell.init() }
        cell.data = vm.movies[indexPath.row]
        return cell
    }
}

extension MovieListVC: UITableViewDelegate {
    
}

extension MovieListVC: MovieListViewDelegate {
    
    func onGetMovieList() {
        DispatchQueue.main.async { [weak self] in
            self?.loadidng.stopAnimating()
            self?.tbMovieList.reloadData()
        }
    }
    
    func onError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.loadidng.stopAnimating()
            self?.showError(message: error)
        }
    }
    
    private func showError(message: String) {
        let alertController = UIAlertController.init(title: "Error",
                                                     message: message,
                                                     preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
