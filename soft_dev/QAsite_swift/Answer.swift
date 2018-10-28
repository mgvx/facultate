//
//  Answer.swift
//  iOSStarterKit
//
//  Created by Andreea Popescu on 5/31/16.
//  Copyright © 2016 Blaze Jobs. All rights reserved.
//

import Foundation

struct Answer
{
    let id: Int
    let body: String
    let question_id: Int
    let user_id: Int
    let user_email: String
    
    init (id: Int, body: String, question_id: Int, user_id: Int, user_email: String) {
        self.id = id
        self.body = body
        self.question_id = question_id
        self.user_id = user_id
        self.user_email = user_email
    }
    
    static func answersJSON(results: NSArray) -> [Answer] {
        var answers = [Answer]()
        if results.count>0 {
            for result in results {
                var id = result["id"] as? Int
                if(id == nil) {
                    id = 0
                }
                var body = result["body"] as? String
                if(body == nil) {
                    body = "Unknown"
                }
                var question_id = result["question_id"] as? Int
                if(question_id == nil) {
                    question_id = 0
                }
                var user_id = result["user_id"] as? Int
                if(user_id == nil) {
                    user_id = 0
                }
                var user_email = result["user_email"] as? String
                if(user_email == nil) {
                    user_email = "Unknown"
                }
                let newAnswer = Answer(id: id!, body: body!, question_id: question_id!, user_id: user_id!, user_email: user_email!)
                print(newAnswer)
                answers.append(newAnswer)
            }
        }
        return answers
    }
}