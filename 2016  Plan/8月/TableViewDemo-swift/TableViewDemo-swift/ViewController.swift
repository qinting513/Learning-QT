//
//  ViewController.swift
//  TableViewDemo-swift
//
//  Created by Qinting on 16/9/4.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }

     func setupUI() {
        //创建tableView
      let tv = UITableView(frame: view.bounds, style: .plain)
        // 添加到视图
        view.addSubview(tv);
        //注册cell 可重用 [UITableViewCell class]
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //设置datasource  >> 遵守协议，才不报错 > 遵守后 要实现必须实现的方法才不报错
        tv.dataSource = self
    }
    
    //MARK:  DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        text Label是可选的 ，如果textLabel有则使用 若没有则什么都不做
        cell.textLabel?.text = "hello ---\((indexPath as NSIndexPath).row)"
        return cell
    }


}

