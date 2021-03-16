//
//  ProfileViewController.swift
//  Assessment_test
//
//  Created by Shuvo on 15/3/21.
//

import UIKit

class ProfileViewController: UIViewController {
    struct UserModel {
        var name : String?
        var username : String?
        var phone : String?
    }
    var userModel = UserModel()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameLabel.text = "Name: \(self.userModel.name!)"
        self.usernameLabel.text = "Username: \(self.userModel.username!)"
        self.phoneLabel.text = "Phone: \(self.userModel.phone!)"
    }
    @IBAction func goPrevAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
