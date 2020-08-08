//
//  DetailViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 08/08/20.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageOwner: UIImageView!
    @IBOutlet weak var labelNameOwner: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var backgroundDescription: UIView!
    @IBOutlet weak var buttonGithub: UIButton!
    
    var gist: Gists!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupImage()
        setupLabels()
    }
    
    func setupViews() {
        backgroundView.layer.cornerRadius = 10
        backgroundDescription.layer.cornerRadius = 10
        buttonGithub.layer.cornerRadius = 4
        buttonGithub.layer.shadowOffset = CGSize(width: 10, height: 10)
        buttonGithub.layer.borderWidth = 1.5
        buttonGithub.layer.borderColor = UIColor.gray.cgColor
        buttonGithub.layer.shadowColor = UIColor.gray.cgColor
        buttonGithub.layer.shadowRadius = 4
    }
    
    func setupImage() {
        guard let url = URL(string: gist.owner.avatarURL) else { return }
        imageOwner.kf.setImage(with: url)
        imageOwner.clipsToBounds = true
        imageOwner.layer.cornerRadius = imageOwner.frame.size.height / 2
    }
    
    func setupLabels() {
        let noDescription = "No description"
        labelNameOwner.font = .boldSystemFont(ofSize: 17)
        labelNameOwner.textColor = .darkGray
        labelNameOwner.text = gist.owner.ownerName
        
        if gist.gistsDatumDescription != "" {
            labelDescription.font = .systemFont(ofSize: 15)
            labelDescription.textColor = UIColor.white
            labelDescription.text = gist.gistsDatumDescription
        } else {
            backgroundDescription.backgroundColor = .clear
            labelDescription.font = .systemFont(ofSize: 15)
            labelDescription.textColor = UIColor.placeholderText
            labelDescription.text = noDescription
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! WebViewController
        controller.gist = gist
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func gitHubPage(_ sender: UIButton) {
        
    }
}
