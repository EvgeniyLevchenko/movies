//
//  MoviesCollectionViewCell.swift
//  movietest
//
//  Created by QwertY on 08.12.2021.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    private var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var movieName: UILabel = {
        let label = UILabel()
        label.font.withSize(12)
        label.textAlignment = .center
        label.contentMode = .scaleToFill
        label.clipsToBounds = true
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    static let identifier = "moviesCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(image: UIImage?, text: String) {
        moviePoster.image = image
        movieName.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(moviePoster)
        contentView.addSubview(movieName)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moviePoster.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height - 40)
        movieName.frame = CGRect(x: 0, y: self.frame.size.height - 40, width: self.frame.size.width, height: 40)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
