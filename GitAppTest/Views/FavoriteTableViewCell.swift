//
//  FavoriteTableViewCell.swift
//  GitAppTest
//
//  Created by Danilo Requena on 08/08/20.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOwner: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(with gistDataModel: GistDataModel) {
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 4
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 10
        ownerName.text = gistDataModel.ownerName
        if let image = gistDataModel.ownerImage {
            guard let url = URL(string: image) else { return }
            imageOwner.kf.setImage(with: url)
            imageOwner.kf.indicatorType = .activity
            imageOwner.clipsToBounds = true
            imageOwner.layer.cornerRadius = imageOwner.frame.size.height / 2
        } else {
            imageOwner.image = UIImage(named: "noImage")
        }
    }

}
