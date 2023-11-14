//
//  BaseCell.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/14.
//

import UIKit
import SnapKit

class BaseCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfiguration()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfiguration() { }
    func setConstraints() { }
}
