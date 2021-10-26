//
//  AnimalDetail.swift
//  LazyLoadingAssignment
//
//  Created by Justin Bell on 10/25/21.
//

import UIKit

class AnimalDetail: UIViewController, UICollectionViewDelegate {

    var imageFile : UIImage!
    var customView : UICollectionView!
    var titlePage : String!
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailViewSetup()
    }
    
    func detailViewSetup() {
        
        let imageView = UIImageView(image: imageFile)
        imageView.frame = CGRect(x: 20, y: 20, width: 200, height: 250)
        let frame = self.view.frame
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 60, height: 60)
        
        customView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        customView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AnimalDetailView")
        
        //Adding main image
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        label.center = CGPoint(x: frame.width/2 , y: frame.height/1.4)
        label.textAlignment = .center
        label.text = titlePage
        
        //Ading Image
    
        let detailImage = UIImageView(image: image!)
        detailImage.frame = CGRect(x: 0, y: 100, width: frame.width, height: frame.height/2)
        
        //Adding Subtitle
        let subLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 300, height: 50))
        subLabel.center = CGPoint(x: frame.width * 0.5, y: frame.height/1.1)
        subLabel.textAlignment = .center
        subLabel.text = "Image of \(titlePage!)"
        
        self.view.addSubview(customView ?? UICollectionView())
        self.view.addSubview(detailImage)
        self.view.addSubview(label)
        self.view.addSubview(subLabel)
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        customView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
