//
//  RootBaseTabbarController.swift
//  Punjab Kings
//
//  Created by Abhijeet Gawde on 29/01/24.
//

import UIKit

class RootBaseTabbarController: UITabBarController, UITabBarControllerDelegate {
    // Variables
    let selectedTabColor: UIColor = .getColor(colorName: .yellow_FFDEAD)
    let unselectedTabColor: UIColor = .white.withAlphaComponent(1)
    var selectedTabIndex: Int? = 0
    let viewModel = RootBaseTabbarVM()
    var controllers = [RootBaseViewController]()
    var selectedTabItem : Int? = 0
    //private var backgroundImageView: UIImageView!
    var bottomMenu: [AppMenuModel?] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {.lightContent}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if UIDevice.current.hasNotch {
            tabBar.frame.size.height = 92
            tabBar.frame.origin.y = view.frame.height - 92
            
            
            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width, height: tabBar.frame.height), cornerRadius: 0)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            tabBar.layer.mask = mask
            
            let numberOfItems = CGFloat(tabBar.items!.count)
            let tabBarItemSize = CGSize(width: tabBar.frame.size.width / numberOfItems, height: tabBar.frame.size.height)
        } else {
            tabBar.frame.size.height = 60
            tabBar.frame.origin.y = view.frame.height - 60
            let cornerRadius: CGFloat = 0.0
            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width, height: tabBar.frame.height), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            tabBar.layer.mask = mask
            
            
            let numberOfItems = CGFloat(tabBar.items!.count)
            let tabBarItemSize = CGSize(width: tabBar.frame.size.width  / numberOfItems, height: tabBar.frame.size.height)
        }
    
    }
    
    fileprivate func setupTabbar() {
        //setupTabbarMenu()
        setupBottomTabbarMenu()
        tabBar.tintColor = selectedTabColor
        tabBar.unselectedItemTintColor = unselectedTabColor
        delegate = self
        self.tabBar.backgroundColor = .getColor(colorName: .black_212121)
        
        if #available(iOS 15.0, *) {
               let appearance = UITabBarAppearance()
               appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .getColor(colorName: .black_212121)
               
               tabBar.scrollEdgeAppearance = appearance
               tabBar.standardAppearance = appearance
           }
        
    }
    
//    fileprivate func setupTabbarMenu() {
//        controllers.removeAll()
//        
//        let homeRootVC: HomeVC = .instantiateController(storyBoard: .home_storyboard)
//        let home_unselected: UIImage = .getAppImage(imageName: .demo_tabbar_home).withTintColor(.red.withAlphaComponent(1))
//        homeRootVC.tabBarItem = UITabBarItem(title: "HOME",
//                                             image: home_unselected,
//                                             selectedImage: nil)
//        controllers.append(homeRootVC)
//        
//        let fixturesRootVC:  VideosListingVC = .instantiateController(storyBoard: .videos_storyboard)
//        let fixtures_unselected: UIImage = .getAppImage(imageName: .demo_tabbar_videos).withTintColor(.white.withAlphaComponent(1))
//        fixturesRootVC.tabBarItem = UITabBarItem(title: "VIDEOS",
//                                                 image: fixtures_unselected,
//                                                 selectedImage: nil)
//        controllers.append(fixturesRootVC)
//        
////        let videosRootVC: ViewController = .instantiateController(storyboard: .storyboard_main)
////        let videos_unselected: UIImage = .getAppImage(imageName: .videos_icon).withTintColor(.white.withAlphaComponent(1))
////        videosRootVC.tabBarItem = UITabBarItem(title: "Videos",
////                                               image: videos_unselected,
////                                               selectedImage: nil)
////        controllers.append(videosRootVC)
//        let reelsRootVC:  ReelsVC = .instantiateController(storyBoard: .reels_storyboard)
//        let videos_unselected: UIImage = .getAppImage(imageName: .demo_tabbar_kingCut).withTintColor(.white.withAlphaComponent(1))
//        reelsRootVC.tabBarItem = UITabBarItem(title: "KING'S CUT",
//                                               image: videos_unselected,
//                                               selectedImage: nil)
//        controllers.append(reelsRootVC)
//        
//        let squadRootVC:  HomeVC = .instantiateController(storyBoard: .home_storyboard)
//        let squad_unselected: UIImage = .getAppImage(imageName: .demo_tabbar_matches).withTintColor(.white.withAlphaComponent(1))
//        squadRootVC.tabBarItem = UITabBarItem(title: "MATCHES",
//                                              image: squad_unselected,
//                                              selectedImage: nil)
//        controllers.append(squadRootVC)
//        
//        let moreRootVC:  MoreVC = .instantiateController(storyBoard: .more_storyboard)
//        let more_unselected: UIImage = .getAppImage(imageName: .demo_tabbar_more).withTintColor(.white.withAlphaComponent(1))
//        moreRootVC.tabBarItem = UITabBarItem(title: "MORE",
//                                             image: more_unselected,
//                                             selectedImage: nil)
//        controllers.append(moreRootVC)
//        
//        self.setViewControllers(controllers, animated: true)
//        self.selectedIndex = selectedTabIndex ?? 0
//    }
    
    
//    fileprivate func setupBottomTabbarMenu() {
//        controllers.removeAll()
//
//        for i in self.viewModel.bottomMenu {
//            if let controller = self.viewModel.getViewController(menuItem: i) {
//                let tabImage = UIImage(named: i?.menuIcon ?? .blank)?.withRenderingMode(.alwaysTemplate).withTintColor(.getColor(colorName: .white_FFFFFF).withAlphaComponent(1))
//                controller.tabBarItem = UITabBarItem(title: i?.screenName?.uppercased(),
//                                                     image: tabImage?.withRenderingMode(.alwaysTemplate),
//                                                     selectedImage: UIImage(named: "\(i?.menuIcon ?? .blank)"))
//                self.controllers.append(controller)
//            }
//        }
//        self.setViewControllers(controllers, animated: true)
//        self.selectedIndex = selectedTabIndex ?? 0
//    }
    
    
    fileprivate func setupBottomTabbarMenu() {
        controllers.removeAll()

        for i in self.viewModel.bottomMenu {
            if let controller = self.viewModel.getViewController(menuItem: i) {
                var tabImage = UIImage()
                if let image = UIImage(named: i?.bottomMenuIcon ?? AppImageName.common.name)?.withRenderingMode(.alwaysOriginal) {
                    tabImage = image
                } else {
                    tabImage = UIImage(named: AppImageName.common.name)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
                }
                
                var selectedImage = UIImage()
                if let selectImage = UIImage(named: "\(i?.bottomMenuIcon ?? AppImageName.common.name)_selected") {
                    selectedImage = selectImage
                } else {
                    selectedImage = UIImage(named: "\(AppImageName.common.name)_selected") ?? UIImage()
                }
                
                controller.tabBarItem = UITabBarItem(title: i?.screenName?.uppercased(),
                                                         image: tabImage,
                                                         selectedImage: selectedImage)
                    
                self.controllers.append(controller)
            }
        }
        self.setViewControllers(controllers, animated: true)
        self.selectedIndex = selectedTabIndex ?? 0
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let tabBarIndex = tabBarController.selectedIndex
        print("index",tabBarIndex)
        self.bottomMenu = FirebaseModelConfig.sharedFirebaseConfig.appMenuModel.filter({ $0.isVisible == true })
        
        self.bottomMenu = self.bottomMenu.filter({ $0?.isBottomBar == true })
        self.bottomMenu = self.bottomMenu.sorted(by: { ($0?.order ?? 0) < ($1?.order ?? 0) })
        
        if self.bottomMenu[tabBarIndex]?.menuID == .matches {
            
            if let url = URL(string: self.bottomMenu[tabBarIndex]?.webviewURL ?? .blank) {
                let title = self.bottomMenu[tabBarIndex]?.screenName
                let attributes: [String: Any] = [
                    "title": title,
                    "slug": url,
                    "asset_type": "fixtures",
                ]
                MoEngageManager.shared.trackMoEngageEvent(event: "fixtures_view", eventAttribute: attributes)
            }
        }
            
//            if tabBarController.selectedIndex == 0 {
//                let root_tabbar_controller: RootBaseTabbarController = .instantiateController(storyBoard: .root_base_storyboard)
//                CommonUtilities.shared.setRootController(controller: root_tabbar_controller, storyboard: .root_base_storyboard)
//            }
        }
    
    
//    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        print("Selected item")
//    }
//    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        self.bottomMenu = FirebaseModelConfig.sharedFirebaseConfig.appMenuModel.filter({ $0.isVisible == true })
//        
//        self.bottomMenu = self.bottomMenu.filter({ $0?.isBottomBar == true })
//        self.bottomMenu = self.bottomMenu.sorted(by: { ($0?.order ?? 0) < ($1?.order ?? 0) })
//        print("index",self.bottomMenu[item.i ]?.screenName! ?? .blank)
//    }

    
}

