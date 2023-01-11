//
//  LoginData.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import Foundation
import SwiftUI

struct ResponseObject<T: Decodable>: Decodable {
    let form: T    // often the top level key is `data`, but in the case of https://httpbin.org, it echos the submission under the key `form`
}

struct Foo: Decodable {
    let id: String
    let name: String
//    let password: String
}

//Send login Data
func SendLoginData( ) {
//    let url = URL(string: "https://api.appstoreconnect.apple.com/v1/apps/ULJ2V4B25SNGREFWWDUTCKW2QU/prices")!
    let url = URL(string: "https://coffee.kodim.website/wp-json/api/auth/login")!
//    let url = URL(string: "https://httpbin.org/post")!
//    https://coffee.kodim.website/wp-json/api/auth/login

    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    let parameters: [String: Any] = [
//        "id": 13,
//        "name": "Jack & Jill"
        "login": "oleg@exemple.com",
        "password": "31337"
    ]
    request.httpBody = parameters.percentEncoded()

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            error == nil
        else {                                                               // check for fundamental networking error
            print("error", error ?? URLError(.badServerResponse))
            return
        }
        
        guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            return
        }
        
        // do whatever you want with the `data`, e.g.:
        
        do {
            let responseObject = try JSONDecoder().decode(ResponseObject<Foo>.self, from: data)
            print("================================")
            print("responseObject \(responseObject)")
            print("data \(data)")
            print(type(of: data))
        } catch {
            print(error) // parsing error
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("responseString = \(responseString)")
            } else {
                print("unable to parse response as string")
            }
        }
    }

    task.resume()
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
