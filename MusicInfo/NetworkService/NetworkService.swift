//
//  NetworkService.swift
//  MusicInfo
//
//  Created by Sergey Antoniuk on 1/21/21.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class NetworkService {
    
    func getSong(song: String, completion: @escaping (Result<[Song], NetworkError>) -> Void) {
       
        guard let url = URL.urlForSong(song) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let songResponse = try? JSONDecoder().decode(SongResponse.self, from: data)
            if let songResponse = songResponse {
                completion(.success(songResponse.songs))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
