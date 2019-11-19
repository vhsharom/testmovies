//
//  NetworkManager.swift
//  HelloGas
//
//

import Foundation
import UIKit
import SystemConfiguration
import Reachability

protocol NetworkManagerDelegate {
    func networkManagerFinishSuccessfull(manager: NetworkManager, response: NSDictionary)
    func networkManagerFinishWithError(manager: NetworkManager, error: _Error)
}

class NetworkManager: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    //MARK: - Variables
    var dataTask : URLSessionDataTask?
    var responseData : Data = Data()
    var delegate : NetworkManagerDelegate?
    var httpReponse : HTTPURLResponse!
    var isConnectionInProcess = false
    var isCancelledByUser = false
    
    var displayAlerts = true

    //MARK: - URLs
    
    let baseURL = "https://api.themoviedb.org/3/discover/movie"
    let api_key = "bbb5045ac5f8792c20fe23b5b411cfd6"

    //MARK: - Initializers
    
    override init(){
        super.init()
    }
    
    //MARK: - Connections
    
    func cancel(){
        isCancelledByUser = true
        dataTask?.cancel()
    }

    func getMoviesBy(type : String){
        isCancelledByUser = false
        isConnectionInProcess = true
        if dataTask != nil {
            dataTask?.cancel()
        }
        let urlString = "\(baseURL)?\(type)&api_key=\(api_key)"
        print("URL Movies: \(urlString)")
        let url = URL(string:urlString)
        var request = URLRequest(url:url!)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        let sessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
        responseData = Data()
    }
    
    func getMovieVideos(movie_id : String){
        isCancelledByUser = false
        isConnectionInProcess = true
        if dataTask != nil {
            dataTask?.cancel()
        }
        let urlString = "https://api.themoviedb.org/3/movie/\(movie_id)/videos?&api_key=\(api_key)&language=en-US"
        print("URL Videos: \(urlString)")
        let url = URL(string:urlString)
        var request = URLRequest(url:url!)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        let sessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
        responseData = Data()
    }

    func getDeviceParams() -> NSMutableDictionary{
        let batteryLevel = UIDevice.current.batteryLevel
        var batteryState = "NA"
        switch UIDevice.current.batteryState {
        case UIDevice.BatteryState.unknown:
            batteryState = "unknown"
            break
        case UIDevice.BatteryState.unplugged:
            batteryState = "unplugged"
            break
        case UIDevice.BatteryState.charging:
            batteryState = "charging"
            break
        case UIDevice.BatteryState.full:
            batteryState = "full"
        @unknown default:
            print("param default")
        }

        let mutDictionary = NSMutableDictionary()
        mutDictionary.setValue(User.shared.uuid, forKey: "DeviceId")
        mutDictionary.setValue("iOS", forKey: "OSType")
        mutDictionary.setValue(User.shared.build, forKey: "AppVersion")
        mutDictionary.setValue(User.shared.osVersion, forKey: "OSVersion")
        mutDictionary.setValue(User.shared.deviceModel, forKey: "DeviceModel")
        mutDictionary.setValue(User.shared.deviceName, forKey: "DeviceName")
        mutDictionary.setValue(User.shared.deviceWidth, forKey: "DeviceWidth")
        mutDictionary.setValue(User.shared.deviceHeight, forKey: "DeviceHeight")
        mutDictionary.setValue(batteryLevel, forKey: "BatteryLevel")
        mutDictionary.setValue(batteryState, forKey: "BatteryState")
        mutDictionary.setValue(getNetworkType(), forKey: "NetworkType")
        return mutDictionary
    }
    
    func getNetworkType() -> String {
        do{
            var networkType = "na"
            let reachability = try Reachability()
            switch reachability.connection {
            case .wifi:
                networkType = "wifi"
            case .cellular:
                networkType = "celular"
            case .none:
                networkType = "none"
            case .unavailable:
                networkType = "unavailable"
            }
            return networkType
        }catch{
            return "NA"
        }
    }

    class func isisConnectedToInternet() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }


    //MARK: - URLSession Delegate
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        isConnectionInProcess = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if isCancelledByUser {
            
        }else{
            if error == nil{
                       if httpReponse.statusCode == 200{
                           let response = String(data: responseData, encoding: String.Encoding.utf8)
                           
                           if let _ = response{
                                   var jsonDictionary : NSDictionary?
                                   do {
                                       jsonDictionary = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                                   } catch let error {
                                       delegate?.networkManagerFinishWithError(manager: self, error: _Error(errorType: ErrorType.CantParseJson))
                                       
                                       print("error haciendo diccionario: "+error.localizedDescription)
                                   }
                                   if let _jsonDictionary = jsonDictionary {
                                       delegate?.networkManagerFinishSuccessfull(manager: self, response: _jsonDictionary)
                                   } else{
                                       delegate?.networkManagerFinishWithError(manager: self, error: _Error(errorType: ErrorType.CantParseJson))
                                   }

                           } else{
                               print("Responde error")
                               delegate?.networkManagerFinishWithError(manager: self, error: _Error(errorType: ErrorType.CantCreateString))
                           }
                       }else{
                           print("HTTP STATUS CODE: \(httpReponse.statusCode)")
                           delegate?.networkManagerFinishWithError(manager: self, error: _Error(httpResponse: httpReponse))
                       }
                   } else{
                       print("Error != nil")
                       delegate?.networkManagerFinishWithError(manager: self, error: _Error(theError: error!))
                   }
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        httpReponse = response as? HTTPURLResponse
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
}





