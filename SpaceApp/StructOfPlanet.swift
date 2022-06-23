import Foundation

struct PlanetStruct: Codable {
    let collection: CollectionStruct
}

struct CollectionStruct: Codable {
    let version: String
    let href: String
    let items: [ItemStruct]
    let metadata: MetadataStruct
    let links: [CollectionLinkStruct]?
}

struct ItemStruct: Codable {
    let href: String
    let data: [DatumStruct]
    let links: [ItemLinkStruct]?
}

struct DatumStruct: Codable {
    let center, title, nasaID: String?
    let dateCreated: String
    let keywords: [String]?
    let mediaType, description508, secondaryCreator, datumDescription, location, photographer: String?
    let album: [String]?

    enum CodingKeys: String, CodingKey {
        case center, title, album, location, photographer
        case nasaID = "nasa_id"
        case dateCreated = "date_created"
        case keywords
        case mediaType = "media_type"
        case description508 = "description_508"
        case secondaryCreator = "secondary_creator"
        case datumDescription = "description"
    }
}

struct ItemLinkStruct: Codable {
    let href: String
    let rel, render: String?
}

struct CollectionLinkStruct: Codable {
    let rel, prompt: String
    let href: String
}

struct MetadataStruct: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}
