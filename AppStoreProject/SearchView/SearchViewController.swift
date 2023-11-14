//
//  SearchViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchViewController: UIViewController {

    private lazy var searchController = {
        let view = UISearchController()
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        view.searchBar.showsCancelButton = true
        return view
    }()
    
    private let mainView = CommendView()
    private let viewModel = SearchViewModel()
    private var tableData = [Appdata]()
    private let disposeBag = DisposeBag()

    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        searchController.searchBar.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        mainView.commendTableView.delegate = self
        mainView.commendTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        mainView.commendTableView.rowHeight = 330
        
        bind()
    }

    func bind() {
        guard let text = searchController.searchBar.text else { return }
        
        let input = SearchViewModel.input(searchButtonClicked: searchController.searchBar.rx.searchButtonClicked, cancelButtonClicked: searchController.searchBar.rx.cancelButtonClicked, keyWord: text)
        let output = viewModel.translation(input: input)
        
        output.searchButtonClicked.subscribe(with: self) { owner, value in
                guard let text = owner.searchController.searchBar.text else { return }

                let vc = UINavigationController(rootViewController: SearchViewController(text: text))
            vc.modalPresentationStyle = .overFullScreen
            owner.present(vc, animated: false)
        }.disposed(by: disposeBag)
        
        output.cancelButtonClicked.subscribe(with: self) { owner, value in
            owner.dismiss(animated: false)
        }.disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<AppdataModel> { [weak self] dataSource, tableView, indexPath, item in
            guard let self, let cell = mainView.commendTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }

            UIImage().stringURLConversion(stringURL: item.artworkUrl512) { image in
                DispatchQueue.main.async {
                    cell.appImage.image = image
                }
            }
            
            cell.titleLabel.text = item.trackName
            cell.descriptionLabel.text = item.description
            cell.selectionStyle = .none
            
            let rating = String(format:"%.1f", item.averageUserRating)
           cell.ratingLabel.text = rating
            
            //라벨 이미지
            let attributedString = NSMutableAttributedString()
               
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "person.crop.square")
            let imageString = NSAttributedString(attachment: imageAttachment)
            attributedString.append(imageString)
           
           let textString = NSAttributedString(string: " " + item.sellerName)
           attributedString.append(textString)
           cell.sellerNameLabel.attributedText = attributedString

           cell.genreLabel.text = item.genres[0]
            
            for (index, stringURL) in item.screenshotUrls.enumerated() {
                guard index < 3 else { break }
                
                UIImage().stringURLConversion(stringURL: stringURL) { image in
                    guard let image else { return }

                    DispatchQueue.main.async {
                        // 가로 체크
                        if image.size.width > image.size.height {
                            cell.previewImage01.image = image
                            cell.horizontalImageSetting()
                            return
                        } else {
                            switch index {
                            case 0: cell.previewImage01.image = image
                            case 1: cell.previewImage02.image = image
                            case 2: cell.previewImage03.image = image
                            default: break
                            }
                        }
                    }
                }
            }

            cell.descriptionLabel.text = item.description
            cell.downLoadButton.tag = indexPath.row
            cell.selectionStyle = .none
            
            return cell
        }

        output.data.flatMapLatest { [weak self] data in
            let searchAppData = [AppdataModel(headerTitle: "", items: data)]
            self?.tableData = searchAppData[0].items
            return Observable.just(searchAppData)
        }.bind(to: mainView.commendTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(trackId: tableData[indexPath.item].trackId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
