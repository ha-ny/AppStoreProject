//
//  CommendViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct AppdataModel {
    var headerTitle: String
    var items: [Appdata]
}

extension AppdataModel: SectionModelType {
    typealias Item = Appdata

    init(original: AppdataModel, items: [Appdata]) {
        self = original
        self.items = items
    }
}

final class CommendViewController: UIViewController {
    
    private lazy var searchController = {
        let view = UISearchController()
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        return view
    }()
    
    private let mainView = CommendView()
    private let viewModel = CommendViewModel()
    private var disposeBag = DisposeBag()
    private var tableData = [Appdata]()

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
        mainView.commendTableView.register(CommendTableViewCell.self, forCellReuseIdentifier: CommendTableViewCell.identifier )
        mainView.commendTableView.rowHeight = 70
        
        bind()
    }
    
    private func bind() {
        let input = CommendViewModel.input(searchButtonClicked: searchController.searchBar.rx.searchButtonClicked)
        let output = viewModel.translation(input: input)
        
        output.searchButtonClicked.subscribe(with: self) { owner, value in
                guard let text = owner.searchController.searchBar.text else { return }

                let vc = UINavigationController(rootViewController: SearchViewController(text: text))
            vc.modalPresentationStyle = .overFullScreen
            owner.present(vc, animated: false)
        }.disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<AppdataModel> { [weak self] dataSource, tableView, indexPath, item in
            guard let self, let cell = mainView.commendTableView.dequeueReusableCell(withIdentifier: CommendTableViewCell.identifier, for: indexPath) as? CommendTableViewCell else { return UITableViewCell() }
            
            UIImage().stringURLConversion(stringURL: item.artworkUrl512) { image in
                DispatchQueue.main.async { [weak self] in
                   guard let self else { return }
                    cell.appImage.image = image
                }
            }

            cell.titleLabel.text = item.trackName
            cell.descriptionLabel.text = item.description
            cell.selectionStyle = .none

            if indexPath.row + 1 == tableData.count{
                cell.lineView.isHidden = true
            }
            
            return cell
        } titleForHeaderInSection: { dataSource, index in
            return "추천 앱과 게임"
        }
        
        output.data
            .flatMapLatest { [weak self] data in
                let searchAppData =  [AppdataModel(headerTitle: "추천 앱과 게임", items: data)]
                self?.tableData = searchAppData[0].items
                return Observable.just(searchAppData)
            }
            .bind(to: mainView.commendTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension CommendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(trackId: tableData[indexPath.item].trackId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
