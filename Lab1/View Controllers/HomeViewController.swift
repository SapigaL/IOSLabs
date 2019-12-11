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
import MaterialComponents.MaterialButtons

final class HomeViewController: UIViewController {


    //MARK:  Properties
    private let message = MDCSnackbarMessage()
    private let network = NetworkManager()
    private let ckeckInternet = CheckInternet()
    private lazy var myrefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    private var dataCourse = [Course]()
    private var currentIndex = 0
    
    //MARK: Outlets
    @IBOutlet private weak var welcomeUserLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupVC()
    }
    
    //MARK: - Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? InfoDetailsVC else { return }
        destinationVC.model = dataCourse[currentIndex]
    }
    
    //MARK: Private Methods
    private func setupVC() {
        configTable()
        if checkConnection() { fetchData() }
        else { showMessege(text: "No Internet connection") }
    }
    
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
    
    private func showMessege(text :String) {
        message.text = text
        MDCSnackbarManager.show(message)
    }
    
    private func checkConnection() -> Bool {
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
extension HomeViewController:UITableViewDelegate {}

//MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as! ActorCell
        let datatt = dataCourse[indexPath.row]
        cell.nameLbl.text = "Count cars: " + datatt.ParkingSpaces
        cell.valueLbl.text = "MARK: " + datatt.ParkingSpaces
        cell.img.sd_setImage(with: datatt.img, placeholderImage: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "CellDetail", sender: self)
    }
}

