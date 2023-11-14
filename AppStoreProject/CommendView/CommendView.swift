//
//  CommendView.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

final class CommendView: BaseView {

    let commendTableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.rowHeight = 70
        return view
     }()

    override func setConfiguration() {
        addSubview(commendTableView)
    }
    
    override func setConstraints() {
        commendTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

