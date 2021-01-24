//
//  String+Extensions.swift
//  MusicInfo
//
//  Created by Sergey Antoniuk on 1/22/21.
//

import Foundation

extension String {
    func escaped ()-> String?{
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
}
