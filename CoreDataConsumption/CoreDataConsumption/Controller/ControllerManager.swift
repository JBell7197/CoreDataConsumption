//
//  ControllerManager.swift
//  CoreDataConsumption
//
//  Created by Justin Bell on 11/2/21.
//

import Foundation

struct ControllerManager {
    func getData (completionHandler:@escaping ([Game]) -> Void){
        let gamePowerUrl = URL(string: "https://www.gamerpower.com/api/giveaways")!
       let task = URLSession.shared.dataTask(with: gamePowerUrl, completionHandler: {(data, response, error) in
           if error != nil || data == nil {
               print("Error---- \(String(describing: error?.localizedDescription))")
           }
                do{
                    let result = try JSONDecoder().decode([Game].self, from: data!)
                    completionHandler(result)
                }
                catch let error{
                    print(error)
                }
       
        })
        task.resume()
    }
}
