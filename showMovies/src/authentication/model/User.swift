//
//  User.swift
//  showMovies
//
//  Created by Gerardo Santillan on 17/03/25.
//

import Foundation

class User: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}
