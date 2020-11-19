//
//  ViewController.swift
//  MovieApp
//
//  Created by Офелия Баширова on 28.10.2020.
//

import UIKit
import Foundation
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView : UICollectionView?
    var movieModel = MovieViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var page = 1
    var movieManager = MovieManager()
       

    private func showSearchBar(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search here..."
    }
    
    func setupCollectionview() {
        super.loadView()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        self.collectionView = collectionView
        collectionView.alwaysBounceVertical = false
    }
    private func loadMoviesData() {
        movieModel.fetchMoviesData { [weak self] in
        self?.collectionView?.dataSource = self
        self?.collectionView?.delegate = self
        self?.collectionView?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showSearchBar()
        setupCollectionview()
        loadMoviesData()
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.tintColor = .red
        title = "Movie app"
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.numberOfRowInSections(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        let movie = movieModel.cellForRowAt(indexPath: indexPath)
        cell.setup(movie)
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
URLSession.shared.dataTask(with: URL(string:
"https://api.themoviedb.org/3/search/movie?api_key=dfc41d3d13bc64503f9270485fa8746f&query=\(searchText)&page=\(page)")!,
  completionHandler: { [weak self] data, response, error in
    guard let data = data, error == nil else {
        return
    }
    var result: MoviesData?
    do {
        result = try JSONDecoder().decode(MoviesData.self, from: data)
    }
    catch {
        print("error")
    }
    guard let finalResult = result else {
        return
    }
    let newMovies = finalResult.results
    print(newMovies)
    
    self?.movieModel.movies = newMovies
   
    DispatchQueue.main.async {
        self?.collectionView?.reloadData()
    }
    
   }).resume()
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width - 16, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}


