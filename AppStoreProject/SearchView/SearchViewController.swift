//
//  SearchViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import UIKit

final class SearchViewController: UIViewController {

    lazy var searchController = {
        let view = UISearchController()
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        view.searchBar.showsCancelButton = true
        return view
    }()
    
    private let mainView = CommendView()
    private let apiManager = APIManager.shared
    private var data: SearchApp? {
        didSet {
            mainView.commendTableView.reloadData()
        }
    }

    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        searchController.searchBar.text = text
        dataSetting(text: text)
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
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        mainView.commendTableView.delegate = self
        mainView.commendTableView.dataSource = self
        mainView.commendTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        mainView.commendTableView.rowHeight = 330
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }

    
    func dataSetting(text: String) {
        apiManager.requestAPI(keyWord: text, limit: 25, completion: { data in
            self.data = data
        })
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        dataSetting(text: text)
        mainView.commendTableView.scrollsToTop = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: false)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data, let cell = mainView.commendTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
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
        
        let rating = String(format:"%.1f", result.averageUserRating)
       cell.ratingLabel.text = rating
        
        //라벨 이미지
        let attributedString = NSMutableAttributedString()
           
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "person.crop.square")
        let imageString = NSAttributedString(attachment: imageAttachment)
        attributedString.append(imageString)
       
       let textString = NSAttributedString(string: " " + result.sellerName)
       attributedString.append(textString)
       cell.sellerNameLabel.attributedText = attributedString

       cell.genreLabel.text = result.genres[0]
        
        for (index, stringURL) in result.screenshotUrls.enumerated() {
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

        cell.descriptionLabel.text = result.description
        cell.downLoadButton.tag = indexPath.row
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data else { return }
        let vc = DetailViewController(trackId: data.results[indexPath.item].trackId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
