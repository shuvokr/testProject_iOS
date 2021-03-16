//
//  DashboardViewController.swift
//  Assessment_test
//
//  Created by Shuvo on 15/3/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.searchModel[indexPath.row].name!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentPossition = indexPath.row
        self.performSegue(withIdentifier: "goto_details", sender: self)
    }
    
    struct UserModel {
        var name : String?
        var username : String?
        var phone : String?
    }
    var userModel = UserModel()
    struct SearchModel {
        var url : URL?
        var name : String?
    }
    private var searchModel = [SearchModel]()
    private var currentPossition : Int = Int()
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.tableFooterView = UIView()
        //table.separatorStyle = .none
    }
    
    @IBAction func logoutActions(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func viewProfileActions(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goto_userpro", sender: self)
    }
    @IBAction func searchAction(_ sender: UIButton) {
        let urlTo = URL(string: "https://api.tvmaze.com/search/shows?q=\(self.searchBarOutlet.text!)")!
        //https://youtu.be/ahkzZ7eH0io
        AF.request(
            urlTo,
            method: .get
            ).responseJSON {
            (response) in
            switch response.result {

                case .success(let json):
                    let jsonData = JSON(json as Any)
                    guard let statusCode = response.response?.statusCode else { return }
                    if(statusCode == 200) {
                        //print(jsonData)
                        self.searchModel.removeAll()
                        for i in 0..<jsonData.count {
                            DispatchQueue.main.async {
                                self.searchModel.append(SearchModel(url: URL(string: jsonData[i]["show"]["url"].stringValue), name: jsonData[i]["show"]["name"].stringValue))
                            }
                        }
                        DispatchQueue.main.async {
                            self.table.delegate = self
                            self.table.dataSource = self
                            self.table.reloadData()
                            //print(self.searchModel)
                        }
                    }
                    else {

                    }

                case .failure(let error):
                    print("Usrs list request error: \(error)")

            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goto_userpro" {
            let nextVc = segue.destination as! UINavigationController
            let vc = nextVc.topViewController as! ProfileViewController
            vc.userModel.name = self.userModel.name
            vc.userModel.phone = self.userModel.phone
            vc.userModel.username = self.userModel.username
        }
        if segue.identifier == "goto_details" {
            let nextVc = segue.destination as! UINavigationController
            let vc = nextVc.topViewController as! DetailedViewController
            vc.myURL = self.searchModel[currentPossition].url
        }
    }

}
