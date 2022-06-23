//
//  TodaysEarthStruct.swift
//  SpaceApp
//
//  Created by 庄子優太 on 2022/06/20.
//

//今日の地球API構造化
struct TodaysEarthObjStruct: Codable {
    let identifier, caption, image, version: String
    let centroidCoordinates: LatLonStruct
    let dscovrJ2000Position, lunarJ2000Position, sunJ2000Position: XYZStruct
    let attitudeQuaternions: AttitudeStruct
    let date: String
    let coords: Coords

    enum CodingKeys: String, CodingKey {
        case identifier, caption, image, version
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
        case date, coords
    }

}

struct LatLonStruct: Codable {
    let lat, lon: Double
}

struct XYZStruct: Codable {
    let x, y, z: Double
}

struct AttitudeStruct: Codable {
    let q0, q1, q2, q3: Double
}

struct Coords: Codable {
    let centroidCoordinates: LatLonStruct
    let dscovrJ2000Position: XYZStruct
    let lunarJ2000Position: XYZStruct
    let sunJ2000Position: XYZStruct
    let attitudeQuaternions: AttitudeStruct

    enum CodingKeys: String, CodingKey {
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
    }
}

typealias TodaysEarthOuterStruct = [TodaysEarthObjStruct]
