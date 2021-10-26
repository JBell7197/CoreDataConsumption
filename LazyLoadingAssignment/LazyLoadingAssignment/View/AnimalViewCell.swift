//
//  AnimalViewCell.swift
//  LazyLoadingAssignment
//
//  Created by Justin Bell on 10/25/21.
//

import UIKit

class AnimalViewCell: UITableViewCell {

    @IBOutlet weak var animalImage: LazyLoading!
    @IBOutlet weak var animalName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
