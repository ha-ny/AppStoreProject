//
//  UIImage+Extension.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import UIKit

extension UIImage {
    func stringURLConversion(stringURL: String, completion: @escaping (UIImage?) -> ()){
        guard let url = URL(string: stringURL) else { return completion(nil) }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return completion(nil) }
            
            if let image = UIImage(data: data) {
                return completion(image)
            } else {
                return completion(nil)
            }
        }
    }
}
