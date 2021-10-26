//
//  ViewController.swift
//  CoreDataSample
//
//  Created by Justin Bell on 10/26/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createEmployee()
        fetchEmployeeRecords()
    }


    func createEmployee () {
        let employee = Employee(context: PersistentStorage.shared.context)
        employee.name = "Prab"
        employee.address = "101 Station"
        PersistentStorage.shared.saveContext()
    }
    
    func fetchEmployeeRecords () {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path[0])
        
        do {
            guard let results = try PersistentStorage.shared.context.fetch(Employee.fetchRequest()) as? [Employee] else {
                return
            }
            results.forEach({debugPrint($0.name ?? "No Name", $0.address ?? "No Address")})
        }
        catch {
            print(error)
        }
    }
}

