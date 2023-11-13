//
//  DetailViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/12.
//

import UIKit

class DetailViewController: UIViewController {

    private let mainView = DetailView()
    private let apiManager = APIManager.shared
    private var data: SearchApp?
    
    init(trackId: Int) {
        super.init(nibName: nil, bundle: nil)
        dataSetting(text: "\(trackId)")
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
        navigationItem.largeTitleDisplayMode = .never
        mainView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    @objc func shareButtonTapped() {
        guard let data else { return }
        let result = data.results[0]
        
        let url = "https://apps.apple.com/app/\(result.trackId)"
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    func dataSetting(text: String) {
        apiManager.requestAPI(keyWord: text, limit: 1, completion: { data in
            self.data = data
            self.viewSetting()
        })
    }
    
    func viewSetting() {
        guard let data else { return }
        let result = data.results[0]
        
        UIImage().stringURLConversion(stringURL: result.artworkUrl512) { image in
            DispatchQueue.main.async {
                self.mainView.appImage.image = image
            }
        }

        mainView.titleLabel.text = result.trackName
        mainView.ageLabel.text = "\(result.trackContentRating)"
        
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let userRatingCount = numberFormatter.string(for: result.userRatingCount) ?? "0"
        mainView.ratingTitle.text = "\(userRatingCount)개의 평가"

        let rating = String(format:"%.1f", result.averageUserRating)
        mainView.ratingLabel.text = "\(rating)"
        
        mainView.languageTitle.text = "+ \(result.languageCodesISO2A.count)개의 언어"
        mainView.languageLabel.text = result.languageCodesISO2A[0]
        mainView.addVersionLabel.text = "[\(result.version)] \(result.releaseNotes)"
        mainView.functionDescription.text = "\(result.description)"
    }
}
