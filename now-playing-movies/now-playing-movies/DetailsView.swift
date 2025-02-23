//
//  DetailsView.swift
//  now-playing-movies
//
//  Created by iris on 04/11/21.
//

import SwiftUI

struct DetailsView: View {
    
    private let movie: Movie
    init(movie: Movie){
        self.movie = movie
    }
    @StateObject var trailer = TrailerViewModel()
    
    var body: some View {
        VStack {
            ScrollView{
                HStack {
                    Text(movie.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                    
                    Spacer()
                }.padding(.horizontal)
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                } placeholder: {
                    ZStack{
                        Color.white.opacity(0)
                            .frame(height: 161.5)
                        Image(systemName: "photo")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .font(.system(size: 80))
                    }.aspectRatio(contentMode: .fit)
                }
                .cornerRadius(20)
                .padding(.horizontal)
                
                HStack {
                    Text("Rating:")
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                        .font(.system(size: 15))
                        .padding(.trailing, -5.0)
                    Text(String(movie.vote_average))
                    
                    Spacer()
                    Link(destination: URL(string: "https://www.youtube.com/watch?v=\(trailer.trailer.key)")!) {
                        Text("Play Trailer")
                            .foregroundColor(Color.black)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 2)
                            .background(Color.yellow.opacity(0.7))
                            .cornerRadius(10)
                    }
                }.padding()
                
                HStack {
                    Text(movie.overview)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding([.leading, .bottom, .trailing])
                
                Spacer()
            }
            
        }.onAppear{
            trailer.idMovie = movie.id
            trailer.fetchTrailer()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(movie: Movie(backdrop_path: "/eeijXm3553xvuFbkPFkDG6CLCbQ.jpg", overview: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.", release_date: "2021-09-30", id: 0, title: "Dune", vote_average: 8.2))
    }
}
