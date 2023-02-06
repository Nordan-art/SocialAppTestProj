//
//  LoginData.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import Foundation
import SwiftUI
import CryptoKit
import SwiftJWT

struct ResponseObject<T: Decodable>: Decodable {
    let form: T    // often the top level key is `data`, but in the case of https://httpbin.org, it echos the submission under the key `form`
}

struct Foo: Decodable {
    let id: String
    let name: String
//    let password: String
}

extension Data {
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

func getToken() -> Any {
    let myHeader = Header(
        kid: "S6324MBQLK"
    )
    struct MyClaims: Claims {
        let iss: String
        let iat: Int
        let exp: Int
        let aud: String
        let bid: String
    }
    let myClaims = MyClaims(
        iss: "53cb926b-c8b8-4098-a5f0-db41ec29929e",
        iat: Int(Date.now.timeIntervalSince1970),
        exp: Int(Date.now.adding(hours: 1).timeIntervalSince1970),
        aud: "appstoreconnect-v1",
        bid: "com.MCGroup.MIACRM"
    )
       
    var myJWT = JWT(header: myHeader, claims: myClaims)
    let privateKey = """
        -----BEGIN PRIVATE KEY-----
        MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg291xtU3xnbUHQyzp
        Cfz0N2yatLLeNmaXgNyoSxf1JUagCgYIKoZIzj0DAQehRANCAAQaDR+waeH5Btkz
        pJDSOCCLm6oiB28nNR53tnM6PK2vz3EiL3nVJqpumFo82Hmv3wRDq0QOi3FVYAgG
        m0j9AaEs
        -----END PRIVATE KEY-----
    """.data(using: .utf8)
    
    let publicKey = """
    -----BEGIN PUBLIC KEY-----
    AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPNUNVxKw3MP6MbOMIP+XJlQrH8KVTNj2SPPSJ9A72D6fO6V1bP6OzwOdCCQhADXynnKdaTxc6Q+IFmosvAOids=
    -----END PUBLIC KEY-----
    """.data(using: .utf8)
//    let publicKey = """
//    -----BEGIN PUBLIC KEY-----
//    67e1d029fde74303abfd75f6e3c0c97c
//    -----END PUBLIC KEY-----
//    """.data(using: .utf8)
    
//    print(privateKey!)
//    print(publicKey!)
    let jwtSigner = JWTSigner.es256(privateKey: privateKey!)
    
    let signedJWT = try? myJWT.sign(using: jwtSigner)
    
    let jwtVerifier = JWTVerifier.es256(publicKey: publicKey!)
//    let jwtVerifier = JWTVerifier.rs256(publicKey: publicKey!)
    
    let verified = JWT<MyClaims>.verify(signedJWT!, using: jwtVerifier)

    print("signedJWT \(signedJWT!)")
    print("jwtVerifier \(jwtVerifier)")
    print("verified \(verified)")
    
    return signedJWT!
}

func createJWTToken() -> String {
    
    let startTime = Date.now
//    let endTime = startTime.adding(hours: 1)
//    print("startTime \(Int(startTime.timeIntervalSince1970))")
//    print("endTime \(Int(endTime.timeIntervalSince1970))")
    
    struct Header: Encodable {
        let alg = "ES256"
        let kid = "S6324MBQLK"
        let typ = "JWT"
    }
//    kid = iap Key в раздели ключи
//    Your private key ID from App Store Connect
//    eyJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoidGVzdCJ9.pNIWIL34Jo13LViZAJACzK6Yf0qnvT_BuwOxiMCPE-Y

    struct Payload: Encodable {
        let iss = "53cb926b-c8b8-4098-a5f0-db41ec29929e"
        let iat = Int(Date.now.timeIntervalSince1970)
        let exp = Int(Date.now.adding(hours: 1).timeIntervalSince1970)
        let aud = "appstoreconnect-v1"
        let bid = "com.MCGroup.MIACRM"
    }
//    iss = id in app store
//    Your issuer ID from the Keys page in App Store Connect

    let secret = """
     -----BEGIN PRIVATE KEY-----
     MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg291xtU3xnbUHQyzp
     Cfz0N2yatLLeNmaXgNyoSxf1JUagCgYIKoZIzj0DAQehRANCAAQaDR+waeH5Btkz
     pJDSOCCLm6oiB28nNR53tnM6PK2vz3EiL3nVJqpumFo82Hmv3wRDq0QOi3FVYAgG
     m0j9AaEs
     -----END PRIVATE KEY-----
    """
    
//    let secret = "S6324MBQLK"
//    let secret = "your-256-bit-secret"
    let privateKey = SymmetricKey(data: Data(secret.utf8))

    let headerJSONData = try! JSONEncoder().encode(Header())
    let headerBase64String = headerJSONData.urlSafeBase64EncodedString()

    let payloadJSONData = try! JSONEncoder().encode(Payload())
    let payloadBase64String = payloadJSONData.urlSafeBase64EncodedString()

    let toSign = Data((headerBase64String + "." + payloadBase64String).utf8)

//    let signature = HMAC<SHA256>.authenticationCode(for: toSign, using: privateKey)
    let signature = HMAC<SHA256>.authenticationCode(for: toSign, using: privateKey)
    let signatureBase64String = Data(signature).urlSafeBase64EncodedString()

    let token = [headerBase64String, payloadBase64String, signatureBase64String].joined(separator: ".")
//    let token = [headerBase64String, payloadBase64String, signatureBase64String].joined(separator: ".")
//    print(token)
    return token
}

//Send login Data
func SendLoginData( ) {
//    let url = URL(string: "https://api.appstoreconnect.apple.com/v1/apps/ULJ2V4B25SNGREFWWDUTCKW2QU/prices")!
    
    
    
//      let url = URL(string: "https://api.storekit-sandbox.itunes.apple.com/inApps/v1/notifications/test")!
      let url = URL(string: "https://api.storekit.itunes.apple.com/inApps/v1/notifications/test")!
    
//    let url = URL(string: "https://coffee.kodim.website/wp-json/api/auth/login")!
//    let url = URL(string: "https://httpbin.org/post")!
//    https://coffee.kodim.website/wp-json/api/auth/login
    
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(getToken())", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
//    let parameters: [String: Any] = [
//        "id": 13,
//        "name": "Jack & Jill"
//        "login": "oleg@exemple.com",
//        "password": "31337"
//    ]
//    request.httpBody = parameters.percentEncoded()
    
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
            print("getToken \(getToken())")
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            return
        }
        
        if let responseString = String(data: data, encoding: .utf8) {
            print("responseString = \(responseString)")
            print(responseString)
            let responseID: String = responseString.components(separatedBy: ":")[1].components(separatedBy: "\"")[1]
            print("responseID: \(responseID)")
            
            SendNotifi(responseID: responseID)
            
        } else {
            print("unable to parse response as string")
        }
    }
    task.resume()
}

func SendNotifi(responseID: String ) {
//    let responseID: String
    
    let url = URL(string: "https://api.storekit.itunes.apple.com/inApps/v2/notifications/test/\(responseID)")!
    
//    let url = URL(string: "https://api.storekit-sandbox.itunes.apple.com/inApps/v1/notifications/test")!
    
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(getToken())", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
        
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
            print("SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi  ================================================")
//            print("getToken \(getToken())")
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            return
        }
                
        if let responseString = String(data: data, encoding: .utf8) {
            print("responseString = \(responseString)")
        } else {
            print("unable to parse response as string")
        }
    }

    task.resume()
    
}

func CustomApi() {
    let url = URL(string: "https://api.storekit.itunes.apple.com/inApps/v1/subscriptions/3")!
    
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(getToken())", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
        
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
            print("SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi SendNotifi  ================================================")
            
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            return
        }
                
        if let responseString = String(data: data, encoding: .utf8) {
            print("responseString = \(responseString)")
        } else {
            print("unable to parse response as string")
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

