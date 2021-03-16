//
//  DetailedViewController.swift
//  Assessment_test
//
//  Created by Shuvo on 15/3/21.
//

import UIKit
import WebKit
class DetailedViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    var myURL : URL?
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    @IBAction func backAction(_ sender: UIBarButtonItem) {
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
