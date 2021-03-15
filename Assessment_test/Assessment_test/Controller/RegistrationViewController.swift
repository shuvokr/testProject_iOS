//
//  RegistrationViewController.swift
//  Assessment_test
//
//  Created by Shuvo on 15/3/21.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {
    
    struct UserModel {
        var fullName : String?
        var userName : String?
        var password : String?
        var phone : String?
    }
    private var userModel : UserModel = UserModel()
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goPrevAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        if self.fullNameTextField.text == nil || self.fullNameTextField.text?.count == 0 {
            self.showWarnings(title: "Registration Warning", alertMessage: "Missing full name field.")
        }
        else if self.fullNameTextField.text!.count > 0 && self.fullNameTextField.text! != self.fullNameTextField.text!.stripped {
            self.showWarnings(title: "Registration Warning", alertMessage: "Name should not contain any special character.")
        }
        else if self.userNameTextField.text == nil || self.userNameTextField.text?.count == 0 {
            self.showWarnings(title: "Registration Warning", alertMessage: "Missing user name field.")
        }
        else if self.passwordTextField.text == nil || self.passwordTextField.text?.count == 0 {
            self.showWarnings(title: "Registration Warning", alertMessage: "Missing password field.")
        }
        else if self.phoneTextField.text == nil || self.phoneTextField.text?.count == 0 {
            self.showWarnings(title: "Registration Warning", alertMessage: "Missing phone number field.")
        }
        else {
            self.registerProcecssActivity(entity: "Users")
        }
    }
    private func showWarnings(title : String, alertMessage : String) {
        
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
              switch action.style {
              case .default:
                print("default")
                //self.dismiss(animated: true, completion: nil)
                if title == "Registration Successfull" {
                    self.dismiss(animated: true, completion: nil)
                }
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
    private func registerProcecssActivity(entity : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var flag : Bool = true
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let phoneNumber = data.value(forKey: "phone") as? String
                if phoneTextField.text! == phoneNumber {
                    flag = false
                    break
                }
            }
        }
        catch {
            print("Found error: registerProcecssActivity")
        }
        if flag {
            let userEntity = NSEntityDescription.entity(forEntityName: entity, in: managedContext)!
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(self.fullNameTextField.text!, forKey: "fullName")
            user.setValue(self.userNameTextField.text!, forKey: "userName")
            user.setValue(self.passwordTextField.text!, forKey: "password")
            user.setValue(self.phoneTextField.text!, forKey: "phone")
            do {
                try managedContext.save()
                DispatchQueue.main.async {
                    self.showWarnings(title: "Registration Successfull", alertMessage: "")
                }
            }
            catch let error as NSError {
                print("Found error : \(error)")
            }
        }
        else {
            self.showWarnings(title: "Registration Warning", alertMessage: "\(self.phoneTextField.text!) is already registred, try with another phone number.")
        }
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
