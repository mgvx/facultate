//
//  QuestionsViewController.swift
//  iOSStarterKit
//
//  Created by Andreea Popescu on 5/31/16.
//  Copyright © 2016 Blaze Jobs. All rights reserved.
//


import UIKit
import Foundation

class QuestionsViewController: ProfileBaseViewController, APIControllerProtocol, UISearchBarDelegate{
    
    var allQuestions = [Question]()
    var questions = [Question]()
    var api : APIController!
    var lastSearchTerm : String?
    
    // navbar buttons
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var welcomeButton: UIButton!
    
    //search
    @IBOutlet weak var questionsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        if let searchTerm: String = (searchBar.text)!{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            api.getQuestions(searchTerm)
            self.lastSearchTerm = searchTerm
        }
    }
    func searchBarCancelButtonClicked( searchBar: UISearchBar) {
        searchBar.text = "";
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.getQuestions("")
        self.lastSearchTerm = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeButton.hidden = true
        self.profileButton.hidden = false
        let sett = Settings.sharedInstance
        if sett.currentUser?.id == nil
        {
            self.newButton.hidden = true
            self.welcomeButton.hidden = false
            self.profileButton.hidden = true
        }
        
        api = APIController(delegate: self)
        self.searchBar.delegate = self
        searchBar.showsCancelButton = true;
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.getQuestions("")
        self.lastSearchTerm = ""
    }
    
    func didReceiveAPIResults(results: NSArray){
        print("questions didReceiveAPIResults")
        dispatch_async(dispatch_get_main_queue(),{
            self.questions = Question.questionsJSON(results)
            if self.lastSearchTerm == "" {
                self.allQuestions = self.questions
            }
            self.questionsTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        if let answersViewController: AnswersViewController = segue.destinationViewController as? AnswersViewController {
            let index = questionsTableView!.indexPathForSelectedRow?.row
            let selectedQuestion = self.questions[index!]
            answersViewController.questions = self.allQuestions
            answersViewController.question = selectedQuestion
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("QuestionCell")!
        let question = self.questions[indexPath.row]
        
        let QuestionLabel = cell.viewWithTag(1) as! UILabel
        QuestionLabel.text = question.title
        QuestionLabel.textColor = UIColor.whiteColor()
        
        let AnswersLabel = cell.viewWithTag(2) as! UILabel
        AnswersLabel.text = "answers: \(question.num_answers)"
        AnswersLabel.textColor = UIColor.blackColor()
        
        let ByLabel = cell.viewWithTag(3) as! UILabel
        ByLabel.text = question.user_email
        ByLabel.textColor = UIColor.blackColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
}
