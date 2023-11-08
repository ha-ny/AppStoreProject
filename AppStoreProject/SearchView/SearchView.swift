//
//  SearchView.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

class SearchView: BaseView {

    let searchBar = UISearchController()
    let tableView = UITableView()
    
    override func setConstraints() {
        addSubview(tableView)
    }
    
    override func setConfiguration() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
