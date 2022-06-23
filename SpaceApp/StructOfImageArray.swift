//
//  StructOfImageArray.swift
//  SpaceApp
//
//  Created by 庄子優太 on 2022/06/22.
//

import Foundation
import UIKit

struct TravelImageArrayStruct {
    let planet: String
    let date: String
    let title: String
    let description: String
    let imagePath: UIImage
}

struct EarthImageArrayStruct {
    let time: String
    let imagePath: UIImage
    let lat: Double
    let lon: Double
    let sunPositionX: Double
    let sunPositionY: Double
    let sunPositionZ: Double
    let lunarPositionX: Double
    let lunarPositionY: Double
    let lunarPositionZ: Double
}
