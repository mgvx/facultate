//
//  MainViewController.swift
//  tut
//
//  Created by Andreea Popescu on 4/27/16.
//  Copyright © 2016 a. All rights reserved.
//

import UIKit

class mainViewController: UIViewController, UITableViewDelegate, SearchedStringDelegate {
    
    func setReport(lastAlbum: String) {
        lastReport.text = "Last seen album:\n\(lastAlbum)."
    }
    @IBOutlet weak var lastReport: UILabel!
    
    @IBAction func animateFish(sender: AnyObject) {
        let fish = UIImageView()
        fish.image = UIImage(named: "fish.png")
        let fishSize: CGFloat = CGFloat(arc4random_uniform(60) + 20)
        let yPosStart: CGFloat = 60;
        let yPosFinish: CGFloat = 670;
        let xPos: CGFloat = CGFloat(arc4random_uniform(360))
        fish.frame = CGRectMake(xPos, yPosStart, fishSize, fishSize)
        let options = UIViewAnimationOptions.Autoreverse.union(UIViewAnimationOptions.Repeat.union( UIViewAnimationOptions.CurveEaseInOut))
        self.view.addSubview(fish)
        UIView.animateWithDuration(2.0, delay: 0.0, options: options,animations: {
            fish.frame = CGRectMake(xPos, yPosFinish, fishSize, fishSize)
            }, completion: {
                fishFinished in fish.removeFromSuperview()
        })
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sendSearchText: UIButton!
    @IBAction func sendSearchText(sender: AnyObject) {}
    
    override func viewDidLoad() {
        lastReport.text = "Search for something!"
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        if let searchResultsViewController: SearchResultsViewController = segue.destinationViewController as? SearchResultsViewController {
            var searchString = searchTextField.text
            if searchString == nil {
                searchString = "_"
            }
            searchResultsViewController.searchText = searchString
            searchResultsViewController.delegate = self
        }
    }
    
    
}