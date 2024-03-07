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
        Text("Detalle de la película")
            .onAppear {
                loadMovieDetails()
            }
    }
    
    private func loadMovieDetails() {
       
    }
}
