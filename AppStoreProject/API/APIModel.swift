//
//  APIModel.swift
//  AppStoreProject
//
//  Created by 김하은 on 2023/11/09.
//

import Foundation

struct SearchApp: Codable {
    let resultCount: Int
    let results: [Appdata]
}

struct Appdata: Codable {
    let trackId: Int //Id
    let screenshotUrls: [String] //앱 미리보기 스크린샷
    let trackName: String //이름
    let description: String //설명
    let genres: [String] //장르
    let trackContentRating: String //연령
    let price: Double // 가격
    let sellerName: String // 개발자 이름
    let userRatingCount: Int // 평가자 수
    let averageUserRating: Double // 평균 평점
    let artworkUrl512: String // 아이콘
    let languageCodesISO2A: [String] // 언어
    let releaseNotes: String //앱 설명
    let primaryGenreName: String
}
