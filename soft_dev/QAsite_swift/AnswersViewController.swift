//
//  AnswersViewController.swift
//  iOSStarterKit
//
//  Created by Andreea Popescu on 5/31/16.
//  Copyright © 2016 Blaze Jobs. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController, APIControllerProtocol {
    
    lazy var api: APIController = APIController(delegate: self)
    var questions = [Question]()
    var question: Question?
    var answers = [Answer]()
    
    // views
    @IBOutlet weak var answersView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var similarsTableView: UITableView!
    @IBOutlet weak var answersTableView: UITableView!

    // navbar
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var tabSegmentedControl: UISegmentedControl!
    var questionViewPosition = 0
    var answersViewPosition = 1
    @IBAction func segmentedControlChanged(sender: UISegmentedControl) {
        if self.tabSegmentedControl.selectedSegmentIndex == self.questionViewPosition {
            self.questionView.hidden = false
            self.answersView.hidden = true
        }else if self.tabSegmentedControl.selectedSegmentIndex == self.answersViewPosition {
            self.questionView.hidden = true
            self.answersView.hidden = false
        }
    }
    
    // question view labels
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionBody: UITextView!
    @IBOutlet weak var questionBy: UILabel!
    
    // answers view labels
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var allAnswersLabel: UILabel!
    @IBOutlet weak var answerBody: UITextView!
    @IBOutlet weak var answerSubmitButton: UIButton!
    
    @IBAction func submitAnswer(sender: AnyObject) {
        SVProgressHUD.showWithStatus("Sending New Answer")
        
        let sett = Settings.sharedInstance
        let user = sett.currentUser!
        
        let path = "\(Settings.host())api/questions/\(self.question!.id)/answers"
        let params = [  "auth_token": "\(user.authentication_token!)",
                        "answer": [ "body": self.answerBody.text ]]
    
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
    
    @IBAction func deleteAnswer(sender: AnyObject) {
        SVProgressHUD.showWithStatus("Sending Delete Answer")
        
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.answersTableView)
        let indexPath = self.answersTableView.indexPathForRowAtPoint(buttonPosition)
        let answer = answers[indexPath!.row]
        let sett = Settings.sharedInstance
        let user = sett.currentUser!
        
        let path = "\(Settings.host())api/questions/\(self.question!.id)/answers/\(answer.id)"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        let sett = Settings.sharedInstance
        self.editButton.hidden = true
        self.answerBody.hidden = true
        self.answerSubmitButton.hidden = true
        self.warningLabel.hidden = false
        self.allAnswersLabel.hidden = false
        if let user_id = sett.currentUser?.id
        {
            if user_id == self.question?.user_id.description {
                self.editButton.hidden = false
            }
            self.answerBody.hidden = false
            self.answerSubmitButton.hidden = false
            self.warningLabel.hidden = true
            self.allAnswersLabel.hidden = true
        }
        self.questionTitle.text = self.question?.title
        self.questionBody.text = self.question?.body
        self.questionBy.text = self.question?.user_email
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.getAnswers((self.question?.id)!)
    }
    
    func didReceiveAPIResults(results: NSArray) {
        print("answers didReceiveAPIResults")
        dispatch_async(dispatch_get_main_queue(),{
            self.answers = Answer.answersJSON(results)
            self.answersTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        if let editQuestionViewController: EditQuestionViewController = segue.destinationViewController as? EditQuestionViewController {
            editQuestionViewController.question = self.question
        }
    }
    
    // go to similar id question
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.similarsTableView {
            let similar_id = self.question!.similar_ids[indexPath.row]
            for q in self.questions {
                if q.id == similar_id {
                    self.question = q
                    break
                }
            }
            self.loadData()
            self.answersTableView.reloadData()
            self.similarsTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.answersTableView {
            return answers.count
        }
        if tableView == self.similarsTableView {
            return self.question!.similar_ids.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
    
        if tableView == self.answersTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell")!
            let answer = answers[indexPath.row]
            
            let CommentLabel = cell!.viewWithTag(1) as! UILabel
            CommentLabel.text = answer.body
            CommentLabel.textColor = UIColor.whiteColor()
            
            let ByLabel = cell!.viewWithTag(2) as! UILabel
            ByLabel.text = answer.user_email
            ByLabel.textColor = UIColor.blackColor()
            
            let dButton = cell!.viewWithTag(3) as! UIButton
            dButton.hidden = true
            
            let sett = Settings.sharedInstance
            if let user_id = sett.currentUser?.id
            {
                if user_id == "\(answer.user_id)" {
                    dButton.hidden = false
                    ByLabel.hidden = true
                }
            }
        }
        if tableView == self.similarsTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("SimilarCell")!
            let similar_id = self.question!.similar_ids[indexPath.row]
            
            for q in self.questions {
                if q.id == similar_id {
                    cell!.textLabel?.text = q.title
                    break
                }
            }
        }
        cell!.textLabel?.textColor = UIColor.whiteColor()
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
}