//
//  SelectionViewController.swift
//  DelegatesAndProtocols
//
//  Created by Justin Bell on 10/22/21.
//

import UIKit

//Protocol
protocol nameSelectionDelegate {
    func didTapOnButton(inputName: String, colorOfText: UIColor)
}

class SelectionViewController: UIViewController {

    
    @IBOutlet weak var inputTextField: UITextField!
    var selectionDelegate : nameSelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func updateText() {
        
        var textColor: UIColor!
        textColor = .yellow
        
        selectionDelegate.didTapOnButton(inputName: inputTextField.text ?? "No data", colorOfText: textColor)
        
        dismiss(animated: true, completion: nil)
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
