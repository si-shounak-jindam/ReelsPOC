//
//  VideoModel.swift
//  ReelsDemoInUIkit
//
//  Created by Shounak Jindam on 01/08/24.
//

import Foundation

final class VideosVM {

    var videoTitleAlias: String?
    var videoDetailsData: SIFeedsDetailDataClass?
    var baseUrl: String? = "https://www.wplt20.com/"
    var videoDetailUrl: String? = "apiv4/video/{title_alias}?is_app=1"
    var videoListingUrl: String? = "apiv4/listing?entities=3,4&otherent=&exclent=&pgnum={page_no}&inum=10&pgsize={count}"
    var videosListing: [SIFeedsListingItem] = []
    var fetchLimit: Int = 10
    var currentPageNumber: Int = 1
    var storyVideo:[String: Any] = [:]

    var videoDetailsItem: SIFeedsDetailModel?
    
     func getVideosListingURL() -> String {
        let url = baseUrl! + videoListingUrl!.replacingOccurrences(of: SIParameterKeys.page_number.name, with: "\(currentPageNumber)")
            .replacingOccurrences(of: SIParameterKeys.page_count.name, with: "\(fetchLimit + 1)")
           
        return url
    }
    
    func getVideosListing(pageNumber: Int,
                          onSuccess: @escaping() -> Void,
                        onFailure: @escaping(ServiceError) -> Void) {
        

         let mainURL = getVideosListingURL()
        print("mainURL :",mainURL)
        ServiceManager.shared.makeGetRequest(url: mainURL,
                                             type: SIFeedsListingModel.self,
                                             completion: { [weak self] response in
            guard let self = self else {return}
            switch response {
            case .success(let returnedResponse):
                if let videoItems = returnedResponse.content?.items {
                    self.videosListing.append(contentsOf: videoItems)
                    
                }
                onSuccess()
            case .failure(let error):
                onFailure(error)
            }
        })
    }
}

extension VideosVM {
    
    func getBrightCoveVideos(completion: @escaping () -> Void ) {
        self.storyVideo = [:]
//        guard let storyObject = self.customHomeWidgets.first(where: { $0.widgetType == .stories }) else {return}
        let brightCovePLayer = BrightCovePlayerView()
        let group = DispatchGroup()
        for i in videosListing {
            group.enter()
            guard let videoURL = i.videoUrl else {return}
            brightCovePLayer.requestVideoContentFromPlayBackService(videoID: videoURL) { video in
                self.storyVideo[videoURL] = video
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
}


enum SIParameterKeys: String {
    case image_path = "{image_path}"
    case image_name = "{image_name}"
    case image_width = "{image_width}"
    case content_image_version = "{content_image_version}"
    case email_id = "{email_id}"
    case default_team_id = "{default_team_id}"
    case default_series_id = "{default_series_id}"
    case player_id = "{player_id}"
    case staff_id = "{staff_id}"
    case data_image_version = "{data_image_version}"
    case page_count = "{count}"
    case page_number = "{page_no}"
    case title_alias = "{title_alias}"
    case entity_category = "{entity_category}"
    case country_id = "{country_id}"
    case nationality_id = "{nationality_id}"
    case user_id = "{user_id}"
    case deviceToken = "{device_token}"
    case notificationClientId = "{client_id}"
    case existingUseUrl = "email_id={email_id}"
    case imgRatio = "/0/"
    case teamID = "{team_id}"
    case seriesID = "{series_id}"
    case time_zone = "{time_zone}"
    case teamAName = "{teamA_name}"
    case teamBName = "{teamB_name}"
    case gameID = "{game_id}"
    case version = "{version}"
    case category = "{category}"
    case pollEntity = "{entity_role_map_id}"
    case feed_value = "{feed_value}"
    case feed_type = "{feed_type}"
    case season_display_name = "{season_display_name}"
    case user_guid = "{user_guid}"
    var name: String {self.rawValue}
}
