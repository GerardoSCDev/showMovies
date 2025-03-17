//
//  StringExtension.swift
//  showMovies
//
//  Created by Gerardo Santillan on 17/03/25.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
