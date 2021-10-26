//
//  ViewController.swift
//  LazyLoadingAssignment
//
//  Created by Justin Bell on 10/25/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
   
    

    var myTableView : UITableView = UITableView()
    var animalData : AnimalNetworkManager = AnimalNetworkManager()
    var animal:[Animal]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        loadDataOnView()
    }

    func setupUI () {
        self.view.addSubview(myTableView)
        myTableView.dataSource = self
        let customNib = UINib(nibName: "AnimalViewCell", bundle: nil)
        myTableView.register(customNib, forCellReuseIdentifier: "AnimalCell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func loadDataOnView() {
        animalData.getAnimals(completionHandler: {(_animalData) in
            if (_animalData?.animals != nil) {
                self.animal = _animalData?.animals
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
            
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animal?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalViewCell
        
        let animalObj = animal?[indexPath.row]
        
        cell.animalName.text = animalObj?.name
        
        let animalImageUrl = URL(string: (animalObj?.image)!)!
        //let animalImageData = try? Data(contentsOf: animalImageUrl)
        //cell.animalImage.image = UIImage(data: animalImageData!)
        
        cell.animalImage.loadImage(fromUrl: animalImageUrl, placeHolderImage: "previewImage")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextPage = AnimalDetail()
        let animalObj = animal?[indexPath.row]
        let animalImageUrl = URL(string: (animalObj?.image)!)!
        let animalImageData = try? Data(contentsOf: animalImageUrl)
        nextPage.titlePage = animalObj?.name
        nextPage.image = UIImage(data: animalImageData!)
        self.navigationController?.pushViewController(nextPage, animated: true)
    }
}

