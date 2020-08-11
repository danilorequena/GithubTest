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
        backgroundColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
        layer.borderWidth = 5
        layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.cornerRadius = 12
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
