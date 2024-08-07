//
//  RootbaseTabbarVM.swift
//  Punjab Kings
//
//  Created by Apurva Jalgaonkar on 08/03/24.
//

import Foundation
import SafariServices


class RootBaseTabbarVM {
    
    var bottomMenu: [AppMenuModel?] = []
    var selectedItem: Int = 0
    
    init() {
        self.bottomMenu = FirebaseModelConfig.sharedFirebaseConfig.appMenuModel.filter({ $0.isVisible == true })
        
        self.bottomMenu = self.bottomMenu.filter({ $0?.isBottomBar == true })
        self.bottomMenu = self.bottomMenu.sorted(by: { ($0?.order ?? 0) < ($1?.order ?? 0) })
    }
    
    func getViewController(menuItem: AppMenuModel?) -> RootBaseViewController? {
        
        guard let menuType = menuItem?.menuID else { return nil }
        
        switch menuType {
            
        case .home:
            let homeVC: HomeVC = .instantiateController(storyBoard: .home_storyboard)
            return homeVC
            
        case .video:
            let videoVC: VideosListingVC = .instantiateController(storyBoard: .videos_storyboard)
            return videoVC
            
        case .kingsCut:
            let kingsVC: ReelsVC = .instantiateController(storyBoard: .reels_storyboard)
            return kingsVC
            
        case .more:
            let moreVC: MoreVC = .instantiateController(storyBoard: .more_storyboard)
            return moreVC
            
        case .gamingHub:
            let gamesVC: GamesListingVC = .instantiateController(storyBoard: .games_storyboard)
            return gamesVC
            
        case .photo:
            let photoVC: PhotosListingVC = .instantiateController(storyBoard: .photos_storyboard)
            return photoVC
            
        case .news:
            let newsVC: NewsListingVC = .instantiateController(storyBoard: .news_storyboard)
            return newsVC

        case .matches :
            let commonWebVC: CommonWebviewVC = .instantiateController(storyBoard: .common_storyboard)
            commonWebVC.webviewTitle = menuItem?.screenName
            commonWebVC.webViewUrl = menuItem?.webviewURL
            commonWebVC.isWebAuth = menuItem?.isWebAuth ?? false
            //commonWebVC.isLogin = menuItem?.isLogin ?? false
            return commonWebVC
            
        case .loyalty:
            let fanLoyaltyVC: FanLoyaltyVC = .instantiateController(storyBoard: .loyalty_storyboard)
            return fanLoyaltyVC
            
            
        default:
            
//            if menuItem?.inAppBrowser == true {
//                if menuItem?.isWebview == true {
                    let commonWebVC: CommonWebviewVC = .instantiateController(storyBoard: .common_storyboard)
                    commonWebVC.webviewTitle = menuItem?.screenName
                    commonWebVC.webViewUrl = menuItem?.webviewURL
                    commonWebVC.isWebAuth = menuItem?.isWebAuth ?? false
                   // commonWebVC.isLogin = menuItem?.isLogin ?? false
                    return commonWebVC
//                }
//            }
        }
    }
}



