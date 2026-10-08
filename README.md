🌸 Ghibli Garden

Ghibli Garden is an iOS application developed using SwiftUI that allows users to explore movies from Studio Ghibli.

The app displays a list of movies with their posters, titles, directors, and release years. Users can select a movie to view more details, including its description and running time.

API Used

Studio Ghibli API

https://ghibliapi.vercel.app/films

The application uses a GET request to retrieve movie information from this public API. No API key is required.

Features

* Movie list with posters and basic information.
* Navigation from the movie list to a detail screen.
* Loading indicators for API requests and images.
* Error handling for network and API failures.
* Retry button when a request fails.


Technologies

* Swift
* SwiftUI
* MVVM Architecture
* URLSession
* JSONDecoder
* NavigationStack
* AsyncImage

How to Run

Requirements:

* macOS with Xcode 26.5 or later.
* iOS 26.5 or later.

Steps:

1. Download or clone this repository.
2. Open Ghibli Garden.xcodeproj in Xcode.
3. Select an iPhone simulator or compatible physical device.
4. Press Cmd + R to build and run the application.
5. Make sure you have an internet connection to load the movie information.

Project Structure

* Film.swift — Model containing movie information.
* FilmViewModel.swift — Handles API requests, data decoding, loading states, and errors.
* ContentView.swift — Displays the movie list and handles navigation.
* FilmDetailView.swift — Displays detailed information about the selected movie.
* Ghibli_GardenApp.swift — Main application entry point.
