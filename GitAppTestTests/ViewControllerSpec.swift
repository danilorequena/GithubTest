//
//  ViewControllerSpec.swift
//  GitAppTestTests
//
//  Created by Danilo Requena on 10/08/20.
//

import Nimble
import Quick
import UIKit
@testable import GitAppTest

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ViewController") {
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
                viewController.viewDidLoad()
            }
            
            context("Check ViewController is not Nil") {
                it("is not nil") {
                    expect(viewController).toNot(beNil())
                    expect(viewController.tableView).toNot(beNil())
                    expect(viewController.tableView.isHidden).to(equal(false))

                }
            }
        }
    }
}

