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
    @IBOutlet weak var buttonFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        let favoriteButton = UIButton(type: .system)
//        favoriteButton.setTitle("Some Title", for: .normal)
//        favoriteButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        accessoryView = favoriteButton
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
        self.labelType.text = data.files.values.first?.type
        self.ivUser.clipsToBounds = true
        self.ivUser.layer.cornerRadius = ivUser.frame.size.height / 2
    }
}
