//
//  ListingModel.swift
//  ReelsDemoInUIkit
//
//  Created by Shounak Jindam on 02/08/24.
//

import Foundation

// MARK: - Welcome
struct ListingModel: Codable {
    let status: Int
    let applicationDomain, data: JSONNull?
    let content: Content
    let imagesData, authodata, nextPrev, entityData: JSONNull?
    let relatedArticle, message, responseStatus: JSONNull?
    let fetchfromcache, asycncall: Bool
    let time: JSONNull?
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case status
        case applicationDomain = "ApplicationDomain"
        case data, content
        case imagesData = "ImagesData"
        case authodata = "Authodata"
        case nextPrev = "NextPrev"
        case entityData = "EntityData"
        case relatedArticle = "RelatedArticle"
        case message
        case responseStatus = "response_status"
        case fetchfromcache, asycncall, time, meta
    }
}

// MARK: - Content
struct Content: Codable {
    let items: [Item]
    let pagination: ContentPagination
}

// MARK: - Item
struct Item: Codable {
    let tags: JSONNull?
    let assetID: Int
    let duration: String
    let authorID: Int
    let fullName: Name
    let userName: UserName
    let videoURL: String
    let createdBy: Int
    let imagePath, shortDesc: String
    let updatedBy: Int
    let assetTitle, priEntURL: String
    let secEntURL: SECEntURL
    let titleAlias, createdDate: String
    let displayName: Name
    let totalAssets: JSONNull?
    let updatedDate: String
    let assetListID, assetTypeID: Int
    let publishedDate, imageFileName, contentSourceID, priEntDispName: String
    let secEntDispName: SECName
    let primaryEntityName: String
    let secondaryEntityName: SECName
    let publishedVersionNumber, primaryEntityRoleMapID, secondaryEntityRoleMapID: Int

    enum CodingKeys: String, CodingKey {
        case tags
        case assetID = "asset_id"
        case duration
        case authorID = "author_id"
        case fullName = "full_name"
        case userName = "user_name"
        case videoURL = "video_url"
        case createdBy = "created_by"
        case imagePath = "image_path"
        case shortDesc = "short_desc"
        case updatedBy = "updated_by"
        case assetTitle = "asset_title"
        case priEntURL = "pri_ent_url"
        case secEntURL = "sec_ent_url"
        case titleAlias = "title_alias"
        case createdDate = "created_date"
        case displayName = "display_name"
        case totalAssets = "total_assets"
        case updatedDate = "updated_date"
        case assetListID = "asset_list_id"
        case assetTypeID = "asset_type_id"
        case publishedDate = "published_date"
        case imageFileName = "image_file_name"
        case contentSourceID = "content_source_id"
        case priEntDispName = "pri_ent_disp_name"
        case secEntDispName = "sec_ent_disp_name"
        case primaryEntityName = "primary_entity_name"
        case secondaryEntityName = "secondary_entity_name"
        case publishedVersionNumber = "published_version_number"
        case primaryEntityRoleMapID = "primary_entity_role_map_id"
        case secondaryEntityRoleMapID = "secondary_entity_role_map_id"
    }
}

enum Name: String, Codable {
    case webteam = "Webteam"
}

enum SECName: String, Codable {
    case videos = "Videos"
}

enum SECEntURL: String, Codable {
    case videos = "videos"
}

enum UserName: String, Codable {
    case webteam = "webteam"
}

// MARK: - ContentPagination
struct ContentPagination: Codable {
    let total, currentPage: Int

    enum CodingKeys: String, CodingKey {
        case total
        case currentPage = "current_page"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let pagination: MetaPagination
    let message: JSONNull?
}

// MARK: - MetaPagination
struct MetaPagination: Codable {
    let total, count, perPage, currentPage: Int
    let offset, limit, totalPages: Int
    let links: JSONNull?

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case offset, limit
        case totalPages = "total_pages"
        case links
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
