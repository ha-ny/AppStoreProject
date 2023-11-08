//
//  SearchView.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

class SearchView: BaseView {

    let searchBar = {
        let view = UISearchController()
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        return view
    }()
    
    //let tableView = UITableView()
    
    override func setConstraints() {
        //addSubview(tableView)
    }
    
    override func setConfiguration() {
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(self)
//        }
    }
}
