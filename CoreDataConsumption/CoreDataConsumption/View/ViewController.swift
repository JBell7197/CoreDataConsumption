//
//  ViewController.swift
//  CoreDataConsumption
//
//  Created by Justin Bell on 10/31/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
    
    
    @IBOutlet weak var myTableView : UITableView!
    
    var gameData : ControllerManager = ControllerManager()
    var game : [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        loadData()
      
    }
    
    func setUp(){
        myTableView.dataSource = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GameCell")
        
    }

    func loadData(){
        gameData.getData(completionHandler: {_game in
                    self.game = _game

                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.game.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        let gameObj = self.game[indexPath.row]
        cell.textLabel?.text = gameObj.title
        return cell
    }
}

