//
//  FavoriteViewCellSpec.swift
//  GitAppTestTests
//
//  Created by Danilo Requena on 10/08/20.
//

import Nimble
import Quick
import UIKit
@testable import GitAppTest

class FavoriteTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("FavoriteTableViewCell") {
            let view = FavoriteTableViewCell()
            weak var cell: FavoriteTableViewCell!
            weak var viewController: FavoriteViewController!
            weak var controller: UIViewController!
            
            beforeSuite {
                controller = UIApplication.shared.keyWindow?.rootViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(identifier: "FavoriteViewControllerID") as? FavoriteViewController
                UIApplication.shared.keyWindow?.rootViewController = viewController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                viewController.beginAppearanceTransition(true, animated: false)
                viewController.endAppearanceTransition()
                viewController.setupTableView()
                cell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FavoriteTableViewCell
                viewController.viewDidLoad()
            }
            
                it("should init") {
                    expect(cell?.ownerName).toNot(beNil())
                    expect(view).toNot(beNil())
                    expect(cell?.imageOwner).toNot(beNil())
            }
        }
    }
}
