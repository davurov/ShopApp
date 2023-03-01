//
//  MainVC.swift
//  ShopApp
//
//  Created by Abduraxmon on 20/02/23.
//

import UIKit

class MainVC: UIViewController {
    
    
    var searchReslts = [SearchResult]()
    
    
    @IBOutlet weak var searchVC: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var isLoading = false
    var dataTask: URLSessionDataTask?
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        performSearch()
    }
    
    
    func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        searchVC.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "cell2")
    }
    
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchReslts.count == 0 {
            return 1
        }
        
        if isLoading {
            return 1
        } else {
            return searchReslts.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoading {
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! LoadingCell
            
            loadingCell.activityBar.startAnimating()
            
            return loadingCell
        } else if searchReslts.count != 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            
            let searchResult = searchReslts[indexPath.row]
            
            cell.mainTitle.text = searchResult.trackName
            cell.desc.text = searchResult.artistName
            
            DispatchQueue.main.async {
                cell.photo?.loadFrom(URLAddress: searchResult.artworkUrl60)
                
            }
            
            
            return cell
        } else {
            
            let nothingfoundCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            
            nothingfoundCell.textLabel?.text = "Nothing Found"
            
            return nothingfoundCell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchReslts.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailVC(nibName: "DetailVC", bundle: nil)
        
        present(detailVC, animated: true)
        
        let searchResult = searchReslts[indexPath.row]
        
        detailVC.productName.text = searchResult.trackName
        detailVC.artistName.text! += " " + (searchResult.artistName ?? "not avalible")
        detailVC.typeValue.text! += " " + searchResult.wrapperType
        detailVC.genreType.text! += " " + searchResult.primaryGenreName
        detailVC.productImageView.loadFrom(URLAddress: searchResult.artworkUrl100)
    }
    
    func iTunesUrl(searchTxt: String, categoryId: Int) -> URL {
    
        let kind: String
        
        switch categoryId {
        case 0: kind = "all"
        case 1: kind = "musicTrack"
        case 2: kind = "software"
        case 3: kind = "ebook"
        default: kind = ""
        }
        
        
        let encodedText = searchTxt.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        var urlString = ""
        
        if kind != "all" {
            urlString = String("https://itunes.apple.com/search?term=\(encodedText!)&limit=200&entity=\(kind)")
        } else {
            urlString = String(format: "https://itunes.apple.com/search?term=%@", encodedText!)
        }
        
        let url = URL(string: urlString)
        
        return url!
    }
    
    func parse(data: Data) -> [SearchResult] {
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.results ?? []
        } catch {
            return []
        }
        
    }
    
    func performStoreRequest(with url: URL) -> Data? {
        
        do {
            return try Data(contentsOf: url)
        } catch {
            showNetworkError()
        }
        
        return nil
        
    }
    
    func showNetworkError() {
        
        let alert = UIAlertController(title: "Ooops!!", message: "There was a network error", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}


extension MainVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       performSearch()
    }
    
    func performSearch() {
       if !(searchVC.text?.isEmpty ?? true) {
           searchVC.resignFirstResponder()
           
           dataTask?.cancel()
           isLoading = true
           tableView.reloadData()
           
           searchReslts = []
           
           let url = iTunesUrl(searchTxt: searchVC.text!, categoryId: segmentControl.selectedSegmentIndex)
           let session = URLSession.shared
           
           dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
               if let _ = error {
                   return
               } else if let httpResponce = response as? HTTPURLResponse, httpResponce.statusCode == 200 {
                   if let data = data {
                       self.searchReslts = self.parse(data: data)
                       DispatchQueue.main.async {
                           self.isLoading = false
                           self.tableView.reloadData()
                       }
                       return
                   }
               } else {
                   print("error ocured")
               }
               
               
               
               DispatchQueue.main.async {
                   self.hasSearched = false
                   self.isLoading = false
                   self.tableView.reloadData()
                   self.showNetworkError()
               }
               
           })
           
           dataTask?.resume()
       }
    }
    
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        
        
        if let url = URL(string: URLAddress) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
              // Error handling...
              guard let imageData = data else { return }

              DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
              }
            }.resume()
          }
    }
}
