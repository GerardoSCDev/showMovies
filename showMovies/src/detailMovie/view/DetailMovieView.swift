//
//  DetailMovieView.swift
//  showMovies
//
//  Created by Gerardo Santillan on 16/03/25.
//

import SwiftUI

struct DetailMovieView: View {
    
    @StateObject var viewModel = DetailMovieViewModel()
    @State var idMovie: Int = 0
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    VStack {
                        
                        AsyncImage(url: URL(string: "\(ServerURL.apiImageThemoviedb.rawValue)\(viewModel.movie?.posterPath ?? "")")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .tint(.white)
                            case .success(let image):
                                image
                                    .resizable()
                                    .cornerRadius(10)
                                    .padding()
                                    .edgesIgnoringSafeArea(.all)
                                    .frame(maxHeight: 430)
                            case .failure:
                                Text("Bad load image")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Divider()
                            .frame(maxHeight: 3)
                            .overlay(.white)
                            .opacity(0.5)
                        Text(viewModel.movie?.title ?? "")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Release date: \(viewModel.movie?.releaseDate ?? "")")
                            .font(.caption)
                            .foregroundColor(.white)
                        VStack {
                            Text(viewModel.movie?.popularity?.oneDecimals() ?? "")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(.gray)
                        .cornerRadius(25)
                        .opacity(0.4)
                        Divider()
                            .overlay(.white)
                            .opacity(0.5)
                        Text(viewModel.movie?.overview ?? "")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                    }
                    
                }
            }
            
            
        }
        .task {
            await viewModel.fetchMovieDetails(id: idMovie)
        }
    }
}

#Preview {
    DetailMovieView()
}
