//
//  LazyLoading.swift
//  LazyLoadingAssignment
//
//  Created by Justin Bell on 10/25/21.
//


import UIKit

class LazyLoading : UIImageView {
    
    let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(fromUrl imageURL : URL, placeHolderImage : String){
        self.image = UIImage(named: placeHolderImage)
        
        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject){
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL){
                
                if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
