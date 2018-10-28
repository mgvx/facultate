//
//  APIController.swift
//  tut
//
//  Created by Andreea Popescu on 4/22/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results: NSArray)
}

class APIController
{
    var delegate: APIControllerProtocol

    init (delegate: APIControllerProtocol) {
        self.delegate = delegate
        }
    
    func get(path: String)
    {
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            print("completion")
            if(error != nil){
                print(error!.localizedDescription)
            }
            do{
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                {
                    if let results: NSArray = jsonResult["results"] as? NSArray
                    {
                        self.delegate.didReceiveAPIResults(results)
                    }
                }
                
            } catch let err as NSError {
                print("JSON Error \(err.localizedDescription)")
            }
        })
        task.resume()
        print("resume")
    }
    
    func searchItunesFor(searchTerm: String)
    {
        print("get search")
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        {
            let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music&entity=album"
            get(urlPath)
        }
    }
    
    func lookupAlbum(collectionId: Int) {
        print("get album")
        get("https://itunes.apple.com/lookup?id=\(collectionId)&entity=song")
    }
    
    
}
