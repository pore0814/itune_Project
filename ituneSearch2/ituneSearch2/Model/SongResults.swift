//
//  SongREsults.swift
//  ituneSearch2
//
//  Created by 王安妮 on 2018/7/5.
//  Copyright © 2018年 Annie. All rights reserved.
//

import Foundation


struct Song: Codable {
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl100: URL
    var releaseDate: String
    var collectionPrice: Double
    var trackPrice: Double
    var country: String
    var currency: String
    var previewUrl: URL
    var primaryGenreName: String
}

struct SongResults: Codable {
    
    var results: [Song]
}
