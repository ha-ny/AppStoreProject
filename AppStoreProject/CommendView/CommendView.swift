//
//  CommendView.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

class CommendView: BaseView {

    let searchBar = {
        let view = UISearchController()
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchBar.setValue("취소", forKey: "cancelButtonText")
        return view
    }()

    let commendTableHeaderView = UIView()
    
    let commendLabel = {
       let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 24)
        view.text = "추천 앱과 게임"
        return view
    }()
    
    let commendTableView = {
        let view = UITableView()
        view.rowHeight = 70
        view.separatorStyle = .none
        return view
     }()

    override func setConfiguration() {
        addSubview(commendTableView)
        commendTableView.addSubview(commendTableHeaderView)
        commendTableHeaderView.addSubview(commendLabel)
    }
    
    override func setConstraints() {
        commendTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self)
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        commendTableHeaderView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(commendTableView)
            make.height.equalTo(100)
        }
        
        commendLabel.snp.makeConstraints { make in
            make.top.equalTo(commendTableHeaderView).inset(8)
            make.left.equalTo(commendTableHeaderView).inset(14)
            make.height.equalTo(45)
        }
    }
}
