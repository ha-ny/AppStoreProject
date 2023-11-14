//
//  DetailViewModel.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/14.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    private let apiManager = APIManager.shared
    private var disposeBag = DisposeBag()
    
    struct input {
        var shareButtonTap: ControlEvent<Void>
        var keyWord: String
    }
    
    struct output {
        var data = BehaviorSubject(value: [Appdata]())
        var shareButtonTap: ControlEvent<Void>
    }
    
    func translation(input: input) -> output {
        let output = output(shareButtonTap: input.shareButtonTap)
        
        apiManager.requestAPI(keyWord: input.keyWord, limit: 1, completion: { value in
            guard let value else { return }
            output.data.onNext(value.results)
        })
        
        return output
    }
}
