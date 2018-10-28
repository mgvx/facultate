//
//  ViewController.swift
//  tut
//
//  Created by Andreea Popescu on 4/22/16.
//  Copyright © 2016 a. All rights reserved.
//

import UIKit

protocol SearchedStringDelegate {
    func setReport(lastAlbum: String)
}

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    var delegate: SearchedStringDelegate! = nil
    @IBOutlet var appsTableView: UITableView!
    
    var tableData = []
    let kCellIdentifier: String = "SearchResultCell"
    var api : APIController!
    var imageCache = [String: UIImage]()
    var albums = [Album]()
    var searchText: String? = "default"
    
    override func viewDidLoad() {
        print("SearchViewDidLoad")
        super.viewDidLoad()
        api = APIController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.searchItunesFor(searchText!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveAPIResults(results: NSArray){
        print("didReceiveAPIResults")
        dispatch_async(dispatch_get_main_queue(),{
            self.albums = Album.albumsWithJSON(results)
            self.appsTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        if let detailsViewController: DetailsViewController = segue.destinationViewController as? DetailsViewController {
            var albumIndex = appsTableView!.indexPathForSelectedRow?.row
            var selectedAlbum = self.albums[albumIndex!]
            detailsViewController.album = selectedAlbum
            
            delegate.setReport(selectedAlbum.title)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView return number of rows")
        return albums.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("tableView return cell at index")
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier)!
        let album = self.albums[indexPath.row]
        cell.detailTextLabel?.text = album.price
        cell.textLabel?.text = album.title
        cell.imageView?.image = UIImage(named: "Blank52")
        
        let thumbnailURLString = album.thumbnailImageURL
        let thumbnailURL = NSURL(string: thumbnailURLString)!
        
        if let img = imageCache[thumbnailURLString]{
            cell.imageView?.image=img
        }
        else{
            //download
            let request : NSURLRequest = NSURLRequest(URL: thumbnailURL)
            let mainQueue = NSOperationQueue.mainQueue()
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: {
                (response, data, error) -> Void in
                if error == nil {
                    let image = UIImage(data: data!)
                    self.imageCache[thumbnailURLString] = image
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                            cellToUpdate.imageView?.image = image
                        }
                    })
                }
                else {
                    print("Error: \(error!.localizedDescription)")
                }
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
}
