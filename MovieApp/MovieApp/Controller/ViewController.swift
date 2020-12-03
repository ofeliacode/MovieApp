//
//  ViewController.swift
//  MovieApp
//
//  Created by Офелия Баширова on 28.10.2020.
//

import UIKit

import RealmSwift

import Foundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    //Mark: = Variables
    let searchController = UISearchController(searchResultsController: nil)
    var movieModel = MovieViewModel()
    var moviesArray: MoviesData?
    var collectionView : UICollectionView?
    var numberPageOfMoviesResult: Int = 1
    var numberPageOfSearchMoviesResult: Int = 1
    var searchText: String = ""
    
    //Mark: = override
    override func viewDidLoad() {
        super.viewDidLoad()
        // realm.beginWrite()
        // realm.delete(realm.objects(Movie.self))
        // try! realm.commitWrite()
        //fetchMoviesFromRealmDB()
        showSearchBar()
        setupCollectionview()
        loadMoviesData()
        title = "Movie app"
    }
    
    //Mark: = Functions
    private func showSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.placeholder = "Search"
        navigationController?.navigationBar.barTintColor = .none
        navigationController?.navigationBar.tintColor = .systemGray
    }
    
    //Mark: = Setup Collectionview
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
    }
   
    //Mark: = loading movies into collectionView on the frist screen
    private func loadMoviesData() {
        movieModel.fetchMoviesForCollectionView(pageNumber: numberPageOfMoviesResult, completion: { (loadedMovies) in
            self.moviesArray = loadedMovies
            self.collectionView?.reloadData()
        })
    }
    
    //Mark: = Pagination for first screen of movies results
    func fetchNextPageOfloadedMovies() {
        movieModel.fetchMoviesForCollectionView(pageNumber: numberPageOfMoviesResult) { loadedNewPage in
            guard let newPage = loadedNewPage else { return }
            for item in newPage.results {
                self.moviesArray?.results.append(item)
            }
        }
    }
    
    //Mark: = UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        let count = movieModel.numberOfRowInSections(section: section)
        //        if count <= 100 {
        //            return count
        //        } else {
        //            return 100
        //        }
        return moviesArray?.results.count ?? 0
       // return  min(movieModel.numberOfRowInSections(section: section), 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        let movie = moviesArray?.results[indexPath.row]
        cell.setup(movie!)
        return cell
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            if searchText == "" {
                fetchNextPageOfloadedMovies()
                numberPageOfMoviesResult += 1
                collectionView?.reloadData()
            } else {
               //fetchNextPageOfSearchResults()
                numberPageOfSearchMoviesResult += 1
                collectionView?.reloadData()
            }
        }
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}

