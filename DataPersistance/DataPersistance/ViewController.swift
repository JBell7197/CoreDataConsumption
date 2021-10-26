//
//  ViewController.swift
//  DataPersistance
//
//  Created by Justin Bell on 10/25/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //userDefaults()
        //fetchDataFromPlist()
        fetchDataFromFile()
    }

    // User defaults:
    
    func userDefaults () {
        let defaults = UserDefaults.standard
        
        //Store value in defaults
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UserTouchId")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        //Retrieve from userdefaults
        //print("User defaults stored values ------> \(defaults.value(forKey: "Pi"))")
        
        let array = ["Hello", "Swift"]
        
        defaults.set(array, forKey: "SavedArray")
        
        print("User defaults stored values ------> \(defaults.value(forKey: "Age") ?? 0)")
        
        
    }

    
    //Plist
    
    func fetchDataFromPlist () {
        let plistData = Bundle.main.infoDictionary!["MyCustomDictionary"]
        print("Plist contents ----> \(plistData)")
    }
    
    
    //Filemanager
    
    func fetchDataFromFile () {
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        else{
            return
        }
        print("Path ----> \(url)")
        
        
        //Cereate a directory
        let newFolderPath = url.appendingPathComponent("iOS-Learning")
        
        do {
            try manager.createDirectory(atPath: newFolderPath.path, withIntermediateDirectories: true, attributes: [:])
        }
        catch {
            print(error)
        }
        
        //Create a file
        
        let filePath = newFolderPath.appendingPathComponent("TestFile.txt")
        let newText = "Writing some test data to the file locally!!!".data(using: .utf8)
        
        manager.createFile(atPath: filePath.path, contents: newText, attributes: [FileAttributeKey.creationDate:Date()])
        
        print("File path -----> \(filePath)")
    
        //Delete a file
        
        
        if (manager.fileExists(atPath: filePath.path)) {
            print("Deleting a file ------------")
            
            do {
                try manager.removeItem(atPath: filePath.path)
            }
            catch {
                print(error)
            }
        }
    }
}

