//
//  Dashboard.swift
//  iOSStarterKit
//
//  Created by Andreea Popescu on 6/9/16.
//  Copyright © 2016 Blaze Jobs. All rights reserved.
//

import Foundation

struct Question {
    
    let id: Int
    let title: String
    let body: String
    let user_id: Int
    let user_email: String
    let num_answers: Int
    var similar_ids = [Int]()
    
    
    init(id: Int, title: String, body: String, user_id: Int, user_email: String, num_answers: Int, similar_ids: [Int]) {
        self.id = id
        self.title = title
        self.body = body
        self.user_id = user_id
        self.user_email = user_email
        self.num_answers = num_answers
        self.similar_ids = similar_ids
        
    }
    
    static func questionsJSON(results: NSArray) -> [Question] {
        print("JSON")
        var questions = [Question]()
        if results.count>0 {
            for result in results {
                var id = result["id"] as? Int
                if id == nil {
                    id = 0
                }
                var title = result["title"] as? String
                if title == nil {
                    title = "Unknown"
                }
                var body = result["body"] as? String
                if body == nil {
                    body = "Unknown"
                }
                var user_id = result["user_id"] as? Int
                if user_id == nil {
                    user_id = 0
                }
                var user_email = result["user_email"] as? String
                if user_email == nil {
                    user_email = "Unknown"
                }
                var num_answers = result["num_answers"] as? Int
                if num_answers == nil {
                    num_answers = 0
                }
                var similar_ids = [Int]()
                similar_ids = (result["similar_ids"] as? Array)!
                
                var newQuestion = Question(id: id!, title: title!, body: body!, user_id: user_id!, user_email: user_email!, num_answers: num_answers!, similar_ids: similar_ids)
                questions.append(newQuestion)
            }
        }
        return questions
    }
}