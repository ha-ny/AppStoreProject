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
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
    
    func cellSetting() {
        setConfiguration()
        setConstraints()
    }
    
    func setConfiguration() {
        contentView.addSubview(appImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(downLoadButton)
        contentView.addSubview(lineView)
    }
    
    func setConstraints() {
        appImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(7)
            make.left.equalTo(self).inset(22)
            make.width.equalTo(appImage.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(11)
            make.left.equalTo(appImage.snp.right).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        downLoadButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self).inset(24)
            make.size.equalTo(CGSize(width: 68, height: 25))
            make.left.equalTo(descriptionLabel.snp.right).offset(24)
            make.left.equalTo(titleLabel.snp.right).offset(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(downLoadButton)
            make.bottom.equalTo(self)
        }
    }
}
