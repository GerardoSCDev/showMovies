//
//  NetworkMager.swift
//  showMovies
//
//  Created by Gerardo Santillan on 16/03/25.
//

import Combine
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let acceptHeader: String = "application/json"
    private let authorizationHeader: String = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTQzYzIwMzVjYzBkYmFmNDkyZDk2YWU2Y2YyNjI2ZCIsIm5iZiI6MTc0MjA4Mzg3Mi43MTEsInN1YiI6IjY3ZDYxNzIwOTE2NWYzNzExODAxMzE0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FIPX6fzxnxl01tTCWLqLx37XsREw_qF2Ov-_3o508gM"
    
    private init() {}
    
    func fetchData<T: Decodable>(from endpoint: Endpoints, model: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.endpoint) else {
            throw NetworkError.invalidURL
        }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": acceptHeader,
            "Authorization": authorizationHeader
        ]
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case networkFailure
}


enum Endpoints {
    case topRated
    case movieDetail(Int)
    
    var endpoint: String {
        let service: String = ServerURL.apiThemoviedb.rawValue
        switch self {
        case .topRated:
            return "\(service)/movie/top_rated"
        case .movieDetail(let id):
            return "\(service)/movie/\(id)"
        }
    }
}
