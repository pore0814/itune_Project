//
//  ViewController.swift
//  ituneSearch2
//
//  Created by 王安妮 on 2018/7/5.
//  Copyright © 2018年 Annie. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ituneSearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,NVActivityIndicatorViewable{
  
    var songsArray = [Song]()
    
  //  var songsResult =  [Song]()

    let userManager = UserManager()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var ituneTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       userManager.delegate = self
       
       configureTableView()
        
       configureSearchBar()
        
        
    }
    
    func configureSearchBar(){
        
        searchBar.delegate = self
        
        searchBar.placeholder = "輸入"
        
    }
    
    func configureTableView(){
        
        let nib = UINib(nibName: "ituneTableViewCell", bundle: nil)
        
        ituneTableView.register(nib, forCellReuseIdentifier: "ituneTableViewCell")
        
        ituneTableView.delegate = self
        
        ituneTableView.dataSource = self
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = ituneTableView.dequeueReusableCell(withIdentifier: "ituneTableViewCell") as? ituneTableViewCell else {return UITableViewCell()}
        
        cell.titleLabel.text = songsArray[indexPath.row].trackName //歌名
        
        cell.artistLabel.text = songsArray[indexPath.row].artistName  //歌手
        
        cell.genreLabel.text = songsArray[indexPath.row].primaryGenreName //類型
        
        guard let data = NSData(contentsOf: songsArray[indexPath.row].artworkUrl100) else {return UITableViewCell()}

        cell.songimageView?.image = UIImage(data: data as Data)
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        guard let songsDetailvc = storyboard?.instantiateViewController(withIdentifier: "SongsDetailViewController") as? SongsDetailViewController else {return}
        
        songsDetailvc.getData = songsArray[indexPath.row]
        
        present(songsDetailvc, animated: true, completion: nil)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        userManager.getData(keyWord:searchBar.text!)
        
        self.view.endEditing(true)
        
        
        let size = CGSize(width: 50, height: 50)
        
        NVActivityIndicatorView.DEFAULT_TYPE = .orbit
        
        startAnimating(size, message: "Loading...")
    
    }
}

extension ituneSearchViewController: UserManagerDelegate {
    
    func manager(_ manager: UserManager, didGet songs: [Song]) {
        
        songsArray = songs
        
        DispatchQueue.main.async {
            
             self.ituneTableView.reloadData()
            
             self.stopAnimating()
            
        }
       
    
    }
    
    
}

