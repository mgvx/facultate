//
//  EditQuestionViewController.swift
//  iOSStarterKit
//
//  Created by Andreea Popescu on 6/2/16.
//  Copyright © 2016 Blaze Jobs. All rights reserved.
//

import UIKit

class EditQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTitle: UITextField!
    @IBOutlet weak var questionBody: UITextView!
    
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionTitle.text = self.question?.title
        print (self.question?.title)
        self.questionBody.text = self.question?.body
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func questionDelete(sender: AnyObject) {
        SVProgressHUD.showWithStatus("Sending Question Delete")
        
        let sett = Settings.sharedInstance
        let user = sett.currentUser!
        
        let path = "\(Settings.host())api/questions/\(question!.id)/"
        let params = [ "auth_token": "\(user.authentication_token!)" ]
        
        let manager = AFHTTPRequestOperationManager()
        manager.DELETE(path, parameters: params, success: { (operation, responseObject) in
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
    
    @IBAction func questionSubmit(sender: AnyObject) {
        SVProgressHUD.showWithStatus("Sending Question Update")
        
        let sett = Settings.sharedInstance
        let user = sett.currentUser!
        
        let path = "\(Settings.host())api/questions/\(question!.id)"
        let params = [  "auth_token": "\(user.authentication_token!)",
                        "question": [   "title": self.questionTitle.text,
                                        "body": self.questionBody.text]]
        
        let manager = AFHTTPRequestOperationManager()
        manager.PATCH(path, parameters: params, success: { (operation, responseObject) in
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
