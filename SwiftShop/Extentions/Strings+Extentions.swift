//
//  Strings+Extentions.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 28/10/2024.
//

import Foundation
extension String {
    var asUrl: URL? {
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return URL(string: encodedString)
    }
}
