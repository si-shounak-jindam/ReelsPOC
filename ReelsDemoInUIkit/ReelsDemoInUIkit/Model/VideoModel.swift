//
//  VideoModel.swift
//  ReelsDemoInUIkit
//
//  Created by Shounak Jindam on 01/08/24.
//

import Foundation

// MARK: - SIFeedsDetailModel
public struct SIFeedsDetailModel: Codable {
    public var status: Int?
    public var content: SIFeedsDetailContent?
    public var imagesData: SIFeedsDetailImagesData?
    public var nextPrev: SIFeedsDetailNextPrev?
    public var meta: SIFeedsDetailMeta?
    
    enum CodingKeys: String, CodingKey {
        case status
        case content
        case imagesData = "ImagesData"
        case nextPrev = "NextPrev"
        case meta
    }
}

// MARK: - SIFeedsDetailAuthodata
public struct SIFeedsDetailAuthodata: Codable {
    public let authors: [SIFeedsDetailAuthor]?
}

// MARK: - SIFeedsDetailAuthor
public struct SIFeedsDetailAuthor: Codable {
    public let userID: Int?
    public let fullName, userName, displayName: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case fullName = "full_name"
        case userName = "user_name"
        case displayName = "display_name"
    }
}

// MARK: - SIFeedsDetailContent
public struct SIFeedsDetailContent: Codable {
    public let data: SIFeedsDetailDataClass?
}

// MARK: - SIFeedsDetailDataClass
public struct SIFeedsDetailDataClass: Codable {
    public let contentSourceID, guid, assetType: String?
    public let articleID: String?
    public let title, desc: String?
    public let titleAlias, videoUrl: String?
    public let duration: String?
    public let shortTitle: String?
    public let shortURL: String?
    public let highlights: [String]?
    public let browserTitle, introText, isPublish, fullText: String?
    public let place, country, imageThumb, mobileDescText: String?
    public let createdDate, modifiedDate: String?
    public let publishedDate: String?
    public let publishedDateIst: String?
    public let status: String?
    public let slugTitle: String?
    public let slugURL: String?
    public let authorURL, authorText: String?
    public let createdBy, editedBy, versionNumber, isTrashed: String?
    public let entitydata: [SIFeedsDetailEntityData]?
    public let showCopyright, showInWeb, showInMobile, contentSourceLink: String?
    public let imageFileName, imagePath, imageID: String?
    public let checkedOutBy, checkedOutByName: String?
    public let contentProviderName: String?
    public let contentProviderLogo: String?
    public let createdByName, imagedata, parentArticleID: String?
    public let focusByKeywords: [SIFeedsDetailFocusByKeyword]?
    public let parentArticleTitle, editedByName, isLiveBlog: String?
    public let assetTypeID: String?
    public let chkSendNotification: Bool?
    public let league: String?
    public let isFeaturedImage: String?
    public let isDefaultImage: String?
    public let albumId, albumDesc, albumType: String?
    public let videoId: String?
    public let images: [SIFeedsDetailImagesData]?
    public let relatedData: SIFeedsDetailNextPrev?
    public let hlsVideoUrl: String?
    public let relatedItems: [SIFeedsListingItem]?
    public let coverDetails: SIFeedsDetailCoverDetails?
    public let additionalInfo: SIFeedsDetailAdditionalInfo?
    
    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case desc
        case contentSourceID = "content_source_id"
        case guid
        case assetType = "asset_type"
        case duration
        case title
        case titleAlias = "title_alias"
        case videoUrl = "video_url"
        case shortTitle = "short_title"
        case highlights
        case shortURL = "short_url"
        case browserTitle = "browser_title"
        case introText = "intro_text"
        case isPublish = "is_publish"
        case fullText = "full_text"
        case place, country
        case imageThumb = "image_thumb"
        case mobileDescText = "mobile_desc_text"
        case createdDate = "created_date"
        case modifiedDate = "modified_date"
        case publishedDate = "published_date"
        case publishedDateIst = "published_date_ist"
        case status
        case slugTitle = "slug_title"
        case slugURL = "slug_url"
        case authorURL = "author_url"
        case authorText = "author_text"
        case createdBy = "created_by"
        case editedBy = "edited_by"
        case versionNumber = "version_number"
        case isTrashed = "is_trashed"
        case entitydata
        case showCopyright = "show_copyright"
        case showInWeb = "show_in_web"
        case showInMobile = "show_in_mobile"
        case contentSourceLink = "content_source_link"
        case imageFileName = "image_file_name"
        case imagePath = "image_path"
        case imageID = "image_id"
        case checkedOutBy = "checked_out_by"
        case checkedOutByName = "checked_out_by_name"
        case contentProviderName = "content_provider_name"
        case contentProviderLogo = "content_provider_logo"
        case createdByName = "created_by_name"
        case imagedata
        case focusByKeywords = "focus_by_keywords"
        case parentArticleID = "parent_article_id"
        case parentArticleTitle = "parent_article_title"
        case editedByName = "edited_by_name"
        case isLiveBlog = "is_live_blog"
        case assetTypeID = "asset_type_id"
        case chkSendNotification, league
        case isDefaultImage = "is_default_image"
        case isFeaturedImage = "is_featured_image"
        case albumId = "album_id"
        case albumDesc = "album_desc"
        case albumType = "album_type"
        case videoId = "video_id"
        case images
        case relatedData = "related_data"
        case hlsVideoUrl = "hls_url"
        case relatedItems = "related_items"
        case coverDetails = "CoverDetails"
        case additionalInfo = "AdditionalInfo"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articleID = try container.decodeIfPresent(String.self, forKey: .articleID)
        self.contentSourceID = try container.decodeIfPresent(String.self, forKey: .contentSourceID)
        self.guid = try container.decodeIfPresent(String.self, forKey: .guid)
        self.assetType = try container.decodeIfPresent(String.self, forKey: .assetType)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.titleAlias = try container.decodeIfPresent(String.self, forKey: .titleAlias)
        self.videoUrl = try container.decodeIfPresent(String.self, forKey: .videoUrl)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        
        self.shortTitle = try container.decodeIfPresent(String.self, forKey: .shortTitle)
        self.highlights = try container.decodeIfPresent([String].self, forKey: .highlights)
        self.shortURL = try container.decodeIfPresent(String.self, forKey: .shortURL)
        
        self.browserTitle = try container.decodeIfPresent(String.self, forKey: .browserTitle)
        self.introText = try container.decodeIfPresent(String.self, forKey: .introText)
        self.isPublish = try container.decodeIfPresent(String.self, forKey: .isPublish)
        
        self.fullText = try container.decodeIfPresent(String.self, forKey: .fullText)
        self.place = try container.decodeIfPresent(String.self, forKey: .place)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        
        self.imageThumb = try container.decodeIfPresent(String.self, forKey: .imageThumb)
        self.mobileDescText = try container.decodeIfPresent(String.self, forKey: .mobileDescText)
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        self.publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate)
        
        self.modifiedDate = try container.decodeIfPresent(String.self, forKey: .modifiedDate)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.publishedDateIst = try container.decodeIfPresent(String.self, forKey: .publishedDateIst)
        self.slugTitle = try container.decodeIfPresent(String.self, forKey: .slugTitle)
        
        self.slugURL = try container.decodeIfPresent(String.self, forKey: .slugURL)
        self.authorURL = try container.decodeIfPresent(String.self, forKey: .authorURL)
        self.authorText = try container.decodeIfPresent(String.self, forKey: .authorText)
        self.createdBy = try container.decodeIfPresent(String.self, forKey: .createdBy)
        
        self.editedBy = try container.decodeIfPresent(String.self, forKey: .editedBy)
        self.versionNumber = try container.decodeIfPresent(String.self, forKey: .versionNumber)
        self.isTrashed = try container.decodeIfPresent(String.self, forKey: .isTrashed)
        self.entitydata = try container.decodeIfPresent([SIFeedsDetailEntityData].self, forKey: .entitydata)
        
        self.showCopyright = try container.decodeIfPresent(String.self, forKey: .showCopyright)
        self.showInWeb = try container.decodeIfPresent(String.self, forKey: .showInWeb)
        self.showInMobile = try container.decodeIfPresent(String.self, forKey: .showInMobile)
        self.contentSourceLink = try container.decodeIfPresent(String.self, forKey: .contentSourceLink)
        
        self.imageFileName = try container.decodeIfPresent(String.self, forKey: .imageFileName)
        self.imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
        self.imageID = try container.decodeIfPresent(String.self, forKey: .imageID)
        self.checkedOutBy = try container.decodeIfPresent(String.self, forKey: .checkedOutBy)
        self.checkedOutByName = try container.decodeIfPresent(String.self, forKey: .checkedOutByName)
        
        self.contentProviderName = try container.decodeIfPresent(String.self, forKey: .contentProviderName)
        self.contentProviderLogo = try container.decodeIfPresent(String.self, forKey: .contentProviderLogo)
        self.createdByName = try container.decodeIfPresent(String.self, forKey: .createdByName)
        self.imagedata = try container.decodeIfPresent(String.self, forKey: .imagedata)
        self.focusByKeywords = try container.decodeIfPresent([SIFeedsDetailFocusByKeyword].self, forKey: .focusByKeywords)
        self.parentArticleID = try container.decodeIfPresent(String.self, forKey: .parentArticleID)
        
        self.parentArticleTitle = try container.decodeIfPresent(String.self, forKey: .parentArticleTitle)
        self.editedByName = try container.decodeIfPresent(String.self, forKey: .editedByName)
        self.isLiveBlog = try container.decodeIfPresent(String.self, forKey: .isLiveBlog)
        self.assetTypeID = try container.decodeIfPresent(String.self, forKey: .assetTypeID)
        self.chkSendNotification = try container.decodeIfPresent(Bool.self, forKey: .chkSendNotification)
        
        self.league = try container.decodeIfPresent(String.self, forKey: .league)
        self.isFeaturedImage = try container.decodeIfPresent(String.self, forKey: .isFeaturedImage)
        self.isDefaultImage = try container.decodeIfPresent(String.self, forKey: .isDefaultImage)
        self.albumId = try container.decodeIfPresent(String.self, forKey: .albumId)
        self.albumDesc = try container.decodeIfPresent(String.self, forKey: .albumDesc)
        self.albumType = try container.decodeIfPresent(String.self, forKey: .albumType)
        
        self.images = try container.decodeIfPresent([SIFeedsDetailImagesData].self, forKey: .images)
        self.relatedData = try container.decodeIfPresent(SIFeedsDetailNextPrev.self, forKey: .relatedData)
        self.hlsVideoUrl = try container.decodeIfPresent(String.self, forKey: .hlsVideoUrl)
        self.relatedItems = try container.decodeIfPresent([SIFeedsListingItem].self, forKey: .relatedItems)
        self.coverDetails = try container.decodeIfPresent(SIFeedsDetailCoverDetails.self, forKey: .coverDetails)
        self.additionalInfo = try container.decodeIfPresent(SIFeedsDetailAdditionalInfo.self, forKey: .additionalInfo)
        
        do {
            self.videoId = try container.decodeIfPresent(String.self, forKey: .videoId)
        } catch {
            let numberName = try container.decode(Int.self, forKey: .videoId)
            self.videoId = String(numberName)
        }
    }
}

// MARK: - FocusByKeyword
public struct SIFeedsDetailFocusByKeyword: Codable {
    let id, slno: Int?
    let text, assetID: String?
    let priority: Int?
    let selected: Bool?
    let entityName, canonicalURL: String?
    let entDispName: String?
    let entityTypeID: String?
    let entityMasterID: Int?
    let entityTypeName, sourceObjectID: String?
    let entityOtherNames: String?
    let entityRoleMapID, entityDisplayName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, slno, text
        case assetID = "asset_id"
        case priority, selected
        case entityName = "entity_name"
        case canonicalURL = "canonical_url"
        case entDispName = "ent_disp_name"
        case entityTypeID = "entity_type_id"
        case entityMasterID = "entity_master_id"
        case entityTypeName = "entity_type_name"
        case sourceObjectID = "source_object_id"
        case entityOtherNames = "entity_other_names"
        case entityRoleMapID = "entity_role_map_id"
        case entityDisplayName = "entity_display_name"
    }
}

// MARK: - CoverDetails
public struct SIFeedsDetailCoverDetails: Codable {
    let url: String?
    let type: Int?
    let embededCode: String?
    let brightCodeVideoID: String?
    let wall: SIFeedsDetailCoverDetailsWall?
    
    enum CodingKeys: String, CodingKey {
        case url = "Url"
        case type = "Type"
        case embededCode = "Embed"
        case brightCodeVideoID = "VideoId"
        case wall
    }
}

enum SIFeedsDetailCoverDetailsWall: String, Codable {
    case subscriptionWall = "subscription_wall"
    case free = "free"
    case blank = ""
}

// MARK: - SIFeedsDetailEntityData
public struct SIFeedsDetailEntityData: Codable {
    public let priority, entityRoleMapID: Int?
    public let name: String?
    public let isVisible, isLinkable: String?
    public let assetID: Int?
    public let entDispName: String?
    public let isLang: String?
    public let canonical: String?
    public let contentCount: Int?
    public let entityTypeName: String?
    
    enum CodingKeys: String, CodingKey {
        case priority
        case entityRoleMapID = "entity_role_map_id"
        case name
        case isLinkable = "is_linkable"
        case isVisible = "is_visible"
        case assetID = "asset_id"
        case entDispName = "ent_disp_name"
        case isLang = "is_lang"
        case canonical
        case contentCount = "content_count"
        case entityTypeName = "entity_type_name"
    }
}

// MARK: - SIFeedsDetailImagesData
public struct SIFeedsDetailImagesData: Codable {
    public let data: SIFeedsDetailImageItem?
}

// MARK: - SIFeedsDetailImageItem
public struct SIFeedsDetailImageItem: Codable {
    public let title: String?
    public let status, imageID, isCover, imageName: String?
    public let imagePath: String?
    public let imageAlt: String?
    public let isActive, isDelete: String?
    public let imageDesc: String?
    public let phototypeid, positionID: Int?
    public let orderNumber: String?
    public let imageCaption: String?
    public let mobileImageID: String?
    public let imageCopyright: String?
    public let mobileImageName, mobileImagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case title, status
        case imageID = "image_id"
        case isCover = "is_cover"
        case imageName, imagePath
        case imageAlt = "image_alt"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case imageDesc = "image_desc"
        case phototypeid
        case positionID = "position_id"
        case orderNumber = "order_number"
        case imageCaption = "image_caption"
        case mobileImageID
        case imageCopyright = "image_copyright"
        case mobileImageName, mobileImagePath
    }
}

public struct SIFeedsDetailNextPrev: Codable {
    public let items: [SIFeedsListingItem]?
}

public struct SIFeedsDetailMeta: Codable {
    public let pagination: SIFeedsDetailPagination?
    public let message: String?
    
    enum CodingKeys: String, CodingKey {
        case pagination
        case message
    }
}

public struct SIFeedsDetailPagination: Codable {
    public let total, count, perPage, currentPage: Int?
    public let totalPages: Int?
    public let links: String?
    enum CodingKeys: String, CodingKey {
        case total
        case count
        case perPage
        case currentPage
        case totalPages
        case links
    }
}

// MARK: - AdditionalInfo
public struct SIFeedsDetailAdditionalInfo: Codable {
    public let customFieldValues: CustomFieldValues?
    
    enum CodingKeys: String, CodingKey {
        case customFieldValues = "custom_field_values"
    }
}

// MARK: - CustomFieldValues
public struct CustomFieldValues: Codable {
    let wall: SIFeedsDetailCoverDetailsWall?
    let branding, location, geoblockRestriction: String?
    let arenaMatchId: String?
    
    enum CodingKeys: String, CodingKey {
        case wall, branding, location
        case arenaMatchId = "arena_match_id"
        case geoblockRestriction = "geoblock_restriction"
    }
}

public struct SIFeedsListingModel: Codable {
    public var status: Int?
    public var content: SIFeedsListingContent?
    public var imagesData, authodata, nextPrev, entityData: String?
    public var relatedArticle, message: String?
    public var meta: SIFeedsListingMeta?
    
    enum CodingKeys: String, CodingKey {
        case status
        case content
        case imagesData = "ImagesData"
        case authodata = "Authodata"
        case nextPrev = "NextPrev"
        case entityData = "EntityData"
        case relatedArticle = "RelatedArticle"
        case message, meta
    }
}

public struct SIFeedsListingContent: Codable {
    public let items: [SIFeedsListingItem]?
    public let entitydata: [SIFeedsListingEntitydatum]?
}

public struct SIFeedsListingEntitydatum: Codable {
    public let name, canonicalURL: String?
    public let entityRoleMapID: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case canonicalURL = "canonical_url"
        case entityRoleMapID = "entity_role_map_id"
    }
}

public struct SIFeedsListingItem: Codable {
    public let rno: Int?
    public let duration: String?
    public let assetID: Int?
    public let authorID: Int?
    public let fullName: String?
    public let isActive: Int?
    public let userName: String?
    public let assetGUID: String?
    public let videoUrl: String?
    public let audioURL: String?
    public let createdBy: Int?
    public let imagePath: String?
    public let isDeleted, isTrashed: Int?
    public let shortDesc: String?
    public let updatedBy: Int?
    public let assetTitle: String?
    public let titleAlias, createdDate: String?
    public let displayName: String?
    public let isPublished: Int?
    public let totalAssets: Int?
    public let updatedDate: String?
    public let assetListID: Int?
    public let assetTypeID: SIFeedsAssetType?
    public let publishedDate: String?
    public let imageFileName: String?
    public let priEntDispName: String?
    public let secEntDispName: String?
    public let primaryEntityName: String?
    public let secondaryEntityName: String?
    public let secondaryEntityUrl: String?
    public let publishedVersionNumber, primaryEntityRoleMapID, secondaryEntityRoleMapID: Int?
    public let contentSourceID, contentProviderName, slugUrl: String?
    var focusByKeyword: [SIFeedsDetailFocusByKeyword]?
    
    enum CodingKeys: String, CodingKey {
        case rno, duration
        case assetID = "asset_id"
        case authorID = "author_id"
        case fullName = "full_name"
        case isActive = "is_active"
        case userName = "user_name"
        case assetGUID = "asset_guid"
        case videoUrl = "video_url"
        case audioURL = "audio_url"
        case createdBy = "created_by"
        case imagePath = "image_path"
        case isDeleted = "is_deleted"
        case isTrashed = "is_trashed"
        case shortDesc = "short_desc"
        case updatedBy = "updated_by"
        case assetTitle = "asset_title"
        case titleAlias = "title_alias"
        case createdDate = "created_date"
        case displayName = "display_name"
        case isPublished = "is_published"
        case totalAssets = "total_assets"
        case updatedDate = "updated_date"
        case assetListID = "asset_list_id"
        case assetTypeID = "asset_type_id"
        case publishedDate = "published_date"
        case imageFileName = "image_file_name"
        case priEntDispName = "pri_ent_disp_name"
        case secEntDispName = "sec_ent_disp_name"
        case primaryEntityName = "primary_entity_name"
        case secondaryEntityName = "secondary_entity_name"
        case publishedVersionNumber = "published_version_number"
        case primaryEntityRoleMapID = "primary_entity_role_map_id"
        case secondaryEntityRoleMapID = "secondary_entity_role_map_id"
        case secondaryEntityUrl = "sec_ent_url"
        case contentSourceID = "content_source_id"
        case contentProviderName = "content_provider_name"
        case focusByKeyword = "focus_by_keywords"
        case slugUrl = "slug_url"
    }
}

public struct SIFeedsListingMeta: Codable {
    public let pagination: SIFeedsListingPagination?
    public let message: String?
}

public struct SIFeedsListingPagination: Codable {
    public let total, count, perPage, currentPage: Int?
    public let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}

public enum SIFeedsAssetType: Int, Codable {
    case news = 1
    case photots = 2
    case videos = 4
    case podcasts = 29
    case unknown

    public init(from decoder: Decoder) throws {
        self = try SIFeedsAssetType(rawValue: decoder.singleValueContainer().decode(Int.self)) ?? .unknown
    }
}

public struct SILayoutBuilderModel: Codable {
    var status: Int?
    var content: SILayoutBuilderContent?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case status
        case content
        case message
    }
}

public struct SILayoutBuilderContent: Codable {
    var html, title: String?
    var module: [SILayoutBuilderWidget]?
    var pageID: Int?
    var titleApp, titleWeb, titleMobile, masterhtml: String?
    var languageID: Int?
    var isredirect, redirecturl, redirectparent: String?
    var templateID: Int?
    var masterTemplateID: Int?
    var isProtected: Bool?
    var parentID: Int?
    var pageEntity: [Int]?
    var languageName: String?
    var showData, showContent: Bool?
    var statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case html, title, module
        case pageID = "page_id"
        case titleApp = "title_app"
        case titleWeb = "title_web"
        case titleMobile = "title_mobile"
        case masterhtml
        case languageID = "language_id"
        case isredirect, redirecturl, redirectparent
        case templateID = "template_id"
        case masterTemplateID = "master_template_id"
        case isProtected = "is_protected"
        case parentID = "parent_id"
        case pageEntity = "page_entity"
        case languageName = "language_name"
        case showData = "show_data"
        case showContent = "show_content"
        case statusCode = "status_code"
    }

}

public struct SILayoutBuilderWidget: Codable {
    var title, selector: String
    var metaInfo: SILayoutBuilderModuleMetaInfo?
    var dependency: [SILayoutBuilderWidget]?
    var fetchFrom, templateID: Int?
    var widgetData: SILayoutBuilderWidgetData?
    var componentID: Int?
    var displayTitle: String?
    var otherEntities: [Int]?
    var requiredEntities: [Int]?
    var templateComponentMapID, showInApp, showInWeb, showInMobile: Int?

    enum CodingKeys: String, CodingKey {
        case title, selector
        case metaInfo = "meta_info"
        case dependency
        case fetchFrom = "fetch_from"
        case templateID = "template_id"
        case widgetData = "widget_data"
        case componentID = "component_id"
        case displayTitle = "display_title"
        case otherEntities = "other_entities"
        case requiredEntities = "required_entities"
        case templateComponentMapID = "template_component_map_id"
        case showInApp = "show_in_app"
        case showInWeb = "show_in_web"
        case showInMobile = "show_in_mobile"
    }

}

// MARK: - ModuleMetaInfo
struct SILayoutBuilderModuleMetaInfo: Codable {
    var view: String?
    var order: Int?
    var widgetOrder: Int?
    var lgCol, lgRow, mdCol, mdRow: String?
    var smCol, smRow, xlCol, xlRow: String?
    var xsCol, xsRow, extraData: String?
    var component: SIFeedsComponentName?
    var seriesID, showDate, showTitle, showAuthor: Int?
    var loadmoreType: String?

    var showCategory, showItemIcon, showDescription: Int?
    var widgetTitleTag, articleTitleTag: String?
    public var showitemIconContent: Int?
    public var showWidgetTitle: Bool?
    var articleDescriptionTag, widgetTitleTagAttributes, articleTitleTagAttributes, articleDescriptionTagAttributes: String?
    var fb: Int?
    var imgRatio: String?
    var isShare, showImage, isComments, isReactions: Bool?
    var showTagline, showTimestamp, showImageCount: Bool?
    var bannerLink: String?
    var bannerWidth, bannerHeight: Int?
    var bannerImgage: String?
    var formFields: [SILayoutBuilderModuleMetaInfoFormFieldDetail]?
    var formTitle: String?
    var apiConfig: SILayoutBuilderModuleMetaInfoApiConfig?
    var adUnitID: Int?
    var adUnitCode: String?
    var adPublisherCode: Int?
    var layoutdata:[SILayoutData]?
    var columnsConfig:[ColumnsConfig]?
    var highlightTeamId: Int?
    var bannerData: [BannerData]?
    var teams: [Team]?
    var moreText: String?
    let scorecard: Scorecard?
    let menuId : Int?
    var showMoreTitle: Bool?
    let entities: String?
    var otherent: String?
    var exclent : String?
    var pageNo : String?
    var pageSize : String?

    enum CodingKeys: String, CodingKey {
        case view, order
        case widgetOrder = "widget_order"
        case lgCol = "lg_col"
        case lgRow = "lg_row"
        case mdCol = "md_col"
        case mdRow = "md_row"
        case smCol = "sm_col"
        case smRow = "sm_row"
        case xlCol = "xl_col"
        case xlRow = "xl_row"
        case xsCol = "xs_col"
        case xsRow = "xs_row"
        case component, extraData
        case seriesID = "series_id"
        case showDate = "show_date"
        case showTitle = "show_title"
        case showAuthor = "show_author"
        case loadmoreType = "loadmore_type"
        case showCategory = "show_category"
        case showItemIcon = "show_item_icon"
        case showDescription = "show_description"
        case widgetTitleTag = "widget_title_tag"
        case articleTitleTag = "article_title_tag"
        case showWidgetTitle = "show_widget_title"
        case showitemIconContent = "showitem_icon_content"
        case articleDescriptionTag = "article_description_tag"
        case widgetTitleTagAttributes = "widget_title_tag_attributes"
        case articleTitleTagAttributes = "article_title_tag_attributes"
        case articleDescriptionTagAttributes = "article_description_tag_attributes"
        case fb, imgRatio
        case isShare = "is_share"
        case showImage = "show_image"
        case isComments = "is_comments"
        case isReactions = "is_reactions"
        case showTagline = "show_tagline"
        case showTimestamp = "show_timestamp"
        case showImageCount = "show_image_count"
        case bannerLink = "banner_link"
        case bannerWidth = "banner_width"
        case bannerHeight = "banner_height"
        case bannerImgage = "banner_imgage"
        case formFields = "form_fields"
        case formTitle = "form_title"
        case apiConfig = "api_config"
        case adUnitID = "ad_unit_id"
        case adUnitCode = "ad_unit_code"
        case adPublisherCode = "ad_publisher_code"
        case layoutdata = "layout_data"
        case columnsConfig = "columnsConfig"
        case highlightTeamId = "highlight_team_id"
        case bannerData = "banner_data"
        case teams = "teams"
        case moreText = "more_text"
        case scorecard
        case menuId = "menu_id"
        case showMoreTitle = "show_more_title"
        case entities
        case otherent
        case exclent
        case pageNo = "page_no"
        case pageSize = "page_size"
    }
}

// MARK: - BannerDatum
struct BannerData: Codable {
    let isWebview: Bool?
    let webviewURL: String?
    let bannerImage: String?
    let bannerOrder: Int?
    let inAppBrowser, isExternalWebview: Bool?
    let menuId: Int?
    let display_title : String?

    enum CodingKeys: String, CodingKey {
        case isWebview = "is_webview"
        case webviewURL = "webview_url"
        case bannerImage = "banner_image"
        case bannerOrder = "banner_order"
        case inAppBrowser = "in_app_browser"
        case isExternalWebview = "is_external_webview"
        case menuId = "menu_id"
        case display_title = "display_title"
    }
}

struct Scorecard: Codable {
    let menuID: Int?
    let isWebview: Bool?
    let webviewURL, displayTitle: String?
    let inAppBrowser, hasInteraction, isExternalWebview: Bool?
    
    enum CodingKeys: String, CodingKey {
        case menuID = "menu_id"
        case isWebview = "is_webview"
        case webviewURL = "webview_url"
        case displayTitle = "display_title"
        case inAppBrowser = "in_app_browser"
        case hasInteraction = "has_interaction"
        case isExternalWebview = "is_external_webview"
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let name, awards: String?
    let menuID: Int?
    let imagePath: String?
    let isWebview: Bool?
    let shortName: String?
    let webviewURL: String?
    let imageGradient: String?
    let inAppBrowser, isExternalWebview: Bool?
    let entities : String?
    let otherent : String?
    let exclent : String?
    let page_no : String?
    let page_size : String?

    enum CodingKeys: String, CodingKey {
        case id, name, awards
        case menuID = "menu_id"
        case imagePath = "image_path"
        case isWebview = "is_webview"
        case shortName = "short_name"
        case webviewURL = "webview_url"
        case imageGradient = "image_gradient"
        case inAppBrowser = "in_app_browser"
        case isExternalWebview = "is_external_webview"
        case entities = "entities"
        case otherent = "otherent"
        case exclent = "exclent"
        case page_no = "page_no"
        case page_size = "page_size"
    }
}

struct SILayoutData: Codable {
    var count: Int?
    var order: Int?
    var imgRatio: String?
    var aspect_ratio: String?
}

struct ColumnsConfig: Codable {
    let key: ColumnConfigKey?
    let title: String?
    let type: Int?
}

enum ColumnConfigKey: String, Codable {
    case pos = "pos"
    case short_name = "short_name"
    case p = "p"
    case w = "w"
    case l = "l"
    case nrr = "nrr"
    case pts = "pts"
    case form = "form"
    case other
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = ColumnConfigKey(rawValue: label) ?? .other
    }
    
}

struct SILayoutBuilderModuleMetaInfoFormFieldDetail: Codable {
    var type: String?
    var order: Int?
    var title: String?
    var fieldName: String?
    var isRequired: Bool?

    enum CodingKeys: String, CodingKey {
        case type, order, title
        case fieldName = "field_name"
        case isRequired = "is_required"
    }
}

struct SILayoutBuilderModuleMetaInfoApiConfig: Codable {
    var feedpath: String?
    enum CodingKeys: String, CodingKey {
        case feedpath
    }
}

struct SILayoutBuilderDependency: Codable {
    var lgCol, lgRow, mdCol, mdRow: String?
    var smCol, smRow, xlCol, xlRow: String?
    var xsCol, xsRow, extraData: String?
    var showDate, showTitle, showAuthor: Int?
    var loadmoreType: String?
    var showCategory, showItemIcon, showDescription: Int?
    var widgetTitleTag: String?
    var showitemIconContent: Int?
    var widgetTitleTagAttributes: String?

    enum CodingKeys: String, CodingKey {
        case lgCol = "lg_col"
        case lgRow = "lg_row"
        case mdCol = "md_col"
        case mdRow = "md_row"
        case smCol = "sm_col"
        case smRow = "sm_row"
        case xlCol = "xl_col"
        case xlRow = "xl_row"
        case xsCol = "xs_col"
        case xsRow = "xs_row"
        case extraData
        case showDate = "show_date"
        case showTitle = "show_title"
        case showAuthor = "show_author"
        case loadmoreType = "loadmore_type"
        case showCategory = "show_category"
        case showItemIcon = "show_item_icon"
        case showDescription = "show_description"
        case widgetTitleTag = "widget_title_tag"
        case showitemIconContent = "showitem_icon_content"
        case widgetTitleTagAttributes = "widget_title_tag_attributes"
    }
}

// MARK: - SILayoutBuilderWidgetData
struct SILayoutBuilderWidgetData: Codable {
    var data: SILayoutBuilderDataClass?
    var items: [SILayoutBuilderWidgetDataItem]?
}

// MARK: - DataClass
struct SILayoutBuilderDataClass: Codable {
    let guid, count: String?
    let status: Int?
    var assetMap: [SILayoutBuilderDataAssetMap]?
    let isTrashed, updatedBy: Int?
    let publishedDate: String?
    let templateComponentMapID: Int?

    enum CodingKeys: String, CodingKey {
        case guid, count, status
        case assetMap = "asset_map"
        case isTrashed = "is_trashed"
        case updatedBy = "updated_by"
        case publishedDate = "published_date"
        case templateComponentMapID = "template_component_map_id"
    }
}

// MARK: - SILayoutBuilderDataAssetMap
struct SILayoutBuilderDataAssetMap: Codable {
    let author: [SILayoutBuilderAuthor]?
    let assetID: Int?
    let assetMeta: SILayoutBuilderAssetMeta?
    let assetType: Int?
    let entitydata: [SILayoutBuilderAssetMapEntity]?
    let assetOrder: Int?
    let publishDate: String?
    let publishedVersionNumber: Int?

    enum CodingKeys: String, CodingKey {
        case author
        case assetID = "asset_id"
        case assetMeta = "asset_meta"
        case assetType = "asset_type"
        case entitydata
        case assetOrder = "asset_order"
        case publishDate = "publish_date"
        case publishedVersionNumber = "published_version_number"
    }
}

// MARK: - SILayoutBuilderAuthor
struct SILayoutBuilderAuthor: Codable {
    var assetID, authorID: Int?
    var fullName: String?
    var userName: String?
    var authorName: String?
    var assetTypeID: Int?

    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case authorID = "author_id"
        case fullName = "full_name"
        case userName = "user_name"
        case authorName = "author_name"
        case assetTypeID = "asset_type_id"
    }
}

// MARK: - SILayoutBuilderAssetMeta
struct SILayoutBuilderAssetMeta: Codable {
    var url: String?
    var desc, title: String?
    var assetID: Int?
    var imageID: Int?
    var imageName, imagePath: String?
    var responsive: Int?
    var titleAlias: String?
    var videoEmbed: String?
    var contentType: SIFeedsAssetType?
    var mobImageID, scoreWicket, mobImageName, mobImagePath: String?
    var contentSourceID: String?
    var show_content: Bool?
    var duration: String?
    var videoUrl : String?

    enum CodingKeys: String, CodingKey {
        case url, desc, title
        case assetID = "asset_id"
        case imageID = "image_id"
        case imageName = "image_name"
        case imagePath = "image_path"
        case responsive
        case titleAlias = "title_alias"
        case videoEmbed = "video_embed"
        case contentType = "content_type"
        case mobImageID = "mob_image_id"
        case scoreWicket = "score_wicket"
        case mobImageName = "mob_image_name"
        case mobImagePath = "mob_image_path"
        case contentSourceID = "content_source_id"
        case show_content = "show_content"
        case duration = "duration"
        case videoUrl = "video_url"
    }
}

// MARK: - SILayoutBuilderAssetMapEntity
struct SILayoutBuilderAssetMapEntity: Codable {
    var name: String?
    var isLang, assetID, priority: Int?
    var canonical: String?
    var entityURL: String?
    var isVisible, isLinkable, assetTypeID: Int?
    var entDispName: String?
    var entityRoleMapID: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case isLang = "is_lang"
        case assetID = "asset_id"
        case priority, canonical
        case entityURL = "entity_url"
        case isVisible = "is_visible"
        case isLinkable = "is_linkable"
        case assetTypeID = "asset_type_id"
        case entDispName = "ent_disp_name"
        case entityRoleMapID = "entity_role_map_id"
    }
}

// MARK: - SILayoutBuilderWidgetDataItem
struct SILayoutBuilderWidgetDataItem: Codable {
    var rno: Int?
    var tags: String?
    var assetID: Int?
    var duration: String?
    var authorID: Int?
    var fullName: String?
    var isActive: Int?
    var userName: String?
    var assetGUID: String?
    var createdBy: Int?
    var imagePath: String?
    var isDeleted, isTrashed: Int?
    var shortDesc: String?
    var description: String?
    var updatedBy: Int?
    var assetTitle: String?
    var shortTitle: String?
    var showInApp: Int?
    var showInWeb: Int?
    var titleAlias, createdDate: String?
    var displayName: String?
    var isPublished: Int?
    var orderNumber, totalAssets: Int?
    var updatedDate: String?
    var assetListID: Int?
    var assetTypeID: SIFeedsAssetType?
    var publishedDate: String?
    var showCopyright: Int?
    var showInMobile: Int?
    var imageFileName: String?
    var priEntDispName: String?
    var secEntDispName: String?
    var primaryEntityName: String?
    var secondaryEntityName: String?
    var secondaryEntityUrl: String?
    var publishedVersionNumber, primaryEntityRoleMapID, secondaryEntityRoleMapID: Int?
    var coverDetail: SIFeedsCoverDetail?
    var focusByKeyword: [SIFeedsDetailFocusByKeyword]?
    var discountPrice: String?
    var price: String?
    var offer: String?
    var externalLink: String?
    var videoUrl: String?
    var viewCount: String?

    enum CodingKeys: String, CodingKey {
        case rno, tags
        case assetID = "asset_id"
        case duration
        case authorID = "author_id"
        case fullName = "full_name"
        case isActive = "is_active"
        case userName = "user_name"
        case assetGUID = "asset_guid"
        case createdBy = "created_by"
        case imagePath = "image_path"
        case isDeleted = "is_deleted"
        case isTrashed = "is_trashed"
        case shortDesc = "short_desc"
        case description
        case updatedBy = "updated_by"
        case assetTitle = "asset_title"
        case shortTitle = "short_title"
        case showInApp = "show_in_app"
        case showInWeb = "show_in_web"
        case titleAlias = "title_alias"
        case createdDate = "created_date"
        case displayName = "display_name"
        case isPublished = "is_published"
        case orderNumber = "order_number"
        case totalAssets = "total_assets"
        case updatedDate = "updated_date"
        case assetListID = "asset_list_id"
        case assetTypeID = "asset_type_id"
        case publishedDate = "published_date"
        case showCopyright = "show_copyright"
        case showInMobile = "show_in_mobile"
        case imageFileName = "image_file_name"
        case priEntDispName = "pri_ent_disp_name"
        case secEntDispName = "sec_ent_disp_name"
        case primaryEntityName = "primary_entity_name"
        case secondaryEntityName = "secondary_entity_name"
        case secondaryEntityUrl = "sec_ent_url"
        case publishedVersionNumber = "published_version_number"
        case primaryEntityRoleMapID = "primary_entity_role_map_id"
        case secondaryEntityRoleMapID = "secondary_entity_role_map_id"
        case coverDetail = "cover_detail"
        case focusByKeyword = "focus_by_keywords"
        case discountPrice = "discount_price"
        case price
        case offer
        case externalLink = "external_link"
        case videoUrl = "video_url"
        case viewCount = "view_count"
    }
}

// MARK: - SIFeedsAdUnit
public struct SIFeedsAdUnit: Codable {
    public let ios, android: String?
}

// MARK: - SIFeedsCoverDetail
public struct SIFeedsCoverDetail: Codable {
    let branding: String?
    let fieldBrightcoveIsLive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case branding
        case fieldBrightcoveIsLive = "field_brightcove_is_live"
    }
}

public enum SIFeedsComponentName: String, Codable {
    case si_showcase = "si-showcase"
    case si_scorestrip = "si-scorestrip"
    case si_standings = "si-standings"
    case si_listing = "si-listing"
    case si_squad = "si-squad"
    case si_fixed_dynamic_content_listing = "si-fixed-dynamic-content-listing"
    case si_ads = "si-ads"
    case si_audio = "si-audio"
    case si_teamlisting = "si-teamlisting"
    case si_viewers_choice = "si_viewers_choice"
    case unknown
}


