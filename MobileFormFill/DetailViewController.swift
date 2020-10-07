//
//  DetailViewController.swift
//  MobileFormFill
//
//  Created by Manali Rami on 2020-10-06.
//  Copyright © 2020 Manali Rami. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController {
    
    var dataList = [DataForm]()
   private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var detailTableView: UITableView!
    
     override func viewDidLoad() {
       super.viewDidLoad()
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! DetailViewCell
        cell.fullNameText.text = dataList[indexPath.row].fullName
        cell.emailText.text = dataList[indexPath.row].email
        cell.genderText.text = dataList[indexPath.row].gender
        cell.skillSetText.text = dataList[indexPath.row].skills
        
        return cell
    }
    
    func loadData() {
        do {
            dataList = try context.fetch(DataForm.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    }
