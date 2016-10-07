//
//  EditTableViewController.swift
//  ContactsDemo
//
//  Created by Qinting on 16/9/4.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {

    var p : Person?
    
//    返回值是可选类型
//     var completionCallBack : () -> ()?
    
//    闭包是可选类型
      var completionCallBack : ( () -> () )?
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(EditTableViewController.saveAction))
   
        if p != nil {
            nameTF.text =  p?.name
            phoneTF.text = p?.phone
            titleTF.text = p?.title
        }
    }
    func saveAction(){
        if p == nil {  //判断如果是空 则新建一个
        p = Person()
        }
        
        p?.name = nameTF.text
        p?.phone = phoneTF.text
        p?.title = titleTF.text
//        执行闭包回调
//        OC中执行block前都必须判断是否有值，否则容易崩溃
//        ？ 可选解包 闭包为nil则什么都不做   ！ 强行解包
        completionCallBack?( )
        self.navigationController?.popViewControllerAnimated(true)
    }

    deinit{
    print("死了")
    }

}
