//
//  MovieDetailView.swift
//  Cinema
//
//  Created by José Rodriguez Romero on 06/03/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @State private var movieDetails: Movie?
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Cargando...")
            } else if let movie = movieDetails {
                ScrollView {
                    VStack {
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "film.fill").resizable()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Text(movie.title)
                            .font(.title)
                            .padding(.bottom, 1)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack {
                            HStack {
                                Image("reloj")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                if let duration = movie.duration {
                                    Text("\(duration) minutos")
                                } else {
                                    Text("No disponible")
                                }
                            }
                            
                            Spacer()
                            
                            HStack {
                                Image("pelicula")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                if let genres = movie.genres, !genres.isEmpty {
                                    ForEach(genres) { genre in
                                        Text(genre.name)
                                    }
                                } else {
                                    Text("No disponible")
                                }
                            }
                        }
                        
                        Divider()
                        
                            .padding(.bottom, 1)
                        Text("Calificación: \(movie.voteAverage, specifier: "%.1f")/10")
                            .padding(.bottom, 1)
                        
                        Text("Fecha de estreno: \(movie.releaseDate)")
                            .padding(.bottom, 1)
                        
                        Divider()
                        
                        Text("Resumen: \(movie.overview)")
                            .padding(.bottom, 1)
                    }
                    .padding()
                }
            } else {
                Text("No se pudo cargar los detalles de la película.")
            }
        }
        .navigationBarTitle("Detalles", displayMode: .inline)
        .onAppear {
            loadMovieDetails()
        }
    }
    
    private func loadMovieDetails() {
        isLoading = true
        MovieService.shared.fetchMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let movieDetails):
                self.movieDetails = movieDetails
            case .failure(let error):
                print("Error loading movie details: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
