//
//  DetailView.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/12.
//

import UIKit

class DetailView: BaseView {

    var appImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.8
        return view
    }()
    
    var titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 22)
        view.numberOfLines = 0
        view.sizeToFit()
        return view
    }()
    
    var downLoadButton = {
        let view = UIButton()
        view.backgroundColor = .systemGray6
        view.setTitleColor(UIColor.systemBlue, for: .normal)
        view.setTitle("받기", for: .normal)
        view.layer.cornerRadius = 13
        view.titleLabel?.font =  .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let shareButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        return view
    }()
    
    let lineViewTop = {
        let view = UILabel()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let lineViewCenter = {
        let view = UILabel()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let ageTitle = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .lightGray
        view.textAlignment = .center
        view.text = "연령"
        return view
    }()

    let ageLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    let lineViewside1 = {
        let view = UILabel()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let ratingTitle = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .lightGray
        view.textAlignment = .center
        return view
    }()
    
    let ratingLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    let lineViewside2 = {
        let view = UILabel()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let languageTitle = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .lightGray
        view.textAlignment = .center
        return view
    }()
    
    let languageLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    var addVersionTitle = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.text = "최신 버전"
        view.textColor = .darkGray
        view.sizeToFit()
        return view
    }()
    
    var addVersionLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let lineViewBottom = {
        let view = UILabel()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let functionDescription = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 13)
        view.isEditable = false
        view.isSelectable = false
        return view
    }()
    
    override func setConfiguration() {
        addSubview(titleLabel)
        addSubview(appImage)
        addSubview(downLoadButton)
        addSubview(shareButton)
        addSubview(lineViewTop)
        
        addSubview(ageTitle)
        addSubview(ageLabel)
        addSubview(lineViewside1)
        addSubview(ratingTitle)
        addSubview(ratingLabel)
        addSubview(lineViewside2)
        addSubview(languageTitle)
        addSubview(languageLabel)
        addSubview(lineViewCenter)
        
        addSubview(addVersionTitle)
        addSubview(addVersionLabel)
        addSubview(lineViewBottom)
        
        addSubview(functionDescription)
    }

    override func setConstraints() {
        appImage.snp.makeConstraints { make in
            make.left.equalTo(self).offset(8)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.width.equalTo(100)
            make.height.equalTo(appImage.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(appImage.snp.top)
            make.left.equalTo(appImage.snp.right).offset(14)
            make.right.equalTo(self).inset(8)
        }
        
        downLoadButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.size.equalTo(CGSize(width: 68, height: 25))
        }

        shareButton.snp.makeConstraints { make in
            make.top.equalTo(downLoadButton.snp.top)
            make.trailing.equalTo(titleLabel.snp.trailing).inset(8)
            make.height.equalTo(35)
        }
        
        lineViewTop.snp.makeConstraints { make in
            make.top.equalTo(appImage.snp.bottom).offset(12)
            make.leading.equalTo(appImage.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(0.7)
        }
        
        ageTitle.snp.makeConstraints { make in
            make.top.equalTo(lineViewTop.snp.bottom).offset(6)
            make.leading.equalTo(appImage.snp.leading)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(ageTitle.snp.bottom).offset(6)
            make.leading.equalTo(ageTitle.snp.leading)
            make.width.equalTo(ageTitle.snp.width)
        }
        
        lineViewside1.snp.makeConstraints { make in
            make.top.equalTo(ageTitle.snp.bottom)
            make.left.equalTo(ageTitle.snp.right)
            make.bottom.equalTo(ageLabel.snp.bottom)
            make.width.equalTo(0.7)
        }
        
        ratingTitle.snp.makeConstraints { make in
            make.top.equalTo(ageTitle.snp.top)
            make.left.equalTo(lineViewside1.snp.right)
            make.right.equalTo(lineViewside2.snp.left)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingTitle.snp.bottom).offset(6)
            make.leading.equalTo(ratingTitle.snp.leading)
            make.width.equalTo(ratingTitle.snp.width)
        }
        
        lineViewside2.snp.makeConstraints { make in
            make.top.equalTo(ratingTitle.snp.bottom)
            make.left.equalTo(ratingTitle.snp.right)
            make.bottom.equalTo(ratingLabel.snp.bottom)
            make.width.equalTo(0.7)
        }
        
        languageTitle.snp.makeConstraints { make in
            make.top.equalTo(ratingTitle.snp.top)
            make.left.equalTo(ratingTitle.snp.right)
            make.trailing.equalTo(lineViewTop.snp.trailing)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(languageTitle.snp.bottom).offset(6)
            make.leading.equalTo(languageTitle.snp.leading)
            make.width.equalTo(languageTitle.snp.width)
        }
        
        lineViewCenter.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(6)
            make.leading.equalTo(appImage.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(0.7)
        }
        
        addVersionTitle.snp.makeConstraints { make in
            make.top.equalTo(lineViewCenter.snp.bottom).offset(8)
            make.leading.equalTo(lineViewCenter.snp.leading)
        }
        
        addVersionLabel.snp.makeConstraints { make in
            make.leading.equalTo(addVersionTitle.snp.leading)
            make.trailing.equalTo(lineViewBottom.snp.trailing)
            make.top.equalTo(addVersionTitle.snp.bottom).offset(8)
        }
        
        lineViewBottom.snp.makeConstraints { make in
            make.top.equalTo(addVersionLabel.snp.bottom).offset(12)
            make.leading.equalTo(appImage.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(0.7)
        }

        functionDescription.snp.makeConstraints {  make in
            make.top.equalTo(lineViewBottom.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
}
