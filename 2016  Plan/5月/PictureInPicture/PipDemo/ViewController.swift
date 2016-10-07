//
//  ViewController.swift
//  PipDemo
//
//  Created by Qinting on 16/6/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

var currentItemStatus = "currentItem.status"
var mcontext = 0
class ViewController: UIViewController,AVPictureInPictureControllerDelegate {

    @IBOutlet var pipView: PipVideoPlay!
    
    lazy var player:AVPlayer = {
     let p = AVPlayer()
        p.addObserver(self, forKeyPath: currentItemStatus, options: .New, context: &mcontext)
        return p
    }()
    
    override func viewDidLoad() {
        let u  = NSBundle.mainBundle().URLForResource("video", withExtension: ".mov")
        let asset = AVAsset(URL: u!)
        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItemWithPlayerItem(item)
        pipView.pipPlayerPlay = player
        player.play()
    }

    var pipController : AVPictureInPictureController?
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == currentItemStatus {
            let statusInt = change?[NSKeyValueChangeNewKey] as? NSNumber
            let status = AVPlayerItemStatus(rawValue: statusInt!.integerValue)
            
            if status !=  .ReadyToPlay {
                return
            }
            pipController = AVPictureInPictureController(playerLayer: pipView.pipLayer)
            pipController?.delegate = self;
        }
    }
    
    func pictureInPictureControllerWillStartPictureInPicture(pictureInPictureController: AVPictureInPictureController){
    print("Will Start")
    }
    
    func pictureInPictureControllerDidStartPictureInPicture(pictureInPictureController: AVPictureInPictureController){
     print("Did Start")
    }

    func pictureInPictureController(pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: NSError){
     print("failedToStart:%@",error)
    }

}

