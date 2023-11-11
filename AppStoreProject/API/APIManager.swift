//
//  APIManager.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func requestAPI(keyWord: String, limit: Int, completion: @escaping (SearchApp?) -> ()){
        let term =  keyWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let stringURL = "https://itunes.apple.com/search?term=\(term)&contry=KR&media=software&lang=ko&limit=\(limit)"
        
        AF.request(stringURL).responseDecodable(of: SearchApp.self) { request in
            switch request.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
        
//        guard let url = URL(string: stringURL) else { return completion(nil) }
//
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
//            guard let data else { return completion(nil) }
//            if let error { return completion(nil) }
//
//            do {
//                let resultData = try JSONDecoder().decode(SearchApp.self, from: data)
//                completion(resultData)
//            } catch { }
//        }
//        task.resume()
    }

}
