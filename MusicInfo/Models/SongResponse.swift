//
//  SongResponse.swift
//  MusicInfo
//
//  Created by Sergey Antoniuk on 1/21/21.
//

import Foundation

struct SongResponse: Decodable {
    let songs : [Song]
    
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}

struct Song: Decodable, Identifiable, Hashable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl = "artworkUrl60"
    }
}
