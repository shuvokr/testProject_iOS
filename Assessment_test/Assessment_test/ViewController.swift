//
//  ViewController.swift
//  Assessment_test
//
//  Created by Shuvo on 15/3/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "goto_login", sender: self)
    }
}

