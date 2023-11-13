//
//  CommendViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit
import RxSwift

final class CommendViewController: UIViewController {
    
    lazy var searchController = {
        let view = UISearchController()
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        return view
    }()
    
    private let mainView = CommendView()
    private let viewModel = CommendViewModel()
    private var disposeBag = DisposeBag()
    private var data: SearchApp? {
        didSet {
            mainView.commendTableView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = mainView
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "검색"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        mainView.commendTableView.delegate = self
        mainView.commendTableView.dataSource = self
        mainView.commendTableView.register(CommendTableViewCell.self, forCellReuseIdentifier: CommendTableViewCell.identifier )
        mainView.commendTableView.rowHeight = 70
        
        let input = CommendViewModel.input(searchButtonClicked: searchController.searchBar.rx.searchButtonClicked)
        let output = viewModel.translation(input: input)
        
        data = output.data
        
        output.searchButtonClicked.subscribe(with: self) { owner, value in
            guard let text = owner.searchController.searchBar.text else { return }
            
            let vc = UINavigationController(rootViewController: SearchViewController(text: text))
            vc.modalPresentationStyle = .overFullScreen
            owner.present(vc, animated: false)
        }.disposed(by: disposeBag)
    }
}

extension CommendViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderHeight:CGFloat = 30
        tableView.sectionHeaderHeight = sectionHeaderHeight
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: sectionHeaderHeight))
        headerView.backgroundColor = .white

        let sectionLabel = UILabel()
        sectionLabel.frame = CGRect.init(x: 16, y: 0, width: headerView.frame.width, height: sectionHeaderHeight)
        sectionLabel.font = .boldSystemFont(ofSize: 20)
        sectionLabel.textColor = .black

        sectionLabel.text = "추천 앱과 게임"

        headerView.addSubview(sectionLabel)
        return headerView
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data else { return }
        let vc = DetailViewController(trackId: data.results[indexPath.item].trackId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
