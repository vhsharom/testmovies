//
//  MoviesVC.swift
//  TestApp
//
//

import UIKit

class MoviesVC: BaseVC, UITableViewDelegate, UITableViewDataSource, NetworkManagerDelegate, UISearchBarDelegate {

    // MARK: - UIVariables
    var tableView : UITableView? = nil
    var segmentedControl : UISegmentedControl? = nil
    var loaderView : LoaderView? = nil
    var mySearchBar : UISearchBar!
    var isSearching = false

    // MARK: - Variables
    var dataSource : [Movie] = [Movie]()
    var dataSourceSearch : [Movie] = [Movie]()
    
    var networkManager : NetworkManager? = nil
    
    var currentIndex = 0
    
    // MARK: - ViewLifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVars()
        setUpViews()
        getMoviesBy(type: "?sort_by=popularity.desc")
    }
    
    func getMoviesBy(type : String){
        networkManager?.cancel()
        networkManager?.getMoviesBy(type: type)
    }
    
    // MARK: - SetUps
    
    func setUpViews(){
        
        self.title = "Popular Movies"

        let tvc = UITableViewController()
        tvc.view.frame = view.frame
        tableView = tvc.tableView
        view.addSubview(tableView!)
        tableView?.delegate = self
        tableView?.dataSource = self
        
        mySearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        mySearchBar?.showsCancelButton = true
        mySearchBar?.delegate = self
        tableView?.tableHeaderView = mySearchBar
        
        loaderView = LoaderView(frame: view.frame)
        view.addSubview(loaderView!)
        
        segmentedControl = UISegmentedControl(items: ["Pupular", "Top", "Upcoming"])
        segmentedControl?.frame = CGRect(x: 20, y: view.frame.height - 60, width: view.frame.width - 50, height: 40)
        segmentedControl?.backgroundColor = UIColor.colorAppPurple()
        segmentedControl?.selectedSegmentIndex = 0
        view.addSubview(segmentedControl!)
        segmentedControl?.addTarget(self, action: #selector(segmentPressed(segmentedControl:)), for: UIControl.Event.valueChanged)
    }
    
    func setUpVars(){
        networkManager = NetworkManager()
        networkManager?.delegate = self
    }
    
    // MARK: - Target Actions
    
    @objc func segmentPressed(segmentedControl : UISegmentedControl){
        if NetworkManager.isisConnectedToInternet() {
            dataSource.removeAll()
            tableView?.reloadData()
            loaderView?.isHidden = false
            currentIndex = segmentedControl.selectedSegmentIndex
            if segmentedControl.selectedSegmentIndex == 0{
                getMoviesBy(type: "?sort_by=popularity.desc")
                title = "Pupular"
            }
            if segmentedControl.selectedSegmentIndex == 1{
                getMoviesBy(type: "/?certification_country=US&certification=R&sort_by=vote_average.desc")
                title = "Top"
            }
            if segmentedControl.selectedSegmentIndex == 2{
                getMoviesBy(type: "/upcoming?")
                title = "Upcoming"
            }
        }else{
            loaderView?.isHidden = false
            dataSource.removeAll()
            let results = CacheManager().getMovies(type: currentIndex)
            for dict in results{
                let movie : Movie = Movie(dictionary: dict)
                dataSource.append(movie)
            }
            tableView?.reloadData()
        }
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return dataSourceSearch.count + 1
        }else{
            return dataSource.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching{
            if indexPath.row >= dataSourceSearch.count{
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
                return cell
            }else{
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
                cell.textLabel?.text = dataSourceSearch[indexPath.row].title
                return cell
            }
        }else{
            if indexPath.row >= dataSource.count{
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
                return cell
            }else{
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
                cell.textLabel?.text = dataSource[indexPath.row].title
                return cell
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailVC()
        if isSearching {
            vc.movie = dataSourceSearch[indexPath.row]
        }else{
            vc.movie = dataSource[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    
    // MARK: - NetworkManagerDelegate
    
    func networkManagerFinishWithError(manager: NetworkManager, error: _Error) {
        loaderView?.isHidden = true
        showSnackBarMessageError(message: error.errorMessage)
    }
    
    func networkManagerFinishSuccessfull(manager: NetworkManager, response: NSDictionary) {
        loaderView?.isHidden = true
        let results = response["results"] as? [NSDictionary] ?? [NSDictionary]()
        if results.count > 0{
            dataSource.removeAll()
            for dict in results{
                let movie : Movie = Movie(dictionary: dict)
                dataSource.append(movie)
            }
            CacheManager().saveMovies(array: dataSource, type: currentIndex)
            tableView?.reloadData()
        }else{
            tableView?.reloadData()
            showSnackBarMessage(message: "Sin registros")
        }
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        isSearching = false
        view.endEditing(true)
        mySearchBar?.text = ""
        tableView?.reloadData()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        isSearching = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText: \(searchText)")
        if searchText != ""{
            dataSourceSearch = [Movie]()
            for movie in dataSource{
                if movie.title.lowercased().contains(searchText.lowercased()){
                    dataSourceSearch.append(movie)
                }
            }
            tableView?.reloadData()
        }else{
            dataSourceSearch = dataSource
            tableView?.reloadData()
        }
    }
    

    
}
