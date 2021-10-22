//
//  ViewController.swift
//  iOSAppLifeCycle
//
//  Created by Justin Bell on 10/14/21.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        print("1. In function loadView ----")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("2. In function viewDidLoad ----")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        print("3. In function viewWillAppear ----")
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        print("4. In function viewDidAppear ----")
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        print("5. in function viewWillDisappear ----")
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        print("6. In function viewDidDisappear ----")
//    }
//    deinit {
//        print("In deinit: Exiting from the class ----")
//    }
//
    
    @IBAction func nextViewOnTap(_ sender: UIButton) {
        let secondVC = SecondViewController()

       // present(secondVC, animated: true, completion: nil)
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

