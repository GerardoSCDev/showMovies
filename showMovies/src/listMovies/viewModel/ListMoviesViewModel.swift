//
//  ListMoviesViewModel.swift
//  showMovies
//
//  Created by Gerardo Santillan on 16/03/25.
//

import Combine
import Foundation

class ListMoviesViewModel: ObservableObject {
    
    @Published var hasMemoryTopRatedMovies: Bool = false
    @Published var isLoading: Bool = false
    @Published var topRateMovies: TopRated?
    
    private let networkManager = NetworkManager.shared
    private var errorMessage: String = ""
    
    @MainActor
    func fetchTopRatedMovies() async {
        do {
            let data: TopRated = try await networkManager.fetchData(from: .topRated, model: TopRated.self)
            topRateMovies = data
            saveTopRatedMovies(data)
        } catch NetworkError.invalidURL {
            errorMessage = "URL is invalid"
        } catch NetworkError.decodingError {
            errorMessage = "Error decoding the data"
        } catch {
            errorMessage = "An unknown error occurred"
        }
    }
    
    func varifyExistInMemoryTopRatedMovies() {
        if let topRated = loadTopRatedMovies() {
            hasMemoryTopRatedMovies = true
            topRateMovies = topRated
        } else {
            hasMemoryTopRatedMovies = false
        }
    }
    
    private func saveTopRatedMovies(_ topRated: TopRated) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(topRated)
            UserDefaults.standard.set(data, forKey: UserDefaultsKey.ratedMovies.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadTopRatedMovies() -> TopRated? {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKey.ratedMovies.rawValue) {
            let decoder = JSONDecoder()
            do {
                let myStruct = try decoder.decode(TopRated.self, from: data)
                return myStruct
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}
