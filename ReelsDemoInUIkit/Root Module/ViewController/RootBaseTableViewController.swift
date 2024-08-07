//
//  RootBaseTableViewController.swift
//  Punjab Kings
//
//  Created by Abhijeet Gawde on 29/01/24.
//

import UIKit
import MBProgressHUD

class RootBaseTableViewController: UITableViewController {
    
    var showBackButton: Bool = true
    var logoBtnClickCount = 0
    var shareActivityType = ""
    var reCaptchaVC: ReCaptchaVC?
    var rootUserProfileData : UserProfileData?
    var rootUserVenueData : VenueInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (PBKSUserDefaultsManager.shared.getUserID() != nil) {
            guard let userData = try? PBKSUserDefaultsManager.shared.getCodableObject(
                object: UserProfileModel.self,
                forKey: .getProfileResponse) else {
                return
            }
            rootUserProfileData = userData.data
        }
        
    }
    
}

//MARK: ADDITIONAL FUNCTIONALITIES
extension RootBaseTableViewController {
    
    func setBackgroundColor(color: UIColor? = .white) {
        self.view.backgroundColor = color
    }
    
    func setupNavigationBar(title: String = .blank,
                            titleSize: CGFloat? = 18,
                            showLogo: Bool = false,
                            isShowLogin: Bool = false,
                            showBackButton: Bool = false,
                            navigationBarColor: UIColor = .clear,showSettingButton: Bool = false) {
        
        tabBarController?.navigationItem.rightBarButtonItems = nil
        tabBarController?.navigationItem.leftBarButtonItems = nil
        navigationItem.rightBarButtonItems = nil
        navigationItem.leftBarButtonItems = nil
        tabBarController?.navigationItem.titleView = nil
        navigationItem.titleView = nil
        
        setupNavigationBarAppearance(withColor: navigationBarColor)
        
        if showLogo {
            tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setupNavigationLogo())
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setupNavigationLogo())
        } else if showBackButton {
            setupBackButton()
        } else {
            tabBarController?.navigationItem.leftBarButtonItems = nil
            navigationItem.leftBarButtonItem = nil
            navigationItem.hidesBackButton = true
        }
        
        if isShowLogin {
            let profileBarButtonItem = UIBarButtonItem(customView: rightNavigationProfileView())
            if let tabBarNavigationItem = tabBarController?.navigationItem {
                tabBarNavigationItem.rightBarButtonItem = profileBarButtonItem
            } else {
                navigationItem.rightBarButtonItem = profileBarButtonItem
            }
        }
        
        if title != .blank {
            tabBarController?.navigationItem.titleView = setupNavigationTitle(title: title, size: titleSize)
            navigationItem.titleView = setupNavigationTitle(title: title, size: titleSize)
            
        }
        
        if showSettingButton {
            if let vc_tabbar = tabBarController {
                vc_tabbar.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNavigationSettingView())
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNavigationSettingView())
            }
        }
        
    }
    
    fileprivate func setupNavigationBarAppearance(withColor color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .getColor(colorName: .red_ED1C24)
        appearance.backgroundImage = .getAppImage(imageName: .bg_navigation)
        appearance.backgroundImageContentMode = .scaleAspectFill
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    fileprivate func setupNavigationTitle(title: String, size: CGFloat?) -> UILabel {
        let lbl_title = UILabel()
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.customFont(customFont: .montserratBold, size: size ?? 18),
            .foregroundColor: UIColor.white
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        lbl_title.attributedText = attributedTitle
        lbl_title.sizeToFit()
        
        return lbl_title
    }
    
    //    fileprivate func setupMultiLineNavigationTitle(title: String, size: CGFloat?) -> UILabel {
    //        let lbl_title = UILabel()
    //        lbl_title.font = .customFont(customFont: .Exo2Bold, size: size ?? 18)
    //        lbl_title.textColor = .white
    //        lbl_title.backgroundColor = .clear
    //        lbl_title.numberOfLines = 0
    //        lbl_title.textAlignment = .left
    //        lbl_title.text = title
    //        lbl_title.adjustsFontSizeToFitWidth = true
    //        lbl_title.minimumScaleFactor = 0.7
    //        lbl_title.sizeToFit()
    //        return lbl_title
    //    }
    
    fileprivate func setupNavigationLogo() -> UIView {
        //        let screenWidth = UIScreen.main.bounds.width
        //        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        //
        //        let logoImageView = UIImageView(image: .getAppImage(imageName: .logo_main))
        //        logoImageView.contentMode = .scaleAspectFit
        //        logoImageView.frame = CGRect(x: (containerView.frame.size.width) / 2, y: 0, width: 46, height: 40)
        //
        //        containerView.addSubview(logoImageView)
        //
        //        return containerView
        
        
        let screenWidth = UIScreen.main.bounds.width
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        
        let logoImageView = UIImageView(image: .getAppImage(imageName: .logo_main))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.sizeToFit() // Adjust the frame size to fit the image
        
        // Calculate the x-position to center the image horizontally
        let xPosition = (containerView.frame.size.width - logoImageView.frame.size.width - 35) / 2
        logoImageView.frame = CGRect(x: xPosition, y: 0, width: logoImageView.frame.size.width, height: 40)
        
        containerView.addSubview(logoImageView)
        
        return containerView
    }
    
    @objc func btnLogoAction(_ sender: UIButton){
        logoBtnClickCount += 1
        if logoBtnClickCount == 5 {
            //UIPasteboard.general.string = WPLUserDefaultManager.shared.getUserFCMToken()
            sender.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.logoBtnClickCount = 0
                sender.isUserInteractionEnabled = true
            }
        }
    }
    
    
    fileprivate func setupBackButton() {
        navigationItem.hidesBackButton = true
        let frame = CGRect(x: -10, y: 0, width: 45, height: 45)
        let customView = UIView()
        customView.frame = frame
        
        let backButton = UIButton(type: .custom)
        backButton.frame = frame
        backButton.setImage(.getAppImage(imageName: .left_white_arrow)
            .withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        customView.addSubview(backButton)
        
        let backBarButtonItem = UIBarButtonItem(customView: customView)
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func hideNavigationBar(){
        tabBarController?.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    func changeStatusBarColor() {
        let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBar.backgroundColor = .getColor(colorName: .red_ED1C24)
        statusBar.tag = 100
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
    }
}

// MARK: - ACTIONS IMPLEMENTATIONS
extension RootBaseTableViewController {
    
    @objc fileprivate func backAction() {
        setupNavigationBar()
//        if let rootNavController = self.navigationController as? RootBaseNavigationController {
//            rootNavController.popToRootViewController(animated: false)
//            if let rootTab = rootNavController.children[0] as? RootBaseTabbarController {
//                DispatchQueue.main.async {
//                    let tabbarRootVC: RootBaseTabbarController = .instantiateController(storyBoard: .root_base_storyboard)
//                    CommonUtilities.shared.setRootController(controller: tabbarRootVC,
//                                                             storyboard: .root_base_storyboard)
//                   
//                }
//
//            }
//        }
//
//        tabBarController?.tabBar.isHidden = false
//        tabBarController?.navigationController?.navigationBar.isHidden = false
//        tabBarController?.selectedIndex = 0
        self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
    }
    
    func showActivityIndicator(onView:UIView? = nil,
                               indicatorColor: UIColor = .getColor(colorName: .white_FFFFFF),
                               backgroundColor: UIColor = .getColor(colorName: .red_ED1C24)) {
        DispatchQueue.main.async {
            if let onView = onView {
                let activityIndicator = MBProgressHUD.showAdded(to: onView, animated: true)
                activityIndicator.bezelView.color = backgroundColor
                activityIndicator.bezelView.style = .solidColor
                activityIndicator.contentColor = indicatorColor
                activityIndicator.animationType = .fade
            } else {
                let activityIndicator = MBProgressHUD.showAdded(to: self.view, animated: true)
                activityIndicator.bezelView.color = backgroundColor
                activityIndicator.bezelView.style = .solidColor
                activityIndicator.contentColor = indicatorColor
                activityIndicator.animationType = .fade
            }
        }
    }
    
    func hideActivityIndicator(onView:UIView? = nil) {
        if let onView = onView {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: onView, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    func presentShareActivity(infoString: String) {
        guard let shareUrl = URL(string: infoString) else {return}
        let shareItems = [shareUrl]
        let shareActivityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        self.present(shareActivityVC, animated: true)
    }
    
    //    func getProfileImage(for userData: UserProfileModel) -> UIImage? {
    //        let backgroundColor = UIColor.randomColor
    //        let firstName = (userData.data?.user?.firstName ?? "").initial
    //        let lastName = (userData.data?.user?.lastName ?? "").initial
    //        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    //        imageView.setImage(string: "\(firstName)\(lastName)".uppercased(),
    //                           color: backgroundColor,
    //                           textColor: .getAppColor(colorName: .white_FFFFFF),
    //                           textAttributes: [.foregroundColor: UIColor.getAppColor(colorName: .white_FFFFFF), .font : UIFont.customFont(customFont: .interSemiBold, size: 14)])
    //        return imageView.image
    //    }
    
    fileprivate func rightNavigationSettingView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        let button = UIButton()
        //        button.titleLabel?.font = .customFont(customFont: .AvoryMedium, size: 10)
        button.setTitle("     ", for: .normal)
        button.setImage(.getAppImage(imageName: .setting_icon)
            .withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(settingBtnAction), for: .touchUpInside)
        view.addSubview(button)
        button.frame = view.bounds
        return view
    }
    
    
    fileprivate func rightNavigationProfileView() -> UIView {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        let button = UIButton()
        //        button.titleLabel?.font = .customFont(customFont: .AvoryMedium, size: 10)
        button.setTitle("     ", for: .normal)
        button.setImage(.getAppImage(imageName: .contact_icon)
            .withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        view.addSubview(button)
        button.frame = view.bounds
        return view
    }
    
    @objc
    func settingBtnAction() {
        
    }
    
    
    @objc
    fileprivate func loginBtnAction() {
        if let _ = PBKSUserDefaultsManager.shared.getUserID() {
            
            let vc: ProfileVC = .instantiateController(storyBoard: .profile_storyboard)
            self.setupNavigationBar()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let controller_signupVC: LoginVC = .instantiateController(storyBoard: .login_storyboard)
            self.setupNavigationBar()
            controller_signupVC.showNavigationBar = true
            self.navigationController?.pushViewController(controller_signupVC, animated: true)
        }
    }
}



