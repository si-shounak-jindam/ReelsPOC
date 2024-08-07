//
//  RootBaseViewController.swift
//  Punjab Kings
//
//  Created by Abhijeet Gawde on 29/01/24.
//

import UIKit
//import MBprogress

var fromNotification = false
var fromLoginRedirection = false
var loginRedirectionMenuID = 999
var loginRedirectionTitleAlias = ""

class RootBaseViewController: UIViewController {
    
    var showBackButton: Bool = true
    var logoBtnClickCount = 0
    var shareActivityType = ""
    var reCaptchaVC: ReCaptchaVC?
    var rootUserProfileData : UserProfileData?
    var moreMenuItems : [AppMenuModel]? = []
    lazy var loyaltyViewModel = FanLoyaltyVM()
    
    //    var scoreStripModel:ScoreStripModel?
    //    var matchData: Match?
    
    
    let attributedUnderLineText: [NSAttributedString.Key : Any] = [
        .font: UIFont.customFont(customFont: .montserratRegular, size: 12.0),
        .foregroundColor: UIColor.red ,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    let attributedNormalText: [NSAttributedString.Key : Any] = [
        .font: UIFont.customFont(customFont: .montserratRegular, size: 12.0),
        .foregroundColor: UIColor.black
    ]
    
    let attributedColorText: [NSAttributedString.Key : Any] = [
        .font: UIFont.customFont(customFont: .montserratRegular, size: 12.0),
        .foregroundColor: UIColor.red
    ]
    
    let attributedBlackColorText: [NSAttributedString.Key : Any] = [
        .font: UIFont.customFont(customFont: .montserratBold, size: 12.0),
        .foregroundColor: UIColor.black
    ]
    
    
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
        
        if fromNotification {
            fromNotification = false
            self.callFlrpNotificationCreditEvent()
        }
    }
    
    
    
}

//MARK: ADDITIONAL FUNCTIONALITIES
extension RootBaseViewController {
    
    func setBackgroundColor(color: UIColor? = .white) {
        self.view.backgroundColor = color
    }
    
    func setupNavigationBar(title: String = "",
                            titleSize: CGFloat? = 18,
                            showLogo: Bool = false,
                            showBackButton: Bool = false,
                            showLogin: Bool = false,
                            showMatch: Bool = false,
                            showLoyalty: Bool = false,
                            navigationBarColor: UIColor = .clear) {
        
        tabBarController?.navigationItem.rightBarButtonItems = nil
        tabBarController?.navigationItem.leftBarButtonItems = nil
        navigationItem.rightBarButtonItems = nil
        navigationItem.leftBarButtonItems = nil
        tabBarController?.navigationItem.titleView = nil
        navigationItem.titleView = nil
        
        setupNavigationBarAppearance(withColor: navigationBarColor)
        
        if showLogo {
            let logoBarButtonItem = UIBarButtonItem(customView: setupNavigationLogo())
            tabBarController?.navigationItem.leftBarButtonItem = logoBarButtonItem
            navigationItem.leftBarButtonItem = logoBarButtonItem
        } else if showBackButton {
            setupBackButton()
        } else {
            tabBarController?.navigationItem.leftBarButtonItems = nil
            navigationItem.leftBarButtonItem = nil
            navigationItem.hidesBackButton = true
        }
        
        if showLogin {
            let profileBarButtonItem = UIBarButtonItem(customView: rightNavigationProfileView())
            if let tabBarNavigationItem = tabBarController?.navigationItem {
                tabBarNavigationItem.rightBarButtonItem = profileBarButtonItem
            } else {
                navigationItem.rightBarButtonItem = profileBarButtonItem
            }
        }
        
        if !title.isEmpty {
            let titleView = setupMultiLineNavigationTitle(title: title, size: titleSize ?? 18)
            
            let leftBarButtonWrapper = UIView()
            leftBarButtonWrapper.addSubview(tabBarController?.navigationItem.leftBarButtonItem?.customView ?? UIView())
            
            let stackView = UIStackView(arrangedSubviews: [titleView])
            
            stackView.axis = .horizontal
            
            // Set constraints for the left bar button
            leftBarButtonWrapper.translatesAutoresizingMaskIntoConstraints = false
            leftBarButtonWrapper.widthAnchor.constraint(equalToConstant: 190).isActive = true
            leftBarButtonWrapper.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            
            tabBarController?.navigationItem.titleView = titleView
            navigationItem.titleView = titleView
        }
        
        if showMatch {
            let matchCustomView = matchView()
            if matchCustomView != nil {
                tabBarController?.navigationItem.titleView = matchCustomView
            } else {
                // Handle the case where matchView() returns nil
                // For example, set a default title or perform another action
                tabBarController?.navigationItem.title = "Default Title"
            }
        }
        
        if showLoyalty {
            let loyaltyCustomView = loyaltyView()
            if loyaltyCustomView != nil {
                tabBarController?.navigationItem.titleView = loyaltyCustomView
            } else {
                // Handle the case where matchView() returns nil
                // For example, set a default title or perform another action
                tabBarController?.navigationItem.title = "Default Title"
            }
        }
        
        
    }
    
    
    @objc
    func matchView() -> UIView{
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let customTitleView = NavScoreView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: navigationBarHeight))
        customTitleView.lblTeamOneName.text = "New"
        
        return customTitleView
    }
    
    @objc
    func loyaltyView() -> UIView {
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let customTitleView = NavFanLoyaltyView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: navigationBarHeight))
        customTitleView.dataController = self
        customTitleView.lblRemainingCoins.text = "\(self.loyaltyViewModel.loyaltyUserProfileModel?.data?.coinsBalance ?? 0)"
        return customTitleView
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
        let attributedTitle = NSAttributedString(string: title.uppercased(), attributes: attributes)
        lbl_title.attributedText = attributedTitle
        lbl_title.sizeToFit()
        
        return lbl_title
    }
    
    fileprivate func setupMultiLineNavigationTitle(title: String, size: CGFloat?) -> UILabel {
        let lbl_title = UILabel()
        lbl_title.font = .customFont(customFont: .montserratBold , size: size ?? 18)
        lbl_title.textColor = .white
        lbl_title.backgroundColor = .clear
        lbl_title.numberOfLines = 2
        lbl_title.text = title.uppercased()
        lbl_title.textAlignment = .center
        lbl_title.adjustsFontSizeToFitWidth = true
        lbl_title.minimumScaleFactor = 0.7
        lbl_title.sizeToFit()
        return lbl_title
    }
    
    //    fileprivate func setupNavigationLogo() -> UIView {
    //
    //        let screenWidth = UIScreen.main.bounds.width
    //        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
    //
    //        let logoImageView = UIImageView(image: .getAppImage(imageName: .logo_main))
    //        logoImageView.contentMode = .scaleAspectFit
    //        logoImageView.sizeToFit() // Adjust the frame size to fit the image
    //
    //        // Calculate the x-position to center the image horizontally
    //        let xPosition = (containerView.frame.size.width - logoImageView.frame.size.width - 35) / 2
    //        logoImageView.frame = CGRect(x: xPosition, y: 0, width: logoImageView.frame.size.width, height: 40)
    //
    //        containerView.addSubview(logoImageView)
    //
    //        return containerView
    //    }
    
    fileprivate func setupNavigationLogo() -> UIView {
        let screenWidth = UIScreen.main.bounds.width
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        
        // Create Button
        let button = UIButton(type: .custom)
        button.setTitle("  ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(btnLogoAction(_:)), for: .touchUpInside)
        // Set frame as per your requirements
        button.frame = CGRect(x: 20, y: 0, width: 80, height: 40)
        
        let xBtnPosition = (containerView.frame.size.width - button.frame.size.width - 35) / 2
        button.frame = CGRect(x: xBtnPosition, y: 0, width: button.frame.size.width, height: 40)
        
        // Add Button to Container View
        containerView.addSubview(button)
        
        // Create Logo ImageView
        let logoImageView = UIImageView(image: .getAppImage(imageName: .logo_main))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.sizeToFit()
        
        // Position Logo ImageView
        let xPosition = (containerView.frame.size.width - logoImageView.frame.size.width - 35) / 2
        logoImageView.frame = CGRect(x: xPosition, y: 0, width: logoImageView.frame.size.width, height: 40)
        
        // Add Logo ImageView to Container View
        containerView.addSubview(logoImageView)
        
        return containerView
    }
    
    @objc func btnLogoAction(_ sender: UIButton){
        logoBtnClickCount += 1
        if logoBtnClickCount == 5 {
            UIPasteboard.general.string = PBKSUserDefaultsManager.shared.getUserFCMToken()
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
    
    func setBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = .getAppImage(imageName: .bg_content)
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @objc func buttonTapped() {
        // Handle button tap action here
    }
    @objc
    fileprivate func loginBtnAction() {
        if let _ = PBKSUserDefaultsManager.shared.getUserID() {
            
            let vc: ProfileVC = .instantiateController(storyBoard: .profile_storyboard)
            self.setupNavigationBar()
            vc.isFromeHomeNavigationBar = true
            self.navigationController?.pushViewController(vc, animated: true)
            /*
             if let userData = try? ISLUserDefaultsManager.shared.getCodableObject(
             object: UserProfile.self,
             forKey: .getProfileResponse) {
             if let status = userData.data?.status, status == ResponseValidStatus.successStatus.rawValue {
             let vc: ProfileViewController = .instantiateController(storyboard: .storyboard_profile)
             self.navigationController?.pushViewController(vc, animated: true)
             return
             }
             }
             guard let userData = try? ISLUserDefaultsManager.shared.getCodableObject(
             object: UserProfile.self,
             forKey: .getProfileResponse) else {
             return
             }
             let vc: IncompleteProfileVC = .instantiateController(storyboard: .storyboard_login)
             vc.userProfileData = userData
             self.navigationController?.pushViewController(vc, animated: true)
             */
        }
        else {
            let controller_signupVC: LoginVC = .instantiateController(storyBoard: .login_storyboard)
            self.setupNavigationBar()
            controller_signupVC.showNavigationBar = true
            self.navigationController?.pushViewController(controller_signupVC, animated: true)
        }
    }
}

// MARK: - ACTIONS IMPLEMENTATIONS
extension RootBaseViewController {
    
    @objc fileprivate func backAction() {
        if let rootNavController = self.navigationController as? RootBaseNavigationController {
            rootNavController.popViewController(animated: true)
        }
        
        tabBarController?.tabBar.isHidden = false
        tabBarController?.navigationController?.navigationBar.isHidden = false
        tabBarController?.selectedIndex = 0
        
    }
}

extension RootBaseViewController {
    
    func openAlert(title: String?,
                   message: String?,
                   alertStyle:UIAlertController.Style,
                   actionTitles:[String],
                   actionStyles:[UIAlertAction.Style],
                   actions: [((UIAlertAction) -> Void)]) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
    func getProfileImage(for userData: UserProfileModel) -> UIImage? {
        let backgroundColor = UIColor.randomColor
        let firstName = (userData.data?.user?.firstName ?? "").initial
        let lastName = (userData.data?.user?.lastName ?? "").initial
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.setImage(string: "\(firstName)\(lastName)".uppercased(),
                           color: backgroundColor,
                           textColor: .getColor(colorName: .white_FFFFFF),
                           textAttributes: [.foregroundColor: UIColor.getColor(colorName: .white_FFFFFF), .font : UIFont.customFont(customFont: .montserratBold, size: 12)])
        return imageView.image
    }
    
}

// MARK: - Firebase Deeplinking
extension RootBaseViewController {
    
    func shareDynamicLink(infoString: String) {
        Task {
            guard let shareUrl = URL(string: infoString) else {return}
            let dynamicLink = await FirebaseDynamicLinkManager().createDynamicLink(for: infoString) ?? shareUrl
            let shareItems = [dynamicLink]
            let shareActivityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            self.present(shareActivityVC, animated: true)
        }
    }
    
    func shareReferralLink(infoString: String,referralCode: String,dataController: RootBaseViewController?) {
        Task {
            guard let shareUrl = URL(string: infoString) else {return}
            let dynamicLink = await FirebaseDynamicLinkManager().createDynamicLink(for: infoString) ?? shareUrl
            DispatchQueue.main.async {
                let shareMsg = (FirebaseModelConfig.sharedFirebaseConfig.appStaticText?.referralDialogShareMessage ?? .blank).replacingOccurrences(of: SIParameterKeys.referralCode.rawValue, with: referralCode) + (dynamicLink.absoluteString)
                   
                    
                let shareItems = [shareMsg]
                let shareActivityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
                dataController?.present(shareActivityVC, animated: true)
            }
        }
    }
}
