//
//  ContentView.swift
//  Ghibli Garden
//
//  Created by María Fernanda Espinosa Vásquez on 07/10/26.
//


import SwiftUI

struct ContentView: View {
    
    @State var FilmVM = FilmViewModel()
    
    private let backgroundColor = Color(red: 1.0, green: 0.98, blue: 0.97)
    private let pinkColor = Color(red: 0.72, green: 0.42, blue: 0.51)
    private let textColor = Color(red: 0.28, green: 0.30, blue: 0.27)
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                backgroundColor.ignoresSafeArea()
                
                Group {
                    if FilmVM.isLoading {
                        
                        // Loading
                        ProgressView("Loading movies...")
                        
                    } else if let errorMessage = FilmVM.errorMessage {
                        
                        // Error
                        VStack(spacing: 16) {
                            Image(systemName: "wifi.exclamationmark")
                                .font(.largeTitle)
                                .foregroundStyle(pinkColor)
                            
                            Text(errorMessage)
                                .multilineTextAlignment(.center)
                            
                            Button("Retry") {
                                Task {
                                    await FilmVM.getFilms()
                                }
                            }
                            .tint(pinkColor)
                        }
                        .padding()
                        
                    } else {
                        
                        // Movie list
                        List {
                            ForEach(FilmVM.arrFilms) { item in
                                
                                NavigationLink {
                                    FilmDetailView(film: item)
                                } label: {
                                    
                                    HStack(spacing: 16) {
                                        
                                        AsyncImage(url: URL(string: item.image ?? "")) { phase in
                                            switch phase {
                                                
                                            case .empty:
                                                ProgressView()
                                                
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .accessibilityLabel("Poster of \(item.title)")
                                                
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .font(.largeTitle)
                                                    .foregroundStyle(.gray)
                                                    .accessibilityLabel("Poster unavailable")
                                                
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        .frame(width: 105, height: 145)
                                        .background(
                                            Color(red: 0.97, green: 0.91, blue: 0.93)
                                        )
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 14)
                                        )
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            
                                            Text(item.title)
                                                .font(.headline)
                                                .foregroundStyle(textColor)
                                            
                                            Text(item.director)
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                            
                                            Text(item.releaseDate)
                                                .font(.caption.bold())
                                                .foregroundStyle(pinkColor)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(
                                                    pinkColor.opacity(0.12),
                                                    in: Capsule()
                                                )
                                        }
                                        
                                        Spacer(minLength: 0)
                                    }
                                    .padding(12)
                                    .background(
                                        Color.white,
                                        in: RoundedRectangle(cornerRadius: 20)
                                    )
                                    .shadow(
                                        color: pinkColor.opacity(0.10),
                                        radius: 8,
                                        x: 0,
                                        y: 4
                                    )
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(
                                    EdgeInsets(
                                        top: 8,
                                        leading: 16,
                                        bottom: 8,
                                        trailing: 16
                                    )
                                )
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Ghibli Garden")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await FilmVM.getFilms()
        }
    }
}

#Preview {
    ContentView()
}

