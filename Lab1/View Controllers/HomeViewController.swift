//
//  HomeViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import MaterialComponents.MaterialSnackbar

final class HomeViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    //MARK: UI Variables
    @IBOutlet weak var welcomeUser: UILabel!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:  Variables
    private let network = NetworkManager()
    private let myrefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: Public Methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as! ActorCell
        let datatt = datas[indexPath.row]
        cell.nameLbl.numberOfLines = datatt.id
        cell.valueLbl.text = datatt.ParkingSpaces
        cell.img.sd_setImage(with: datatt.img, placeholderImage: nil)
        return cell
    }
    
    //MARK: Private Methods
    @objc private func refresh(sender: UIRefreshControl){
        network.getDataFromServer { [weak self] (result) in
            switch result {
            case .Seccess(let data):
                datas = data
                print(datas);
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .Fail(let error):
                print(error.localizedDescription)
            }
        }
        network.checkConnection()
        sender.endRefreshing()
    }
    
    //MARK: UIButton Methods
    @IBAction func backButtom(_ sender: Any) {
        exit(0)
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = myrefreshControl
        tableView.dataSource = self
        tableView.delegate = self
        Utilities.styleHollowButton(logOut)
        network.getDataFromServer { [weak self] (result) in
            switch result {
            case .Seccess(let data):
                datas = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .Fail(let error):
                print(error.localizedDescription)
            }
        }
        network.checkConnection()
    }
    
    
    
    
}
