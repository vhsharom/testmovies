//
//  Movie.swift
//  TestApp
//
//

import Foundation

class Movie{
    
    var popularity : Double = 0
    var vote_count : Int = 0
    var video : Bool = false
    var poster_path : String = ""
    var id : Int = 0
    var adult : Bool = false
    var backdrop_path : String = ""
    var original_language : String = ""
    var original_title : String = ""
    var title : String = ""
    var vote_average : Double = 0
    var overview : String = ""
    var release_date : String = ""
    
    init(){
        
    }
    
    init(dictionary : NSDictionary) {
        popularity = dictionary["popularity"] as? Double ?? 0
        vote_count = dictionary["vote_count"] as? Int ?? 0
        video = ((dictionary["video"] as? Int ?? 0) as NSNumber).boolValue
        poster_path = dictionary["poster_path"] as? String ?? ""
        id = dictionary["id"] as? Int ?? 0
        adult = ((dictionary["adult"] as? Int ?? 0) as NSNumber).boolValue
        backdrop_path = dictionary["backdrop_path"] as? String ?? ""
        original_language = dictionary["original_language"] as? String ?? ""
        original_title = dictionary["original_title"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        vote_average = dictionary["vote_average"] as? Double ?? 0
        overview = dictionary["overview"] as? String ?? ""
        release_date = dictionary["release_date"] as? String ?? ""
    }
    
    func toNSDictionary() -> NSDictionary{
        let mutDictionary = NSMutableDictionary()
        mutDictionary.setValue(popularity, forKey: "popularity")
        mutDictionary.setValue(vote_count, forKey: "vote_count")
        mutDictionary.setValue(video, forKey: "video")
        mutDictionary.setValue(id, forKey: "id")
        mutDictionary.setValue(adult, forKey: "adult")
        mutDictionary.setValue(backdrop_path, forKey: "backdrop_path")
        mutDictionary.setValue(original_language, forKey: "original_language")
        mutDictionary.setValue(original_title, forKey: "original_title")
        mutDictionary.setValue(title, forKey: "title")
        mutDictionary.setValue(vote_average, forKey: "vote_average")
        mutDictionary.setValue(overview, forKey: "overview")
        mutDictionary.setValue(release_date, forKey: "release_date")
        return mutDictionary
    }
    
}
