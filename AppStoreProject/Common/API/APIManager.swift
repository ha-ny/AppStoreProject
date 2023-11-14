//
//  APIManager.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func requestAPI(keyWord: String, limit: Int, completion: @escaping (SearchApp?) -> ()){
        let term =  keyWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let stringURL = "https://itunes.apple.com/search?term=\(term)&contry=KR&media=software&lang=ko&limit=\(limit)"

        guard let url = URL(string: stringURL) else { return completion(nil) }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data else { return completion(nil) }

            do {
                let resultData = try JSONDecoder().decode(SearchApp.self, from: data)
                completion(resultData)
            } catch { }
        }
        task.resume()
    }

}
