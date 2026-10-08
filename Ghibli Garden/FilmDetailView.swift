//
//  FilmDetailView.swift
//  Ghibli Garden
//
//  Created by María Fernanda Espinosa Vásquez on 07/10/26.
//

import SwiftUI

struct FilmDetailView: View {
    
    var film: Film
    
    private let backgroundColor = Color(red: 1.0, green: 0.98, blue: 0.97)
    private let pinkColor = Color(red: 0.72, green: 0.42, blue: 0.51)
    private let textColor = Color(red: 0.28, green: 0.30, blue: 0.27)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Movie poster
                AsyncImage(url: URL(string: film.image ?? "")) { phase in
                    switch phase {
                        
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 320)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 320)
                            .frame(maxWidth: .infinity)
                            .accessibilityLabel("Poster of \(film.title)")
                        
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity)
                            .frame(height: 320)
                            .accessibilityLabel("Poster unavailable")
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    Color(red: 0.97, green: 0.91, blue: 0.93),
                    in: RoundedRectangle(cornerRadius: 22)
                )
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .padding(.horizontal, 20)
                
                // Movie information
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(film.title)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(textColor)
                    
                    Text(film.director)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    // Movie details
                    HStack(spacing: 10) {
                        
                        Label(film.releaseDate, systemImage: "calendar")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                pinkColor.opacity(0.12),
                                in: Capsule()
                            )
                        
                        Label("\(film.runningTime) min", systemImage: "clock")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                pinkColor.opacity(0.12),
                                in: Capsule()
                            )
                    }
                    .font(.caption.bold())
                    .foregroundStyle(pinkColor)
                    
                    Divider()
                    
                    Text(film.description)
                        .font(.body)
                        .foregroundStyle(textColor)
                        .lineSpacing(5)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color.white,
                    in: RoundedRectangle(cornerRadius: 22)
                )
                .padding(.horizontal, 20)
                
            }
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(backgroundColor.ignoresSafeArea())
        .navigationTitle(film.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

