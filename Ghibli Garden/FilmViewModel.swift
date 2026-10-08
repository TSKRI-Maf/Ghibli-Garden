//
//  FilmViewModel.swift
//  Ghibli Garden
//
//  Created by María Fernanda Espinosa Vásquez on 07/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
class FilmViewModel {
    
    var arrFilms = [Film]()
    var isLoading = false
    var errorMessage: String? = nil
    
    func getFilms() async {
        
        // Loading starts
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        // 1. URL
        guard let url = URL(
            string: "https://ghibliapi.vercel.app/films"
        ) else {
            errorMessage = "Invalid URL."
            return
        }
        
        // 2. URL Request
        let urlRequest = URLRequest(url: url)
        
        do {
            // 3. URL Call
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                errorMessage = "Invalid server response."
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                errorMessage = "Server error: \(httpResponse.statusCode)"
                return
            }
            
            // 4. Decode
            let results = try JSONDecoder().decode([Film].self, from: data)
            
            // 5. Save results
            arrFilms = results
            
        } catch let error as URLError where error.code == .notConnectedToInternet {
            errorMessage = "No internet connection. Please try again."
            
        } catch {
            errorMessage = "Could not load movies: \(error.localizedDescription)"
        }
    }
}
