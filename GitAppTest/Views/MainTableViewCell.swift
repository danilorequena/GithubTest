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
        if let image = data.owner.avatarURL {
            guard let url = URL(string: image) else { return }
            self.ivUser.kf.setImage(with: url)
            self.ivUser.kf.indicatorType = .activity
            self.ivUser.clipsToBounds = true
            self.ivUser.layer.cornerRadius = ivUser.frame.size.height / 2
            backgroundColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
            layer.borderWidth = 5
            layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            layer.cornerRadius = 12
        } else {
            self.ivUser.image = UIImage(named: "noImage")
            backgroundColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
            layer.borderWidth = 4
            layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            layer.cornerRadius = 10
        }
        self.lbName.text = data.owner.ownerName
        self.labelType.text = data.files.values.first?.type
        
    }
}
