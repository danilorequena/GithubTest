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
        ownerName.text = gistDataModel.ownerName
        if let image = gistDataModel.ownerImage {
            guard let url = URL(string: image) else { return }
            imageOwner.kf.setImage(with: url)
        } else {
            imageOwner.image = UIImage(named: "noImage")
        }
    }

}
