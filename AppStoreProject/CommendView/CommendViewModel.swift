//
//  CommendViewModel.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/13.
//

import Foundation
import RxSwift
import RxCocoa

class CommendViewModel {
    
    private let apiManager = APIManager.shared
    private var disposeBag = DisposeBag()
    
    struct input {
        var searchButtonClicked: ControlEvent<Void>
    }
    
    struct output {
        var data = BehaviorSubject(value: [Appdata]())
        var searchButtonClicked: ControlEvent<Void>
    }
    
    func translation(input: input) -> output {
        let output = output(searchButtonClicked: input.searchButtonClicked)
        
        apiManager.requestAPI(keyWord: "추천앱", limit: 12, completion: { value in
                    guard let value else { return }
                    output.data.onNext(value.results)
                })

        return output
    }
}
