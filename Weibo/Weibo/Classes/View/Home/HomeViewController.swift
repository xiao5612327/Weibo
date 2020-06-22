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
    private lazy var listViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIColor.cz_random()
        
        // Do any additional setup after loading the view.
    }
    
    // load data
    override func loadData() {
        listViewModel.loadStatus(pullup: isPullUp) { (success, hasMorePullup) in
            
            self.isPullUp = false
            self.refreshController?.endRefreshing()
            
            if hasMorePullup {
                self.tableView?.reloadData()
            }
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
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
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
        
        tableView?.register(UINib(nibName: "StatusNormalCell", bundle: nil), forCellReuseIdentifier: cellId)
        setupNavTitle()
    }
    
    private func setupNavTitle() {
        let button = TitleButton(title: "Xiao")
        button.addTarget(self, action: #selector(clickTileButton(btn:)), for: .touchUpInside)
        navItem.titleView = button
    }
    
    @objc private func clickTileButton(btn: UIButton) {
        btn.isSelected = !btn.isSelected
    }
}
