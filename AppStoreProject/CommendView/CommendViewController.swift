//
//  CommendViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

final class CommendViewController: UIViewController {

    let vc = SearchViewController()
    
    lazy var searchController = {
        let view = UISearchController(searchResultsController: vc)
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        return view
    }()
    
    private let mainView = CommendView()
    private let apiManager = APIManager.shared
    private var data: SearchApp? {
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
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true

        mainView.foundCollectionView.delegate = self
        mainView.foundCollectionView.dataSource = self
        mainView.commendTableView.delegate = self
        mainView.commendTableView.dataSource = self
        mainView.commendTableView.register(CommendTableViewCell.self, forCellReuseIdentifier: CommendTableViewCell.identifier )
        mainView.commendTableView.rowHeight = 70
        dataSetting()
       
    }
    
    private func dataSetting() {
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
        guard let data, let cell = mainView.commendTableView.dequeueReusableCell(withIdentifier: CommendTableViewCell.identifier, for: indexPath) as? CommendTableViewCell else { return UITableViewCell() }

        let result = data.results[indexPath.row]
        cell.cellSetting()

        UIImage().stringURLConversion(stringURL: result.artworkUrl512) { image in
            DispatchQueue.main.async {
                cell.appImage.image = image
            }
        }
        
        cell.titleLabel.text = result.trackName
        cell.descriptionLabel.text = result.description
        cell.selectionStyle = .none

        if indexPath.row + 1 == data.resultCount{
            cell.lineView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return mainView.commendTableHeaderView
   }
}

extension CommendViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        vc.dataSetting(text: "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        vc.dataSetting(text: text)
    }
}

extension CommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainView.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("--------------------------------")
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: FoundCollectionViewCell.identifier, for: indexPath) as? FoundCollectionViewCell else { return UICollectionViewCell() }
        cell.cellSetting()
        cell.dataLabel.text = mainView.data[indexPath.item]
        print(mainView.data[indexPath.item])
        if indexPath.row == 2 {
            cell.line.isHidden = true
        }
        
        return cell
    }
}
