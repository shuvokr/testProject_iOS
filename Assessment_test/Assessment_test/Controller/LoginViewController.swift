//
//  LoginViewController.swift
//  Assessment_test
//
//  Created by Shuvo on 15/3/21.
//

import UIKit
import CoreData
extension String {
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return self.filter {okayChars.contains($0) }
    }
}
class LoginViewController: UIViewController {
    
    struct UserModel {
        var name : String?
        var username : String?
        var phone : String?
    }
    private var userModel = UserModel()

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginAction(_ sender: UIButton) {
        self.authRequestProcess(entity: "Users")
    }
    @IBAction func registrationAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goto_registration_page", sender: self)
    }
    private func authRequestProcess(entity : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let username = data.value(forKey: "userName") as? String
                let password = data.value(forKey: "password") as? String
                if username != self.userNameTextField.text! || password != self.passwordTextField.text! {
                    self.showWarnings(title: "Login failed", alertMessage: "Wrong username or password, try again.")
                }
                else {
                    // login successful
                    self.userNameTextField.text = nil
                    self.passwordTextField.text = nil
                    self.userModel = UserModel(name: data.value(forKey: "fullName") as? String, username: username, phone: data.value(forKey: "phone") as? String)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "goto_dashboard", sender: self)
                    }
                }
            }
        }
        catch {
            print("Error found: registrationAction")
        }
    }
    private func showWarnings(title : String, alertMessage : String) {
        
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
              switch action.style {
              case .default:
                print("default")
                //self.dismiss(animated: true, completion: nil)
              case .cancel:
                print("cancel")

              case .destructive:
                print("destructive")
              @unknown default:
                print("Unknown default")
            }}))
//        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: { action in
//              switch action.style {
//              case .default:
//                print("default")
//              case .cancel:
//                print("cancel")
//
//              case .destructive:
//                print("destructive")
//              @unknown default:
//                print("Unknown default")
//            }}))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goto_dashboard" {
            let nextVc = segue.destination as! UINavigationController
            let vc = nextVc.topViewController as! DashboardViewController
            vc.userModel.name = self.userModel.name
            vc.userModel.phone = self.userModel.phone
            vc.userModel.username = self.userModel.username
        }
    }
    

}
