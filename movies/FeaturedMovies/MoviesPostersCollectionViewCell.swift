//
//  MoviesPostersCollectionViewCell.swift
//  movietest
//
//  Created by QwertY on 08.12.2021.
//

import UIKit

class MoviesPostersCollectionViewCell: UICollectionViewCell {

    static let identifier = "moviePosterCollectionViewCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(image: UIImage?) {
        imageView.image = image
    }
}
