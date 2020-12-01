//
//  ViewController.swift
//  MovieApp
//
//  Created by Офелия Баширова on 28.10.2020.
//

import UIKit

import RealmSwift

import Foundation
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView : UICollectionView?
    var movieModel = MovieViewModel()
    let searchController = UISearchController(searchResultsController: nil)
  //  var mainScrollView: UIScrollView!
    var movieManager = MovieManager()
    
    
    private func showSearchBar() {
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
      //  mainScrollView?.delegate = self
        collectionView.backgroundColor = .white
       // mainScrollView?.isScrollEnabled = true
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        self.collectionView = collectionView
       // collectionView.addSubview(mainScrollView!)
    }
   
    
    private func loadMoviesData() {
        let url =
              "https://api.themoviedb.org/3/movie/popular?api_key=dfc41d3d13bc64503f9270485fa8746f&page=\(page)"
        movieModel.fetchMoviesData(url: url) { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    func fetchMoviesFromRealmDB() {
        let realm = try! Realm()
        let results = realm.objects(Movie.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // realm.beginWrite()
        // realm.delete(realm.objects(Movie.self))
        // try! realm.commitWrite()
        fetchMoviesFromRealmDB()
        collectionView?.reloadData()
        showSearchBar()
        setupCollectionview()
        loadMoviesData()
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.tintColor = .red
        title = "Movie app"
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        let count = movieModel.numberOfRowInSections(section: section)
        //        if count <= 100 {
        //            return count
        //        } else {
        //            return 100
        //        }
        
        return  min(movieModel.numberOfRowInSections(section: section), 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        let movie = movieModel.cellForRowAt(indexPath: indexPath)
        cell.setup(movie)
        return cell
    }
    
    var page = 1
    func getMoviesWithPaging(from: Int) {
        page += 1
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=dfc41d3d13bc64503f9270485fa8746f&page=\(page)"
        movieModel.loadMoreMovies(url: url) {[weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
   /* func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieModel.movies.count - 1 {
           // getMoviesWithPaging(from: page)
            print("add")
        }
    } */
  
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=dfc41d3d13bc64503f9270485fa8746f&query=\(searchText)&page=\(page)"
        movieModel.fetchMoviesData(url: url) {[weak self] in
            self?.collectionView?.reloadData()
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
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > ((collectionView?.contentSize.height)!-100-scrollView.frame.size.height)  {
            getMoviesWithPaging(from: page)
            print("fetch more data Ofa")
            print("page from scrola \(page)")
        }
    }
}
