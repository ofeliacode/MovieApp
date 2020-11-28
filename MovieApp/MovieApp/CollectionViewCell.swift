//
//  UICollectionViewCell.swift
//  MovieApp
//
//  Created by Офелия Баширова on 30.10.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "cellIdentifier"
    weak var textLabel: UILabel!
    private var urlStringOfPoster: String = ""
    
    //
    func setup(_ movie: Movie) {
        updateUI(title: movie.title, poster: movie.posterImage)
    }
    
    //
    func updateUI(title: String?, poster: String?) {
        textLabel.text = title
        guard let posterString = poster else {return}
        
        urlStringOfPoster = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlStringOfPoster) else {
            imageView.image = UIImage(named: "no image")
            return
        }
        imageView.image = nil
        getImageFromURL(url: posterImageURL)
    }
    
    //
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
    
    //
    let imageView: UIImageView = {
            let img = UIImageView()
            img.clipsToBounds = true
            //img.translatesAutoresizingMaskIntoConstraints = false
            return img
    }()
    
    //
        override init(frame: CGRect) {
            super.init(frame: frame)

            let textLabel = UILabel(frame: .zero)
            
            self.contentView.addSubview(textLabel)
            self.contentView.addSubview(imageView)
            
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 120),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 3/4),
            ])
            NSLayoutConstraint.activate([
                textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                textLabel.heightAnchor.constraint(equalToConstant: 80),
                textLabel.leadingAnchor.constraint(equalTo:imageView.trailingAnchor, constant: 20),
                textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            ])
            self.textLabel = textLabel
            textLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            self.textLabel.textAlignment = .left
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            fatalError("Interface Builder is not supported!")
        }

}
