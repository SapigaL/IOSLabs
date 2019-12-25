//
//  networking.swift
//  Lab1
//
//  Created by Liubomyr on 11/3/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import Foundation

enum Result {
    case Seccess(data: [Course])
    case Fail(error: Error)
}

final class NetworkManager{
    
    //MARK: - Public Methods
    public func getDataFromServer(complition: @escaping ((Result) -> Void)) {
        guard let url = URL(string: "http://localhost:1337/data") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {return }
            switch response.statusCode {
            case 200...204:
                guard let data = data else { return }
                do {
                    let  courses = try JSONDecoder().decode([Course].self, from: data)
                    complition(.Seccess(data: courses))
                } catch let jsonErr{
                }
            default:
                print(error?.localizedDescription)
            }
        }.resume()
    }
    
    public func postDataFromServer(dataCar: CourseCar) -> Bool {
        print(dataCar)
        guard let url = URL(string: "http://localhost:1337/form") else { return false}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONEncoder().encode(dataCar) else{
            return false
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
                print("response1")
            }
            guard let data = data else {return}
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch{
                    print(error)
                }
        }.resume()
        return true
    }
}




