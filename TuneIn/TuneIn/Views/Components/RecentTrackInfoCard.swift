//
//  TrackInfoCard.swift
//  TuneIn
//
//  Created by Jessica Ying on 2025-04-07.
//

import SwiftUI

struct RecentTrackInfoCard: View {
    let recentTrack: RecentTrack
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recentTrack.track.album.images[0].url)) { image in
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
                Text(recentTrack.track.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(recentTrack.track.artists[0].name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 10)
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
    let dummyRecentTrack = RecentTrack(
        track: dummyTrack,
        played_at: "Yesterday"
    )

    return RecentTrackInfoCard(recentTrack: dummyRecentTrack)
}
