//
//  NetworkStuff.swift
//  Notes
//
//  Created by Денис Домашевич on 3/8/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkStuff {
    
    let DBNAME = "ios-course-notes-db"
    let API = "https://api.github.com/gists"
    let TOKEN = ""
    
    var gist: [Gist]? = nil
    var notes: [Note] = []
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0),
                                      sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let connected = (isReachable && !needsConnection)

        return connected
    }
    
    func loadGists(completion: @escaping (Bool) -> Void) {
        
        if NetworkStuff.isConnectedToNetwork() {
            let components = URLComponents(string: API)
            
            guard let url = components?.url else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("token \(TOKEN)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(false)
                    return
                }
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                guard 200..<300 ~= statusCode else {
                    print("Error: Incorrect status code: \(statusCode).")
                    completion(false)
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                guard let loadedGists = try? JSONDecoder().decode([Gist].self, from: data) else {
                    return
                }
                
                let gist = loadedGists.filter { ($0.files.first?.value.filename.contains("\(self.DBNAME)"))! }
                self.gist = gist
                
                if !gist.isEmpty {
                    completion(true)
                } else {
                    completion(false)
                }
                
            }.resume()
            
        } else {
            completion(false)
        }
        
    }
    
    func loadGistContent(completion: @escaping ([Note]) -> Void) {
        
        if let strUrl = (gist?.first?.files.first?.value.rawUrl) {
            guard let url = URL(string: strUrl) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                guard let notesJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                    return
                }
                
                for noteJson in notesJson {
                    if let note = Note.parse(json: noteJson) {
                        self.notes.append(note)
                    }
                }
                
                completion(self.notes)
                
            }.resume()
        }
        
    }
    
    func uploadGist() {
        
    }
    
    func updateGist() {
        
    }
    
    
}
