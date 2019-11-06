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

final class HomeViewController: UIViewController {
    
    //MARK:  Properties
    private var dataCourse = [Course]()
    private let message = MDCSnackbarMessage()
    private let network = NetworkManager()
    private let ckeckInternet = CheckInternet()
    private lazy var myrefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: Outlets
    @IBOutlet private weak var welcomeUserLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        if(checkConnection()){
            fetchData()
        }
        else {
            showMessege(text: "No Internet connection")
        }
    }
    
    //MARK: Private Methods
    private func fetchData(){
        network.getDataFromServer { [weak self] (result) in
            switch result {
            case .Seccess(let data):
                self?.dataCourse = data
                DispatchQueue.main.sync {
                    self?.tableView.reloadData()
                }
            case .Fail(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configTable(){
        tableView.refreshControl = myrefreshControl
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func showMessege(text :String){
        message.text = text
        MDCSnackbarManager.show(message)
    }
    
    private func checkConnection() -> Bool{
        return ckeckInternet.Connection()
    }
    
    @objc private func refresh(sender: UIRefreshControl){
        fetchData()
        sender.endRefreshing()
        if(self.checkConnection()){
        }
        else {
            self.showMessege(text: "No Intqernet connection")
        }
    }
}

//MARK: UITableViewDelegate
extension HomeViewController:UITableViewDelegate{}

//MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    
    //MARK: Public Methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCourse.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as! ActorCell
        let datatt = dataCourse[indexPath.row]
        cell.nameLbl.numberOfLines = datatt.id
        cell.valueLbl.text = datatt.ParkingSpaces
        cell.img.sd_setImage(with: datatt.img, placeholderImage: nil)
        return cell
    }
    
}

