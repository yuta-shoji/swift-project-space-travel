//
//  NasaStrudct.swift
//  SpaceApp
//
//  Created by 庄子優太 on 2022/06/18.
//

//今日の宇宙API構造化
struct TodaysSpaseStruct: Codable {
    let copyright, date, explanation, hdurl, media_type, service_version, title, url: String
}
