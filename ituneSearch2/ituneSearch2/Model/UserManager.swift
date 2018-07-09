//
//  UserManager.swift
//  ituneSearch2
//
//  Created by 王安妮 on 2018/7/5.
//  Copyright © 2018年 Annie. All rights reserved.
//

import Foundation

protocol UserManagerDelegate:class {
    
    func manager(_ : UserManager, didGet songs:[Song])
}


class UserManager {
    
    weak var delegate : UserManagerDelegate?
    
    func  getData(keyWord:String){
        
    var songs = [Song]()
    
    let urlStr = "https://itunes.apple.com/search?term=\(keyWord)&media=music".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let url = URL(string: urlStr!)
    let task = URLSession.shared.dataTask(with: url!) { (data, res, err) in
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let data = data, let songResults = try? decoder.decode(SongResults.self, from: data) {
            for song in songResults.results {
                songs.append(song)
                print(songs)
            }
        } else {
            print("error")
        }
        self.delegate?.manager(self, didGet: songs)
    }
    task.resume()
    }
    
    
    
    
    
}
