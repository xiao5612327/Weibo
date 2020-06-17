//
//  HomeViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

fileprivate let cellId = "cellId"

class HomeViewController: BaseViewController {

    // load weibo data array
    private lazy var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIColor.cz_random()
        // Do any additional setup after loading the view.
    }
    
    // load data
    override func loadData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            for i in 0..<10 {
                if self?.isPullUp ?? false {
                    self?.statusList.append("\(i.description)" + " pull up")
                }else {
                    self?.statusList.insert(i.description, at: 0)
                }
            }
            self?.isPullUp = false

            self?.refreshController?.endRefreshing()
            self?.tableView?.reloadData()
        }
    }
    
    
    /// target func for friend button
    @objc private func showFriends() {
        
        let vc = BaseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: table view data source
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
    }
}

// MARK: Set UI
extension HomeViewController {
    
    /// set up base view controller UI
    @objc override func setupTableView() {
        super.setupTableView()
        // swift call OC return instanceType method cant know if it is optional
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Friend", target: self, action: #selector(showFriends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
