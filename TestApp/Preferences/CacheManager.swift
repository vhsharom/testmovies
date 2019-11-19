//
//  Preferences.swift
//  TestApp
//
//

import Foundation

class CacheManager{
    
    init(){
        
    }
    
    func saveMovies(array : [Movie], type : Int){
        let userDefaults = UserDefaults.standard
        
        var arrayToSave = [NSDictionary]()
        for movie in array{
            arrayToSave.append(movie.toNSDictionary())
        }
        
        userDefaults.set(arrayToSave, forKey: "\(type)")
        userDefaults.synchronize()
    }
    
    func getMovies(type : Int) -> [NSDictionary]{
        let userDefaults = UserDefaults.standard
        let array = userDefaults.array(forKey: "\(type)") as? [NSDictionary] ?? [NSDictionary]()
        return array
    }
    
}
