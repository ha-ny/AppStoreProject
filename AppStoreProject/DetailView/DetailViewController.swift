//
//  DetailViewController.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/12.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    private let mainView = DetailView()
    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()
    private var data: Appdata?

    private var trackId = ""
    
    init(trackId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.trackId = "\(trackId)"
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
        bind()
    }
    
    func bind() {
        let input = DetailViewModel.input(shareButtonTap: mainView.shareButton.rx.tap, keyWord: trackId)
        let output = viewModel.translation(input: input)

        output.data.flatMapLatest { [weak self] data -> Observable<[Appdata]> in
            self?.data = data.first
            return Observable.just(data)
        }.subscribe(onNext: { [weak self] _ in
            self?.viewSetting()
        })
        .disposed(by: disposeBag)

        output.shareButtonTap.bind { [weak self] _ in
            guard let self, let data else { return }
            let url = "https://apps.apple.com/app/\(data.trackId)"
            
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            present(activityViewController, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func viewSetting() {
        guard let data else { return }

        UIImage().stringURLConversion(stringURL: data.artworkUrl512) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                mainView.appImage.image = image
            }
        }

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            mainView.titleLabel.text = data.trackName
            mainView.ageLabel.text = "\(data.trackContentRating)"
            
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let userRatingCount = numberFormatter.string(for: data.userRatingCount) ?? "0"
            mainView.ratingTitle.text = "\(userRatingCount)개의 평가"

            let rating = String(format:"%.1f", data.averageUserRating)
            mainView.ratingLabel.text = "\(rating)"
            
            mainView.languageTitle.text = "+ \(data.languageCodesISO2A.count)개의 언어"
            mainView.languageLabel.text = data.languageCodesISO2A[0]
            mainView.addVersionLabel.text = "[\(data.version)] \(data.releaseNotes)"
            mainView.functionDescription.text = "\(data.description)"
        }
    }
}
