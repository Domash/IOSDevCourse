//
//  BaseBackendOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

class BaseBackendOperation: AsyncOperation {
    
    let API = "https://api.github.com/gists"
    let TOKEN = "5a956ffbb7b993d2794a2cf03a84f36750cdf2c3"
    
    var gists: [Gist]? = nil
    
    override init() {
        super.init()
    }
    
    func loadGists() {
        
        let components = URLComponents(string: API)
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            guard let loadedGists = try? JSONDecoder().decode([Gist].self, from: data) else {
                return
            }
            
            self.gists = loadedGists
        }.resume()
    
    }
    
}
