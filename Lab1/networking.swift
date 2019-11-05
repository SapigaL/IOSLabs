//
//  networking.swift
//  Lab1
//
//  Created by Liubomyr on 11/3/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar

enum Result {
    case Seccess(data: [Course])
    case Fail(error: Error)
}

final class NetworkManager{
    func getDataFromServer(complition: @escaping ((Result) -> Void)) {
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: "http://localhost:1337/data") else { return }
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                DispatchQueue.main.async {
                    switch response.statusCode {
                    case 200...204:
                        guard let data = data else { return }
                        do {
                            let json:NSArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                            let  courses = try JSONDecoder().decode([Course].self, from: data)
                            complition(.Seccess(data: courses))
                            datas = courses
                        } catch let jsonErr{
                        }
                    default:
                        print(error?.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    func checkConnection() {
        let message = MDCSnackbarMessage()
        if CheckInternet.Connection(){
            message.text = "Connected"
            MDCSnackbarManager.show(message)
        }
        else{
            message.text = "Your Device is not connected with internet"
            MDCSnackbarManager.show(message)
        }
    }
}




