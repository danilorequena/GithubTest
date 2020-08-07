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
    @IBOutlet weak var lbForks: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
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
    
    func setupCell(data: GistsData) {
        guard let url = URL(string: data.owner.avatarURL) else { return }
        DispatchQueue.main.async {
            self.ivUser.kf.setImage(with: url)
            self.ivUser.kf.indicatorType = .activity
            self.lbName.text = data.owner.login
//            self.lbForks.text = data.forks.formatarMilhar
//            self.lbStars.text = data.stars.formatarMilhar
            self.lbDescription.text = data.description
        }
        self.ivUser.clipsToBounds = true
        self.ivUser.layer.cornerRadius = ivUser.frame.size.height / 2
    }
}
