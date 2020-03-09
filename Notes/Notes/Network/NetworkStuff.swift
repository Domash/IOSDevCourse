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
    let TOKEN = "69e03cf779e5b6b2bee5005590e6c43600466c3c"
    
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
                guard let data = data else {
                    return
                }
                
                guard let loadedGists = try? JSONDecoder().decode([Gist].self, from: data) else {
                    return
                }
                
                let gist = loadedGists.filter { ($0.files.first?.value.filename.contains("\(self.DBNAME)"))! }
                
                if !gist.isEmpty {
                    
                } else {
                    
                }
                
                completion(gist.isEmpty)
                
            }.resume()
            
        } else {
            completion(false)
        }
        
    }
    
    func uploadGist() {
        
    }
    
    func updateGist() {
        
    }
    
    
}
