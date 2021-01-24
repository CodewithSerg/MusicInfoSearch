//
//  ContentView.swift
//  MusicInfo
//
//  Created by Sergey Antoniuk on 1/21/21.
//

import SwiftUI

struct ContentView: View {
   
       
//        @ObservedObject var networkManager = SearchViewModel()
    @ObservedObject var networkManager = MusicViewModel()
        
        var body: some View {
            NavigationView{
                VStack{
                TextField("Type a song, artist, or album name... ", text: $networkManager.song, onEditingChanged: {_ in}, onCommit: {networkManager.fetchSong(song: networkManager.song)}).textFieldStyle(RoundedBorderTextFieldStyle())
                              .padding()
                              .background(Color(.systemGray4))
                              .padding(.horizontal, 8)
                              .cornerRadius(15)
//                                  .onTapGesture(perform: {
//                                      networkManager.isSeaching = true
//                                  })
//                                  .overlay(
//                                      HStack{
//                                          Spacer()
//                                          if networkManager.isSeaching{
//                                              Button(action: {
//                                                  networkManager.searchText = ""
//
//                                                  //switchoff keyboard
////                                                  UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//
//                                              }, label: {
//                                                  Image(systemName: "xmark.circle.fill")
//                                                      .scaleEffect(1.5)
//                                                      .foregroundColor(.gray)
//
//
//                                              })
//
//                                          }
//                                      }.padding()
//                                  )
                
                Text("SwiftUI")
                    
                    List(networkManager.songs, id:\.self){song in
                    
                    VStack(alignment: .leading){
                        Text(song.trackName)
                        Text(song.artistName)
                            }
                        }
                    
                .navigationBarTitle("Number of songs \(networkManager.songs.count)")
            }
//            .onAppear(perform: {
//                self.networkManager.fetchData(song: "coldplay")
//            })
        }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class SearchViewModel : ObservableObject {
    
    @Published var songs = [Song]()
    @Published var searchText = ""
    @Published var isSeaching = false
    
    func fetchData(song: String) {
        if let url = URL(string: "https://itunes.apple.com/search?term=\(song)&entity=song") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let safeData = data {
                        do {
                        let results = try JSONDecoder().decode(SongResponse.self, from: safeData)
                            DispatchQueue.main.async {
                                self.songs = results.songs
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                                       
                }
            }
            task.resume()
        }
    }
}


