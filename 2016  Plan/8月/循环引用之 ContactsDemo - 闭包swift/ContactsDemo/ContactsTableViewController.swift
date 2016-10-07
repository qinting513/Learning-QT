//
//  ContactsTableViewController.swift
//  ContactsDemo
//
//  Created by Qinting on 16/9/4.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

//  定义一个数组，并初始化
    var personList = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        网络加载，返回一个数组list
         loadData { (list) in
//            '拼接数组'，闭包中定义好的代码在需要的时候执行，需要self。语境
            self.personList += list
//            print(self.personList)
            self.tableView.reloadData()
        }
    }


//    MARK: - 加载数据  形参是个闭包  completion : (list:  [Person] ) ->( )
    func loadData( completion : (list:  [Person] ) ->( ) ) -> ( ) {
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
//            print("努力加载数据中。。。。")
//            初始化一个可变数组
            var arrM = [Person]()
//            制造数据
            for i in 0..<20{
            let p = Person()
                p.name = "hello--- \(i)"
                p.phone = "1860"+String(format: "%6d",arc4random_uniform(1000000))
                p.title = "swift版联系人"
                arrM.append(p)
            }
            
            dispatch_async(dispatch_get_main_queue(), { 
                completion(list: arrM)
            })
            
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let p = personList[indexPath.row]
        cell.textLabel?.text = p.name
        cell.detailTextLabel?.text = "\(p.phone!)--\(p.title!)"
        return cell
    }

     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("Edit", sender: indexPath)
        
    }
    
    @IBAction func addBtnClick(sender: AnyObject) {
        performSegueWithIdentifier("Edit", sender: nil)
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        类型强转  as? / as! 直接根据前面的返回值决定 是可选类型的用？
        let vc = segue.destinationViewController as! EditTableViewController
//        if let/ guard let 是判空语句，一律使用as?
        if let indexPath = sender as? NSIndexPath {
//            在这里面 indexPath必定有值
                  vc.p = personList[indexPath.row]
            
//            编辑完成的闭包  竟然不用传值回去
            vc.completionCallBack = {
                       self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }else{  // 新建个人用户
            
//            vc.completionCallBack = {
//                guard let p = vc?.p else{
//                    return
//                }
//                self.personList.insert(p, atIndex: 0)
//                self.tableView.reloadData()
//            }
            
//            注意vc要弱化，下面的要用问号， 否则循环引用,这个循环引用很隐蔽
            vc.completionCallBack = {   [weak vc] in
                guard let p = vc?.p else{
                    return
                }
                self.personList.insert(p, atIndex: 0)
                self.tableView.reloadData()
            }
        }
    }
    
    
}
