//
//  ListMoviesView.swift
//  showMovies
//
//  Created by Gerardo Santillan on 15/03/25.
//

import SwiftUI

struct ListMoviesView: View {
    
    @StateObject private var viewModel = ListMoviesViewModel()
    
    let colums = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: colums) {
                    if let topRateMovies = viewModel.topRateMovies {
                        if topRateMovies.results.count > 0 {
                            ForEach(Array(topRateMovies.results.enumerated()), id: \.offset) { _, movie in
                                ListMovieItem(showDetail: false, movie: movie)
                            }
                        }
                        
                    }
                }
            }.refreshable {
                
            }
            
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .task {
            viewModel.varifyExistInMemoryTopRatedMovies()
            if !viewModel.hasMemoryTopRatedMovies {
                await viewModel.fetchTopRatedMovies()
            }
        }
    }
}

#Preview {
    ListMoviesView()
}
