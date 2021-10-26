//
//  ViewController.swift
//  DelegatesAndProtocols
//
//  Created by Justin Bell on 10/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTapNextButton(_ sender: Any) {
        let nextView = storyboard?.instantiateViewController(withIdentifier: "SelectionView") as! SelectionViewController
        
        nextView.selectionDelegate = self
        
        present(nextView, animated: true, completion: nil)
    }
    
}


extension ViewController : nameSelectionDelegate {
    func didTapOnButton(inputName: String, colorOfText: UIColor) {
        myLabel.text = inputName
        myLabel.backgroundColor = colorOfText
    }
}
