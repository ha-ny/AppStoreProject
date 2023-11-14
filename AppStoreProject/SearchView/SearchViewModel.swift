//
//  SearchViewModel.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/14.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    private let apiManager = APIManager.shared
    private var disposeBag = DisposeBag()
    
    struct input {
        var searchButtonClicked: ControlEvent<Void>
        var cancelButtonClicked: ControlEvent<Void>
        var keyWord: String
    }
    
    struct output {
        var data = BehaviorSubject(value: [Appdata]())
        var searchButtonClicked: ControlEvent<Void>
        var cancelButtonClicked: ControlEvent<Void>
    }
    
    func translation(input: input) -> output {
        let output = output(searchButtonClicked: input.searchButtonClicked, cancelButtonClicked: input.cancelButtonClicked)
        
        apiRequest(keyword: input.keyWord) { data in
            output.data.onNext(data)
        }

        return output
    }
    
    func apiRequest(keyword: String, data: @escaping ([Appdata]) -> ()) {
        apiManager.requestAPI(keyWord: keyword, limit: 20, completion: { value in
            guard let value else { return }
            data(value.results)
        })
    }
}
