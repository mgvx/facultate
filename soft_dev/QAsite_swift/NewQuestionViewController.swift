//
//  NewQuestionViewController.swift
//  iOSStarterKit
//
//  Created by Andreea Popescu on 6/2/16.
//  Copyright © 2016 Blaze Jobs. All rights reserved.
//

import UIKit

class NewQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTitle: UITextField!
    @IBOutlet weak var questionBody: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func questionSubmit(sender: AnyObject) {
        SVProgressHUD.showWithStatus("Sending New Question")
        let sett = Settings.sharedInstance
        let user = sett.currentUser!
        
        let path = "\(Settings.host())api/questions/"
        let params = [  "auth_token": "\(user.authentication_token!)",
                        "question": [   "title": self.questionTitle.text,
                            "body": self.questionBody.text ]]
        
        let manager = AFHTTPRequestOperationManager()
        manager.POST(path, parameters: params, success: { (operation, responseObject) in
            self.navigationController?.popViewControllerAnimated(true)
            SVProgressHUD.dismiss()
        }) { (operation, error) in
            SVProgressHUD.dismiss()
            let av = UIAlertView(title: "Error!",
                                 message: operation.responseString,
                                 delegate: nil,
                                 cancelButtonTitle: "OK")
            av.show()
        }
    }
    
}
