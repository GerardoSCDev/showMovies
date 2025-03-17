//
//  AuthenticationViewModel.swift
//  showMovies
//
//  Created by Gerardo Santillan on 17/03/25.
//

import Combine
import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var user = User()
    @Published var goToListMovies: Bool = false
    @Published var hasUser: Bool = false
    @Published var disabledButton: Bool = true
    @Published var badAuthentication: Bool = false
    
    func saveUser() {
        let userDefults = UserDefaults.standard
        userDefults.set(user.email, forKey: UserDefaultsKey.userEmail.rawValue)
        userDefults.set(user.password, forKey: UserDefaultsKey.userPassword.rawValue)
        hasUser = true
    }
    
    func verifyExistUser() {
        hasUser = hasUserSaved()
    }
    
    func validateForm() {
        if user.email.isEmpty || user.password.isEmpty {
            disabledButton = true
            return
        }
        
        if !user.email.isValidEmail() {
            disabledButton = true
            return
        }
        
        disabledButton = false
    }
    
    func loginUser() {
        let storedUser = loadUser()
        if storedUser.email == user.email && storedUser.password == user.password {
            badAuthentication = false
            goToListMovies = true
        } else {
            badAuthentication = true
        }
    }
    
    private func loadUser() -> (email: String, password: String) {
        let userDefults = UserDefaults.standard
        let email = userDefults.string(forKey: UserDefaultsKey.userEmail.rawValue) ?? ""
        let password = userDefults.string(forKey: UserDefaultsKey.userPassword.rawValue) ?? ""
        return (email, password)
    }
    
    private func hasUserSaved() -> Bool {
        let userDefults = UserDefaults.standard
        return userDefults.string(forKey: UserDefaultsKey.userEmail.rawValue) != nil
    }
}
