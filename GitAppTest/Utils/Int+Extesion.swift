//
//  Int+Extesion.swift
//  GitAppTest
//
//  Created by Danilo Requena on 05/08/20.
//

import Foundation

extension Int64 {
    
    var formatarMilhar: String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self)) ?? self.description
    }
}
