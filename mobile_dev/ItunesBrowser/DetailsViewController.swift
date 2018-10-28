//
//  DetailsViewController.swift
//  tut
//
//  Created by Andreea Popescu on 4/24/16.
//  Copyright © 2016 a. All rights reserved.
//

import UIKit
import MediaPlayer

class DetailsViewController: UIViewController, APIControllerProtocol {
    
    lazy var api: APIController = APIController(delegate: self)
    var mediaPlayer: MPMoviePlayerController = MPMoviePlayerController()

    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tracksTableView: UITableView!
    
    var album: Album?
    var tracks = [Track]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        print("DetailsViewDidLoad")
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.album!.largeImageURL)!)!)
        if(self.album != nil) {
            api.lookupAlbum(self.album!.collectionId)
        }
    }
    
    func didReceiveAPIResults(results: NSArray) {
        print("didReceiveAPIResults")
        dispatch_async(dispatch_get_main_queue(), {
            self.tracks = Track.tracksWithJSON(results)
            self.tracksTableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView return number of rows")
        return tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("tableView return cell at index")
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as! TrackCell
        let track = tracks[indexPath.row]
        cell.titleLabel.text = track.title
        cell.playIcon.text = "▶️"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("tableView selected cell")
        var track = tracks[indexPath.row]
        mediaPlayer.stop()
        mediaPlayer.contentURL = NSURL(string: track.previewUrl)
        mediaPlayer.play()
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? TrackCell {
            cell.playIcon.text = "⏹"
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
}