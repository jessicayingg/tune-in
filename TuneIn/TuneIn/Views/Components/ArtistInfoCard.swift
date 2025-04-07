//
//  ArtistInfoCard.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-07.
//

import SwiftUI

struct ArtistInfoCard: View {
    let artist: Artist
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
            HStack {
                AsyncImage(url: URL(string: (artist.images?[0].url)!)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                } placeholder: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                        .frame(width: 80, height: 80)
                        .padding()
                }
                
                VStack(alignment: .leading) {
                    Text(artist.name)
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .padding(.leading, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
            .cornerRadius(5)
            .shadow(radius: 10)
        }
        
    }
}

#Preview {
    let dummyAlbumImage = AlbumImage(
        url: "https://i.scdn.co/image/ab6761610000e5ebe672b5f553298dcdccb0e676",
        height: 640,
        width: 640)
    let dummyArtist = Artist(
        id: "",
        name: "Taylor Swift",
        images: [dummyAlbumImage])
    
    return ArtistInfoCard(artist: dummyArtist)
}
