//
//  SearchTableViewCell.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseCell {

    var appImage = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 0.2
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
    
    let preview = UIView()
    
    let ratingLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .darkGray
        view.textAlignment = .left
        return view
    }()
    
    let sellerNameLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .darkGray
        view.textAlignment = .left
        return view
    }()
    
    let genreLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .darkGray
        view.textAlignment = .right
        return view
    }()
    
    let previewImage01 = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.8
        return view
    }()
    
    let previewImage02 = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.8
        return view
    }()
    
    let previewImage03 = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.8
        return view
    }()
    
    func horizontalImageSetting() {
        previewImage02.isHidden = true
        previewImage03.isHidden = true
        
        previewImage01.snp.removeConstraints()
        previewImage01.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(preview)
        }
    }
    
    override func setConfiguration() {
        contentView.addSubview(appImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(downLoadButton)
        
        contentView.addSubview(preview)
        preview.addSubview(ratingLabel)
        preview.addSubview(genreLabel)
        preview.addSubview(sellerNameLabel)
        preview.addSubview(previewImage01)
        preview.addSubview(previewImage02)
        preview.addSubview(previewImage03)
    }
    
    override func setConstraints() {
        appImage.snp.makeConstraints { make in
            make.top.equalTo(self).inset(7)
            make.left.equalTo(self).inset(22)
            make.size.equalTo(60)
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
            make.top.equalTo(titleLabel.snp.bottom)
            make.right.equalTo(self).inset(24)
            make.size.equalTo(CGSize(width: 68, height: 25))
            make.left.equalTo(descriptionLabel.snp.right).offset(24)
            make.left.equalTo(titleLabel.snp.right).offset(24)
        }
        
        preview.snp.makeConstraints { make in
            make.top.equalTo(appImage.snp.bottom).offset(8)
            make.leading.equalTo(appImage.snp.leading)
            make.trailing.equalTo(downLoadButton)
            make.height.equalTo(240)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.top.equalTo(preview)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.left.equalTo(sellerNameLabel.snp.right).offset(24)
            make.right.top.equalTo(preview)
            make.bottom.equalTo(ratingLabel.snp.bottom)
            make.width.equalTo(85)
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.left.equalTo(ratingLabel.snp.right).offset(24)
            make.top.equalTo(preview.snp.top)
            make.bottom.equalTo(ratingLabel.snp.bottom)
            make.width.equalTo(100)
        }
        
        previewImage01.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(8)
            make.left.bottom.equalTo(preview)
            make.width.equalTo(preview.snp.width).multipliedBy(0.32)
            make.right.equalTo(previewImage02.snp.left).offset(-8)
        }
        
        previewImage02.snp.makeConstraints { make in
            make.top.equalTo(previewImage01.snp.top)
            make.bottom.equalTo(preview)
            make.width.equalTo(preview.snp.width).multipliedBy(0.32)
            make.right.equalTo(previewImage03.snp.left).offset(-8)
        }
        
        previewImage03.snp.makeConstraints { make in
            make.top.equalTo(previewImage01.snp.top)
            make.bottom.equalTo(preview)
            make.right.equalTo(preview.snp.right)
            make.width.equalTo(preview.snp.width).multipliedBy(0.32)
        }
    }
}
