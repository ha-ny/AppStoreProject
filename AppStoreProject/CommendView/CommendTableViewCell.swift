//
//  CommendTableViewCell.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import UIKit

final class CommendTableViewCell: BaseCell {

    var appImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.8
        return view
    }()
    
    var titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15.5)
        view.numberOfLines = 2
        return view
    }()
    
    var descriptionLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12.5)
        view.textColor = .systemGray3
        view.numberOfLines = 1
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
    
    var lineView = {
        let view = UILabel()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    override func setConfiguration() {
        contentView.addSubview(appImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(downLoadButton)
        contentView.addSubview(lineView)
    }
    
    override func setConstraints() {
        appImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(7)
            make.left.equalTo(contentView).inset(22)
            make.width.equalTo(appImage.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(11)
            make.left.equalTo(appImage.snp.right).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0.5)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(contentView).offset(3)
        }
        
        downLoadButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(24)
            make.size.equalTo(CGSize(width: 68, height: 25))
            make.left.equalTo(descriptionLabel.snp.right).offset(24)
            make.left.equalTo(titleLabel.snp.right).offset(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.4)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(downLoadButton)
            make.bottom.equalTo(contentView)
        }
    }
}
