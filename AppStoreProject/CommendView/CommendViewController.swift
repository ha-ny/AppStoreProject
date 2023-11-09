//
//  CommendViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

class CommendViewController: UIViewController {

    let mainView = SearchView()
    let apiManager = APIManager.shared
    var data: SearchApp? {
        didSet {
            mainView.commendTableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "검색"
        navigationItem.searchController = mainView.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true

        mainView.commendTableView.delegate = self
        mainView.commendTableView.dataSource = self
        mainView.commendTableView.register(CommendTableViewCell.self, forCellReuseIdentifier: "CommendTableViewCell")
        dataSetting()
       
    }
    
    func dataSetting() {
        apiManager.requestAPI(keyWord: "추천앱", limit: 12, completion: { data in
            self.data = data
        })
    }
}

extension CommendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data, let cell = mainView.commendTableView.dequeueReusableCell(withIdentifier: "CommendTableViewCell", for: indexPath) as? CommendTableViewCell else { return UITableViewCell() }

        let result = data.results[indexPath.row]
        cell.cellSetting()
        
        if let url = URL(string: result.artworkUrl512) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.appImage.image = image
                        }
                    }
                }
            }
        }
        
        cell.titleLabel.text = result.trackName
        cell.descriptionLabel.text = result.sellerName
        cell.downLoadButton.tag = indexPath.row
        cell.selectionStyle = .none
        
        if indexPath.row + 1 == data.resultCount {
            cell.lineView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return mainView.commendTableHeaderView
       }
}
