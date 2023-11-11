//
//  CommendView.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/08.
//

import UIKit

final class CommendView: BaseView {
    
    let data = ["한글뷰어", "카트라이더", "쿠팡", "아마존", "Roblox", "카카오톡"]
    
    let commendTableHeaderView = UIView()
    
    let foundLabel = {
       let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 24)
        view.text = "새로운 발견"
        return view
    }()
    
    lazy var foundCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout())
        view.register(FoundCollectionViewCell.self, forCellWithReuseIdentifier: FoundCollectionViewCell.identifier)
        view.backgroundColor = .orange
        return view
     }()
    
    let commendLabel = {
       let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 24)
        view.text = "추천 앱과 게임"
        return view
    }()

    let commendTableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
     }()

    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.itemSize = CGSize(width: 80, height: 50)
        return layout
    }
    
    override func setConfiguration() {
        addSubview(commendTableView)
        commendTableView.addSubview(commendTableHeaderView)
        commendTableHeaderView.addSubview(foundLabel)
        commendTableHeaderView.addSubview(foundCollectionView)
        commendTableHeaderView.addSubview(commendLabel)
    }
    
    override func setConstraints() {
        commendTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self)
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        commendTableHeaderView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(commendTableView)
            make.height.equalTo(200)
        }
        
        foundLabel.snp.makeConstraints { make in
            make.top.equalTo(commendTableHeaderView).inset(8)
            make.left.equalTo(commendTableHeaderView).inset(14)
            make.height.equalTo(45)
        }
        
        foundCollectionView.snp.makeConstraints { make in
            make.top.equalTo(foundLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(commendTableHeaderView)
            make.height.equalTo(100)
        }
        
        commendLabel.snp.makeConstraints { make in
            make.top.equalTo(foundCollectionView.snp.bottom)
            make.left.equalTo(commendTableHeaderView).inset(14)
            make.height.equalTo(45)
            make.bottom.equalTo(self.snp.bottom).inset(4)
        }
    }
}

