//
//  ListMovieItem.swift
//  showMovies
//
//  Created by Gerardo Santillan on 16/03/25.
//

import SwiftUI

struct ListMovieItem: View {
    
    @State var showDetail: Bool = false
    @State var movie: Movie!
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 300)
                .blur(radius: 5)
                .cornerRadius(10)
            
            VStack {
                AsyncImage(url: URL(string: "\(ServerURL.apiImageThemoviedb.rawValue)\(movie.posterPath ?? "")")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(height: 180)
                            .cornerRadius(10)
                            .padding()
                    case .failure:
                        Text("Bad load image")
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(movie.title ?? "")
                    .foregroundColor(.white)
                
                VStack {
                    Text(movie.popularity?.oneDecimals() ?? "")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .padding(5)
                .background(.gray)
                .cornerRadius(25)
                .opacity(0.4)
                
                Spacer()
            }
            
        }
        .padding(1)
        .onTapGesture {
            showDetail.toggle()
        }
        .sheet(isPresented: $showDetail) {
            
        } content: {
            DetailMovieView(idMovie: movie.id ?? 0)
        }
        
        
    }
}
