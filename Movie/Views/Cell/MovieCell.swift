//
//  MovieCell.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    
    var data: MovieVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.title
                lblYear.text = data.year
                imgCover.setApiImage(url: data.poster ?? "")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
