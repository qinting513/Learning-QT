//
//  ViewController.swift
//  CoreDataSw
//
//  Created by Qinting on 16/5/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    var context : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     let  context = NSManagedObjectContext.init()
    let model = NSManagedObjectModel.mergedModelFromBundles(nil)
        
       let  docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
     let sqlPath =  docPath?.stringByAppendingString("/company.sqlite")
        
        let store = NSPersistentStoreCoordinator.init(managedObjectModel: model!)
        let url = NSURL.fileURLWithPath(sqlPath!)
        do {
            try   store.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch _ {
  
        }
     context.persistentStoreCoordinator = store
      self.context = context

    }

    @IBAction func insertData(sender: AnyObject) {
        let emp = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: context!) as! Employee
        emp.name = "zhangsan"
        emp.age = 126
        do{
            try context!.save()
            print("成功插入")
        } catch let error as NSError {
            print(error)
        }
    }
    

    @IBAction func queryData(sender: AnyObject) {
        let fetch = NSFetchRequest.init(entityName: "Employee")
      
        do {
            let emps : [AnyObject] =  try  context!.executeFetchRequest(fetch)
            for emp  in emps  as!  [Employee] {
                print("name:\(emp.name!)   age: \(emp.age!)")
            }
        }catch let error as NSError {
        print("error:\( error)")
        }
    
    }
    
}

