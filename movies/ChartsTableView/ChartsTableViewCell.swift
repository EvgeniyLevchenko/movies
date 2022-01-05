//
//  ChartsTableViewCell.swift
//  movietest
//
//  Created by QwertY on 11.12.2021.
//

import UIKit

class ChartsTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieNumber: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    
    static let identifier = "ChartsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(index: String, text: String, image: UIImage?) {
        movieNumber.text = index
        movieNameLabel.text = text
        posterImageView.image = image
    }
}
