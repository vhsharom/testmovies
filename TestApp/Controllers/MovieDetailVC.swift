//
//  MovieDetailVC.swift
//  TestApp
//
//

import UIKit
import SDWebImage
import WebKit

class MovieDetailVC: BaseVC, NetworkManagerDelegate {

    // MARK: - Variables
    var movie : Movie = Movie()
    var networkManagerVideo : NetworkManager? = nil
    
    // MARK: - UIVariables
    
    var original_titleLabel : UILabel!
    var summaryLabel : UILabel!
    var backdrop_pathImage : UIImageView!
    var poster_pathImage : UIImageView!
    var vote_averageLabel : UILabel!
    var overViewLabel : UILabel!
    var release_dateLabel : UILabel!
    
    var segmentButton : UISegmentedControl!
    var loaderView : LoaderView? = nil
    var webView : WKWebView? = nil
    var videoUrl : String = ""

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVars()
        setUpViews()
    }
    
    // MARK: - SetUps
    
    func setUpVars(){
        networkManagerVideo = NetworkManager()
        networkManagerVideo?.delegate = self
    }
    
    func setUpViews(){
        title = movie.title
        
        backdrop_pathImage = UIImageView(frame: CGRect(x: 0, y: topbarHeight, width: view.frame.width, height: 240))
        backdrop_pathImage.contentMode = UIView.ContentMode.scaleAspectFill
        backdrop_pathImage.alpha = 0.7
        if let URL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)"){
            backdrop_pathImage.sd_setImage(with: URL, completed: nil)
        }
      
        view.addSubview(backdrop_pathImage)
        
        poster_pathImage = UIImageView(frame: CGRect(x: 10, y: topbarHeight + 10, width: 140, height: backdrop_pathImage.frame.height - 20))
        if let URL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)"){
            poster_pathImage.sd_setImage(with: URL, completed: nil)
        }
        view.addSubview(poster_pathImage)
        
        segmentButton = UISegmentedControl(items: ["Información", "Trailer"])
        segmentButton.frame = CGRect(x: 10, y: backdrop_pathImage.frame.maxY + 10, width: view.frame.width - 20, height: 35)
        segmentButton.backgroundColor = UIColor.colorAppOrange()
        segmentButton.addTarget(self, action: #selector(segmentPressed(segmentedButton:)), for: UIControl.Event.valueChanged)
        segmentButton.selectedSegmentIndex = 0
        view.addSubview(segmentButton)
        
        original_titleLabel = UILabel(frame: CGRect(x: 10, y: segmentButton.frame.maxY + 10, width: view.frame.width - 20, height: 0))
        original_titleLabel.text = movie.original_title
        original_titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        original_titleLabel.sizeToFit()
        view.addSubview(original_titleLabel)
        
        summaryLabel = UILabel(frame: CGRect(x: 10, y: original_titleLabel.frame.maxY + 10, width: view.frame.width - 20, height: 0))
        summaryLabel.numberOfLines = 0
        summaryLabel.text = movie.overview
        summaryLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        summaryLabel.sizeToFit()
        view.addSubview(summaryLabel)
        
        loaderView = LoaderView(frame: view.frame)
        view.addSubview(loaderView!)
        
        getVideos()
    }
    
    // MARK: - Target Actions
    
    @objc func segmentPressed(segmentedButton : UISegmentedControl){
        if segmentButton.selectedSegmentIndex == 0{
            original_titleLabel.isHidden = false
            summaryLabel.isHidden = false
            webView?.removeFromSuperview()
        }else{
            original_titleLabel.isHidden = true
            summaryLabel.isHidden = true
            webView = WKWebView(frame: CGRect(x: 0, y: segmentButton.frame.maxY + 10, width: view.frame.width, height: 300))
            view.addSubview(webView!)
            
            if let youtubeURL = URL(string: videoUrl){
                let request = URLRequest(url: youtubeURL)
                webView?.load(request)
            }
        }
    }
    
    @objc func getVideos(){
        networkManagerVideo?.getMovieVideos(movie_id: "\(movie.id)")
    }

    // MARK: - NetworkManagerDelegate

    func networkManagerFinishWithError(manager: NetworkManager, error: _Error) {
        loaderView?.isHidden = true
        showSnackBarMessage(message: error.errorMessage)
    }
    
    func networkManagerFinishSuccessfull(manager: NetworkManager, response: NSDictionary) {
        print("Response: \(response)")
        loaderView?.isHidden = true
        let results = response["results"] as? [NSDictionary] ?? [NSDictionary]()
        if results.count > 0{
            let first = results[0]
            let key = first["key"] as? String ?? ""
            //let site = first["site"] as? String ?? ""
            videoUrl = "https://www.youtube.com/embed/\(key)"
        }else{
            showSnackBarMessage(message: "No hay videos disponibles")
        }
    }
}
