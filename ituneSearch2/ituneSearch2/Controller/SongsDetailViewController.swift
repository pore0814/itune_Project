//
//  SontsDetailViewController.swift
//  ituneSearch2
//
//  Created by 王安妮 on 2018/7/5.
//  Copyright © 2018年 Annie. All rights reserved.
//

import UIKit
import AVFoundation
import NVActivityIndicatorView



class SongsDetailViewController: UIViewController,NVActivityIndicatorViewable {
    
  
    
    var getData:Song? = nil
    
    var seconds:Float64 = 0
    
    //播放器相关
    var playerItem:AVPlayerItem?
    
    var player:AVPlayer?
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var muteBtn: UIButton!
    
    @IBOutlet weak var playBackSlider: UISlider!
    
    @IBOutlet weak var playTimeLabel: UILabel!

    @IBOutlet weak var videoLengthLabel: UILabel!
    
    @IBOutlet weak var songsCoverImageView: UIImageView!
    
    @IBOutlet weak var articleNameLabel: UILabel!
    
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    @IBOutlet weak var trackNameLbel: UILabel!
    
    @IBOutlet weak var cdCenter: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showData()
      
        setAVplayer()
      
        playMusic()
        
        cdCenter.setRounded()

    }
    
    
    @IBAction func backPreviousBtn(_ sender: Any) {
      
            self.player?.pause()
        
            self.player = nil
        
            dismiss(animated: true, completion: nil)
        
    }
    
    func showData(){
        
        guard let getdata = getData else {return}
        
        articleNameLabel.text = getdata.artistName
        
        collectionNameLabel.text = getdata.collectionName
        
        trackNameLbel.text = getdata.trackName
        
        guard  let data = NSData(contentsOf: getdata.artworkUrl100) else {return}
        
        songsCoverImageView.image = UIImage(data: data as Data)
        
    }
    
    
    func setAVplayer(){
        
        guard let getdata = getData else {return}

        playerItem = AVPlayerItem(url: getdata.previewUrl)
        
        player = AVPlayer(playerItem: playerItem!)
        
    }
    
    func playMusic(){
        
        if let duration = player?.currentItem?.asset.duration {
            
          
            seconds = CMTimeGetSeconds(duration)
            
            let secondsText = Int(seconds) % 60
            
            let minutesText = String(format: "%02d", Int(seconds)/60)
            
            videoLengthLabel.text = "\(minutesText):\(secondsText)"
            
            // track player progress
            
            let interval = CMTime(value: 1, timescale: 2)
            
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
               var second = CMTimeGetSeconds(progressTime)
                
                print("progressTime",second)
                
                let secondsString = String(format: "%02d", Int(second) % 60)
                
                let minutesString = String(format: "%02d", Int(second) / 60)
                
                self.playTimeLabel.text = "\(minutesString):\(secondsString)"
                
                guard let currentItem = self.player?.currentItem else {return}
                
                self.playBackSlider.maximumValue = Float(currentItem.duration.seconds)
                
                self.playBackSlider.minimumValue = 0
                
                self.playBackSlider.value = Float(currentItem.currentTime().seconds)
            
                if self.seconds == second {

                    self.stopRotate()

                }
        
            })
            
        }
    }
    

    
    func rotate() {
        
        
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 5;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        self.coverImage.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
    }
    
    func stopRotate(){
        self.coverImage.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    
    
    @IBAction func playBtn(_ sender: UIButton) {

     sender.isSelected = !sender.isSelected
        
        sender.isSelected ? player?.play() : player?.pause()
        
        sender.isSelected ? playBtn.setImage(UIImage(named: "stop"), for: .normal) : playBtn.setImage(UIImage(named: "play_button"), for:.normal)
        
        sender.isSelected ? rotate() : stopRotate()
        
       
    }
    
    @IBAction func muteBtn(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        player?.isMuted = sender.isSelected
        
        
        sender.isSelected ? muteBtn.setImage(UIImage(named: "volume_off"), for: .normal) : muteBtn.setImage(UIImage(named: "volume_up"), for:.normal)
        
    }
    
    
    @IBAction func fastForwardBtn(_ sender: Any) {
        
        
        
        guard let duration = player?.currentItem?.duration else {return}
        let currentTime = CMTimeGetSeconds((player?.currentTime())!)
        let newTime = currentTime + 3.0
        
        if newTime < (CMTimeGetSeconds(duration) - 3.0)  {
            let time :  CMTime = CMTimeMake(Int64(newTime * 1000),1000)
            player?.seek(to: time)
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        let currentTime = CMTimeGetSeconds((player?.currentTime())!)
        var newTime = currentTime - 3.0
        
        if newTime < 0 {
            newTime = 0
        }
        
        let time :  CMTime = CMTimeMake(Int64(newTime * 1000),1000)
        player?.seek(to: time)
        print(time)
        
    }
    
    
    
    
}
    
    

   


