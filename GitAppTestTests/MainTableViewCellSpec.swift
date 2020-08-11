//
//  MainTableViewCellSpec.swift
//  GitAppTestTests
//
//  Created by Danilo Requena on 10/08/20.
//

import Nimble
import Quick
import UIKit
@testable import GitAppTest

class MainTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("MainTableViewCell") {
            let view = MainTableViewCell()
            weak var cell: MainTableViewCell!
            weak var viewController: ViewController!
            weak var controller: UIViewController!
            
            beforeSuite {
                controller = UIApplication.shared.keyWindow?.rootViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(identifier: "ViewControllerID") as? ViewController
                UIApplication.shared.keyWindow?.rootViewController = viewController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                viewController.beginAppearanceTransition(true, animated: false)
                viewController.endAppearanceTransition()
                viewController.setupTableView()
                cell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MainTableViewCell
                viewController.viewDidLoad()
            }
            
                it("should init") {
                    expect(cell?.lbName).toNot(beNil())
                    expect(view).toNot(beNil())
                    expect(cell?.labelType).toNot(beNil())
                    expect(cell?.ivUser).toNot(beNil())
                    expect(cell?.lbName).toNot(beNil())
            }
        }
    }
}
