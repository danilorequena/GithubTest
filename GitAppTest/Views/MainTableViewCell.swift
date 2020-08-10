//
//  MainTableViewCell.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    
    var items: [GistsData] = []

    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data: Gists) {
        guard let url = URL(string: data.owner.avatarURL) else { return }
        self.ivUser.kf.setImage(with: url)
        self.ivUser.kf.indicatorType = .activity
        self.lbName.text = data.owner.ownerName
        self.labelType.text = data.files.values.first?.type
        self.ivUser.clipsToBounds = true
        self.ivUser.layer.cornerRadius = ivUser.frame.size.height / 2
    }
}
