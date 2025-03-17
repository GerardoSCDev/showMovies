//
//  DetailMovieViewModel.swift
//  showMovies
//
//  Created by Gerardo Santillan on 17/03/25.
//

import Combine

class DetailMovieViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var movie: Movie?
    
    private let networkManager = NetworkManager.shared
    private var errorMessage: String = ""
    
    @MainActor
    func fetchMovieDetails(id: Int) async {
        isLoading = true
        do {
            let data: Movie = try await networkManager.fetchData(from: .movieDetail(id), model: Movie.self)
            movie = data
        } catch NetworkError.invalidURL {
            errorMessage = "URL is invalid"
        } catch NetworkError.decodingError {
            errorMessage = "Error decoding the data"
        } catch {
            errorMessage = "An unknown error occurred"
        }
        isLoading = false
    }
}
