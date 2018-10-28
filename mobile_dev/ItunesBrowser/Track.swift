//
//  Track.swift
//  tut
//
//  Created by Andreea Popescu on 4/25/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation

struct Track
{
    let title: String
    let price: String
    let previewUrl: String
    
    init (title: String, price: String, previewUrl: String) {
        self.title = title
        self.price = price
        self.previewUrl = previewUrl
    }
    
    static func tracksWithJSON(results: NSArray) -> [Track] {
        print("tracksWithJSON")
        var tracks = [Track]()
        if results.count>0 {
            for trackInfo in results {
                if let kind = trackInfo["kind"] as? String {
                    if kind == "song" {
                        var trackTitle = trackInfo["trackName"] as? String
                        if(trackTitle == nil) {
                            trackTitle = "Unknown"
                        }
                        var trackPrice = trackInfo["trackPrice"] as? String
                        if(trackPrice == nil) {
                            trackPrice = "?"
                        }
                        var trackPreviewUrl = trackInfo["previewUrl"] as? String
                        if(trackPreviewUrl == nil) {
                            trackPreviewUrl = ""
                        }
                        var track = Track(title: trackTitle!, price: trackPrice!, previewUrl: trackPreviewUrl!)
                        tracks.append(track)
                    }
                }
            }
        }
        return tracks
    }
}