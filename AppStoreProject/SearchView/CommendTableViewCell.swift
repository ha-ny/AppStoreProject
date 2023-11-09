//
//  CommendTableViewCell.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import UIKit
import SnapKit

class CommendTableViewCell: UITableViewCell {

    var appImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        return view
    }()
    
    var titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 2
        return view
    }()
    
    var descriptionLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .systemGray3
        view.numberOfLines = 1
        return view
    }()
    
    var downLoadButton = {
        let view = UIButton()
        view.backgroundColor = .systemGray5
        view.setTitleColor(UIColor.systemBlue, for: .normal)
        view.setTitle("받기", for: .normal)
        view.layer.cornerRadius = 13
        return view
    }()
        

    func cellSetting() {
        setConfiguration()
        setConstraints()
    }
    
    func setConfiguration() {
        contentView.addSubview(appImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(downLoadButton)
    }
    
    func setConstraints() {
        appImage.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(self).inset(16)
            make.size.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(8)
            make.left.equalTo(appImage.snp.right).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        downLoadButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self).inset(14)
            make.size.equalTo(CGSize(width: 60, height: 25))
            make.left.equalTo(descriptionLabel.snp.right).offset(24)
            make.left.equalTo(titleLabel.snp.right).offset(24)
        }
    }
}
