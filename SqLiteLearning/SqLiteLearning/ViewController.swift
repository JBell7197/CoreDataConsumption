//
//  ViewController.swift
//  SqLiteLearning
//
//  Created by Justin Bell on 10/25/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController { //UITableViewDataSource {
   
    //IBOutlets for 3 text fields in Main
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var idField: UITextField!
    
    
    //    @IBOutlet var personTable: UITableView!
    
    
    var persons:[Person] = [] //array used to hold data from the read func in DBHelper
    var db:DBHelper = DBHelper()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        personTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
//        personTable.dataSource = self
        
//        db.insert(id: 1, name: "Swift", age: 7)
//        db.insert(id: 2, name: "Objective-C", age: 25)
//        db.insert(id: 3, name: "SwiftUI", age: 2)
//        persons = db.read()
    }

    @IBAction func saveAndMore(_ sender: UIButton) {
        
        let userId = (idField.text! as NSString).integerValue
        let userAge = (ageField.text! as NSString).integerValue
        let userName = nameField.text ?? "No name"

        db.insert(id: userId, name: userName, age: userAge)
      
//        db.deleteById(id: 111)
        let secondView = SecondTableTableViewController()
        present(secondView, animated: true, completion: nil)
    }
    //Tableview Datasource Methods
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return persons.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
//
//        cell.textLabel?.text = "Name : " + persons[indexPath.row].name + "  " + String(persons[indexPath.row].age)
//
//        return cell
//    }

}

//Class for defining the input fields for the app
class Person {
    var name : String = ""
    var age : Int = 0
    var id : Int = 0
    
    init (id: Int, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}




//Create DB helper class which holds various functions used for the database itself. This class holds a function that will open the database, create the table that will hold the data in the database, insert data into the table that is used for holding data in the database, read the table's contents, and delete data in the table using a parameter to pull that specific data.
class DBHelper {
    
    init() {
        db = openDatabase()
        createTable()
    }
    
    //***************ASK (where does the string come from?) i believe it comes from the title of database you want to create****************
    //Used as the holder of the path name to the sql table
    let dbPath : String = "LearningDB.sqlite"
    
    //Opaque pointers are used to represent C pointers. *******Find out what are C pointers***********
    var db:OpaquePointer?
    
    
    
    //func 'openDatabase' is used to open the database where the table will be created in and the data will be put in.
    //It consists of a variable for the URL of the file and a 'sqlite3_open' func which opens the SQLite database.
    //The 'if' and 'else' statements are used to check if the sqlite databases has actually been opened.
    func openDatabase () -> OpaquePointer? {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        print(fileURL)
        //var db:OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening DB")
            return nil
        }
        else {
            print("Successfully opened connection at \(dbPath)")
            return db
        }
    }
    
    //func 'createTable' is used to create the table that will be displayed in the sqlite database.
    //It consists of a query variable, a statement variable as 'nil', a 'sqlite_prepare_v2' func, a 'sqlite3_step' func, and a 'sqlite3_finalize' func.
    //if and else statement are used to check if the table was ever created
    func createTable () {
        
        let createTableQuery = "CREATE TABLE IF NOT EXISTS person (Id INTEGER PRIMARY KEY, name TEXT, age INTEGER);"
        var createTableStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Person table created!!!!")
            }
            else {
                print("Not able to create a person table.")
            }
        }
        else {
            print("Create table failed could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Insert data in to table
    //this func consist of a query variable, a statement variable, three sqlite_bind funcs, sqlite3_step func, and a sqlite3_finalize func
    func insert(id:Int, name:String, age:Int) {
        
        let insertQuery = "INSERT INTO person (Id, name, age) VALUES (?, ?, ?);"
        var insertStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(age))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row")
            }
            else {
                print("Could not insert record")
            }
        }
        else {
            print("Insert statement failed.....")
        }
        
        sqlite3_finalize(insertStatement)
    }
    
    //Read table
    //uses a while statement for cycling through the data in the table and an array to append the values that need to be read from the table.
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person"
        var queryStatment : OpaquePointer? = nil
        var psns : [Person] = [] //an array used for reading
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatment, nil) == SQLITE_OK {
            
            //goes through row until row is done
            while sqlite3_step(queryStatment) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatment, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatment, 1)))
                let age = sqlite3_column_int(queryStatment, 2)
                
                //appends values from the table into the array
                psns.append(Person(id: Int(id), name: name, age: Int(age)))
                print("Query results : ---")
                print("\(id) | \(name) | \(age)")
            }
        }
        else {
            print("Operation failed")
        }
        sqlite3_finalize(queryStatment)
        return psns
    }
    
    //func used to delete data from the table which takes an Int as a parameter. The data deleted will depend on the primary key which is the id for this example.
    //consists of query var, statement variable, variou
    func deleteById(id:Int) {
        let deleteQuery = "DELETE FROM person WHERE Id = ?;"
        var deleteStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully Deleted")
            }
            else {
                print("Could not delete")
            }
        }
        else {
            print("Delete statement failed.")
        }
        sqlite3_finalize(deleteStatement)
    }
}
