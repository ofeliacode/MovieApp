//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Офелия Баширова on 08.12.2020.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Variables
    var selectedDescription: String?
    var selectedTitle: String?
    var selectedImage: String?
    var idOfSelectedMovie: Int?
    var selectedReleaseDateOfMovie: String?
    var movieModel = MovieViewModel()
    private var network = MovieViewModel()
    private var moviesArray: MoviesData?
    
   // MARK: - Functions
    override func viewDidLoad() {
       super.viewDidLoad()
       setupOfConstraints()
       fetchMoviePoster()
       descriptionOfMovie.text = selectedDescription
       titleOfMovie.text = selectedTitle
       releaseDateOfMovie.text = "data release: \(selectedReleaseDateOfMovie ?? "not assigned")"
       navigationController?.navigationBar.prefersLargeTitles = false
       self.title = selectedTitle
       self.navigationController?.navigationBar.barTintColor = .white
       view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
   }
    
    //MARK: - setup UI
    var descriptionOfMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    var imageView: UIImageView = {
            let img = UIImageView()
            img.clipsToBounds = true
            return img
    }()
    var titleOfMovie: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    var releaseDateOfMovie: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - getting poster for selected movie
    func fetchMoviePoster() {
        if selectedImage != nil {
            movieModel.downloadPosterImage(posterPath: selectedImage!) { (image) in
                DispatchQueue.main.async {
                self.imageView.image = image
                }
            }
        }  else {
            self.imageView.image = UIImage(named: "404")
        }
    }
    
     
    //MARK: - setup constraints
    func setupOfConstraints () {
        view.addSubview(imageView)
        view.addSubview(descriptionOfMovie)
        view.addSubview(titleOfMovie)
        view.addSubview(releaseDateOfMovie)
        descriptionOfMovie.translatesAutoresizingMaskIntoConstraints = false
        titleOfMovie.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        releaseDateOfMovie.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 113),
            imageView.heightAnchor.constraint(equalToConstant: 390),
            imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50),
            imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            titleOfMovie.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 17),
            titleOfMovie.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            titleOfMovie.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -25)
        ])
        NSLayoutConstraint.activate([
            releaseDateOfMovie.topAnchor.constraint(equalTo: titleOfMovie.bottomAnchor, constant: 17),
            releaseDateOfMovie.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            releaseDateOfMovie.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -25)
        ])

        NSLayoutConstraint.activate([
            descriptionOfMovie.topAnchor.constraint(equalTo: releaseDateOfMovie.bottomAnchor, constant: 17),
            descriptionOfMovie.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            descriptionOfMovie.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -25)
        ])
    }
}


