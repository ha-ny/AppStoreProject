//
//  SearchViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

class SearchViewController: UIViewController {

    let mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "검색"
        navigationItem.searchController = mainView.searchBar
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

