//
//  SecondTableTableViewController.swift
//  SqLiteLearning
//
//  Created by Justin Bell on 10/26/21.
//

import UIKit

class SecondTableTableViewController: UITableViewController {

    var persons:[Person] = []
    var db:DBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        tableView.dataSource = self
        
        //get data from database
        persons = db.read()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "Name : " + persons[indexPath.row].name + ", " + "Age: " + String(persons[indexPath.row].age) + " " + "Id: " + String(persons[indexPath.row].id)
        // Configure the cell...

        return cell
    }
    

   

}
