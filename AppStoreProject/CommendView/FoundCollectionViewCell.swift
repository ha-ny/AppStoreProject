//
//  FoundCollectionViewCell.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/11.
//

import UIKit
import SnapKit

class FoundCollectionViewCell: UICollectionViewCell {

    let image = {
       let view = UIImageView()
       view.image = UIImage(systemName: "magnifyingglass")
       return view
    }()
    
    var dataLabel = UILabel()
    
    let line = {
       let view = UILabel()
       view.backgroundColor = .systemGray4
       return view
    }()
    
    func cellSetting() {
        setConfiguration()
        setConstraints()
    }
    
    func setConfiguration() {
        contentView.addSubview(image)
        contentView.addSubview(dataLabel)
        contentView.addSubview(line)
    }
    
    func setConstraints() {
        image.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView).inset(4)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.left.equalTo(image).offset(8)
            make.top.bottom.equalTo(image)
            make.right.equalTo(contentView.snp.right)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(0.7)
            make.leading.equalTo(image.snp.left)
            make.trailing.equalTo(dataLabel.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
