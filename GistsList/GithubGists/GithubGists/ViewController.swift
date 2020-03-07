//
//  ViewController.swift
//  GithubGists
//
//  Created by Денис Домашевич on 3/1/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

struct Gist: Decodable {
    let commentsNumber: Int64
    let isPublic: Bool
    let created: String
    let description: String


    enum CodingKeys: String, CodingKey {
        case commentsNumber = "comments"
        case isPublic = "public"
        case created  = "created_at"
        case description = "description"
    }
}

private let token = "" // Set token
private let githubGistAPI = "https://api.github.com/gists"

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    private var gists: [Gist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let components = URLComponents(string: githubGistAPI)
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let _ = self,
                  let data = data else { return }
            
            guard let gists = try? JSONDecoder().decode([Gist].self, from: data) else {
                return
                
            }
            
            self?.gists = gists
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
        
    }
    
    private func convertDate(_ createdDate: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: createdDate)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

}

class MyCell: UITableViewCell {
    @IBOutlet weak var comNumber: UILabel!
    @IBOutlet weak var isPublic: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var gistDescription: UILabel!
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
    
        cell.comNumber.text = "Comments: \(gists[indexPath.row].commentsNumber)"
        cell.isPublic.text = "Is public gist: \(gists[indexPath.row].isPublic)"
        
        let date = convertDate(gists[indexPath.row].created)
        cell.createdAt.text = "Date: \(date)"
        
        let description = gists[indexPath.row].description.count > 0 ? "Description: \(gists[indexPath.row].description)" : "Description: Nil"
        cell.gistDescription.text = description
        
        return cell
        
    }
}

