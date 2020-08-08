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
    @IBOutlet weak var lbStars: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func setupCell(data: Gists) {
        guard let url = URL(string: data.owner.avatarURL) else { return }
        self.ivUser.kf.setImage(with: url)
        self.ivUser.kf.indicatorType = .activity
        self.lbName.text = data.owner.ownerName
        self.bgView.layer.cornerRadius = 10
        self.lbDescription.text = "\(data.files.values)"
        self.ivUser.clipsToBounds = true
        self.ivUser.layer.cornerRadius = ivUser.frame.size.height / 2
    }
}
