//
//  ContentView.swift
//  Cinema
//
//  Created by José Rodriguez Romero on 06/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var nowPlayingViewModel = NowPlayingViewModel()
    @StateObject var popularMoviesViewModel = PopularMoviesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("CineSpot")
                        .font(.system(size: 34))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Ahora en cines")
                        .font(.system(size: 28))
                        .padding([.leading, .trailing, .top ])
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(nowPlayingViewModel.movies) { movie in
                                VStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable().aspectRatio(contentMode: .fill)
                                        case .failure:
                                            Image(systemName: "film")
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: 200, height: 300)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                                .frame(width: 225, height: 325)
                                .background(Color.blue.opacity(1))
                                .cornerRadius(10)
                            }
                        }
                        .padding([.leading, .trailing], 8)
                    }
                    
                    HStack(spacing: 5) {
                        Text("Más populares")
                            .font(.system(size: 28))
                        
                        Image("fuego")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 28)
                    }
                    .padding([.leading, .trailing, .top])
                    
                    VStack {
                        LazyVStack(alignment: .center) {
                            ForEach(popularMoviesViewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                    HStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 100, height: 150)
                                            case .success(let image):
                                                image.resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 100, height: 150)
                                            case .failure:
                                                Image(systemName: "film")
                                                    .frame(width: 100, height: 150)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        .cornerRadius(10)
                                        
                                        VStack(alignment: .leading) {
                                            Text(movie.title)
                                                .font(.headline)
                                            Text("Fecha de estreno: \(movie.releaseDate)")
                                                .font(.subheadline)
                                        }
                                        Spacer()
                                    
                                        ZStack {
                                            Circle()
                                                .stroke(lineWidth: 5)
                                                .foregroundColor(movie.voteAverage > 5 ? Color.green : Color.yellow)
                                                .frame(width: 55, height: 55)
                                            
                                            Text("\(Int(movie.voteAverage * 10))%")
                                                .font(.caption)
                                        }
                                        //.padding(.top, 4)
                                        .padding(.trailing, 16)
                                        
                                    }
                                }
                                .frame(height: 100)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding([.leading, .trailing], 8)
                }
                
            }
            .onAppear {
                nowPlayingViewModel.loadNowPlayingMovies()
                popularMoviesViewModel.loadPopularMovies()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
    func formattedDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            return outputFormatter.string(from: date)
        }
        return self
    }
}
