import Foundation

struct File: Encodable {
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case content = "content"
    }
}

struct Gist: Encodable {
    let files: [String: File]
    let isPublic: Bool
    let description: String


    enum CodingKeys: String, CodingKey {
        case files = "files"
        case isPublic = "public"
        case description = "description"
    }
}

private let token = "" // Set token
private let githubGistAPI = "https://api.github.com/gists"

let components = URLComponents(string: githubGistAPI)

if let url = components?.url {

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("token \(token)", forHTTPHeaderField: "Authorization")

    let fileContent = "Struct COVID-19 {}"
    let file = File(content: fileContent)
    let dict = [
        "COVID-19.swift": file
    ]
    
    request.httpBody = try JSONEncoder().encode(Gist(files: dict, isPublic: true, description: "My best class"))
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let _ = data,
              let response = response as? HTTPURLResponse, error == nil
        else {
            print("Error", error ?? "Unknown error")
            return
        }

        guard (200 ... 299) ~= response.statusCode else {
            print("StatusCode should be 2xx, but is \(response.statusCode)")
            print("Response = \(response)")
            return
        }
    }.resume()
    
}



