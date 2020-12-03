//
//  UICollectionViewCell.swift
//  MovieApp
//
//  Created by Офелия Баширова on 30.10.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "cellIdentifier"
    private var urlStringOfPoster: String = ""
    
    var descriptionOfMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    let imageView: UIImageView = {
            let img = UIImageView()
            img.clipsToBounds = true
            return img
    }()
    let titleOfMovie: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    //Mark: = Functions
    func setup(_ movie: Movie) {
        updateUI(title: movie.title, poster: movie.posterImage, overview: movie.overview)
    }
    
    func updateUI(title: String?, poster: String?, overview: String?) {
        titleOfMovie.text = title
        descriptionOfMovie.text = overview
        guard let posterString = poster else {return}
        
        urlStringOfPoster = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlStringOfPoster) else {
            imageView.image = UIImage(named: "no image")
            return
        }
        imageView.image = nil
        getImageFromURL(url: posterImageURL)
    }
  
    func getImageFromURL(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // поймать ошибку
            if let error = error {
                print("empty data")
                return
            }
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.imageView.image = image                }
            }
        
        }.resume()
    }
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.contentView.addSubview(descriptionOfMovie)
            self.contentView.addSubview(titleOfMovie)
            self.contentView.addSubview(imageView)
            descriptionOfMovie.translatesAutoresizingMaskIntoConstraints = false
            titleOfMovie.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 120),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 3/4),
            ])
            NSLayoutConstraint.activate([
                titleOfMovie.heightAnchor.constraint(equalToConstant: 20),
                titleOfMovie.leadingAnchor.constraint(equalTo:imageView.trailingAnchor, constant: 20),
                titleOfMovie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ])
            NSLayoutConstraint.activate([
                descriptionOfMovie.centerYAnchor.constraint(equalTo: centerYAnchor),
                descriptionOfMovie.topAnchor.constraint(equalTo: titleOfMovie.bottomAnchor),
                descriptionOfMovie.heightAnchor.constraint(equalToConstant: 80),
                descriptionOfMovie.leadingAnchor.constraint(equalTo:imageView.trailingAnchor, constant: 20),
                descriptionOfMovie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ])
            
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            fatalError("Interface Builder is not supported!")
        }

}
