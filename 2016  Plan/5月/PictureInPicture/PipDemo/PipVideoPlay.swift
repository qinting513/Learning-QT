//
//  PipVideoPlay.swift
//  PipDemo
//
//  Created by Qinting on 16/6/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PipVideoPlay:UIView{

    override class func layerClass() ->AnyClass{
        return AVPlayerLayer.self
    }
    
    var pipLayer:AVPlayerLayer{
    return layer as! AVPlayerLayer
    }

    /** 定义一个播放器 */
    var pipPlayerPlay:AVPlayer{
        get{
        return pipLayer.player!
        }
        set{
        pipLayer.player = newValue
        }
    }
    
}