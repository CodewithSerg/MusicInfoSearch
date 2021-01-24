//
//  MusicViewModel.swift
//  MusicInfo
//
//  Created by Sergey Antoniuk on 1/22/21.
//

import Foundation

class MusicViewModel: ObservableObject {
    
    enum LoadingState {
        case none
        case loading
        case success
        case failed
    }


    
        
        @Published var songs: [Song] = []
        @Published var message: String = ""
        @Published var loadingState: LoadingState = .none
        @Published var song = ""
        
        
        
//        var humidity: String {
//            guard let humidity =  weather?.humidity else {
//                return "N/A"
//            }
//            return String(format: "%.0F %%", humidity)
//                
//            }
//        var trackName:String{
//            guard let trackName = songs[0]?.trackName else {
//                return "N/A"
//            }
//            return String(trackName)
//        }
        
        
        func fetchSong(song: String) {
            
            guard let song = song.escaped() else {
                DispatchQueue.main.async {
                    self.message = "City is incorrect"
                }
                return
            }
            
            self.loadingState = .loading
            
            NetworkService().getSong(song: song) { result in
                switch result {
                
                case.success(let songs):
                    
                    DispatchQueue.main.async {
                        self.songs = songs
                        self.loadingState = .success
                    }
                    
                case .failure(_ ):
                    DispatchQueue.main.async {
                        self.message = "Unable to find the weather"
                        self.loadingState = .failed
                    }
                   
                }
            
            }
        }
    }

    

