//
//  WebViewControllerSpec.swift
//  GitAppTestTests
//
//  Created by Danilo Requena on 10/08/20.
//

import Nimble
import Quick
import UIKit
@testable import GitAppTest

class WebViewControllerSpec: QuickSpec {
    override func spec() {
        describe("WebViewController") {
            var viewController: WebViewController?
            var controller: UIViewController!
            
            beforeSuite {
                controller = UIApplication.shared.keyWindow?.rootViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(identifier: "WeblViewControllerID") as? WebViewController
                UIApplication.shared.keyWindow?.rootViewController = viewController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                viewController?.beginAppearanceTransition(true, animated: false)
                viewController?.endAppearanceTransition()
                viewController?.viewDidLoad()
            }
            
            context("Check DetailViewController is not Nil") {
                it("is not nil") {
                    expect(viewController).toNot(beNil())
                    
                    expect(viewController?.loading).toNot(beNil())
                    expect(viewController?.loading.isHidden).to(equal(false))

                    expect(viewController?.webView).toNot(beNil())
                    expect(viewController?.webView.isHidden).to(equal(false))
                }
            }
        }
    }
}

