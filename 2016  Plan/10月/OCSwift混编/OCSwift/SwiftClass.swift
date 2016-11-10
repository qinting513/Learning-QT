//
//  SwiftClass.swift
//  OCSwift
//
//  Created by Qinting on 2016/11/9.
//  Copyright © 2016年 QT. All rights reserved.
//

import UIKit

class SwiftClass: NSObject {

    
    func returnSwiftName() ->String{
         let vc = ViewController()
        vc.getOneMethodForSwift()
        return "欢迎使用swift语言！！！"
    }
    
    
}
