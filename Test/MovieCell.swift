//
//  MovieCell.swift
//  Test
//
//  Created by cmc on 07/07/2022.
//

import UIKit
import Kingfisher
class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    func updateMovie(movie: MovieData) {
        titleLb.text = movie.title
        if let urlImage = URL(string: movie.poster ?? "") {
            thumbImgView.kf.setImage(with: urlImage)
        }
    }
    
    override func prepareForReuse() {
        thumbImgView.image = nil
        titleLb.text = nil
    }
}
