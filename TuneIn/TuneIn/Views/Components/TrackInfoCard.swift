//
//  TrackInfoCard.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-07.
//

import SwiftUI

struct TrackInfoCard: View {
    let track: Track
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: track.album.images[0].url)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.blue)
                    .frame(width: 50, height: 50)
                    .padding()
            }
            
            Text(track.name)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text(track.artists[0].name)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(width: 200, height: 250)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

#Preview {
    let dummyAlbumImage = AlbumImage(
        url: "https://i.scdn.co/image/ab67616d0000b27371d62ea7ea8a5be92d3c1f62",
        height: 640,
        width: 640)
    let dummyAlbum = Album(
        name: "HIT ME HARD AND SOFT",
        images: [dummyAlbumImage])
    let dummyArtist = Artist(
        id: "",
        name: "Billie Eilish",
        images: [dummyAlbumImage])
    let dummyTrack = Track(
        id: "",
        name: "Wildflower",
        artists: [dummyArtist],
        album: dummyAlbum
    )

    return TrackInfoCard(track: dummyTrack)
}
