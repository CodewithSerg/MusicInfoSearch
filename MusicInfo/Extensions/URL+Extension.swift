//
//  URL+Extension.swift
//  MusicInfo
//
//  Created by Sergey Antoniuk on 1/21/21.
//

import Foundation


extension URL {
    
    static func urlForSong(_ song: String)-> URL? {
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(song)&entity=song") else {
            return nil
        }
        return url
    }
}
