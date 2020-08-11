//
//  DetailViewControllerSpec.swift
//  GitAppTestTests
//
//  Created by Danilo Requena on 10/08/20.
//

import Nimble
import Quick
import UIKit
@testable import GitAppTest

class DetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("DetailViewController") {
            var viewController: DetailViewController?
            var controller: UIViewController!
            
            beforeSuite {
                controller = UIApplication.shared.keyWindow?.rootViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(identifier: "DetailViewControllerID") as? DetailViewController
                UIApplication.shared.keyWindow?.rootViewController = viewController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                viewController?.beginAppearanceTransition(true, animated: false)
                viewController?.endAppearanceTransition()
                viewController?.viewDidLoad()
            }
            
            context("Check DetailViewController is not Nil") {
                it("is not nil") {
                    expect(viewController).toNot(beNil())
                    
                    expect(viewController?.buttonGithub).toNot(beNil())
                    expect(viewController?.buttonGithub.isHidden).to(equal(false))

                    expect(viewController?.imageOwner).toNot(beNil())
                    expect(viewController?.imageOwner.isHidden).to(equal(false))
                    
                    expect(viewController?.labelDescription).toNot(beNil())
                    expect(viewController?.labelDescription.isHidden).to(equal(false))
                    
                    expect(viewController?.labelNameOwner).toNot(beNil())
                    expect(viewController?.labelNameOwner.isHidden).to(equal(false))
                }
            }
        }
    }
}

