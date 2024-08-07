//
//  RootBaseViewController+MoEngageExt.swift
//  Punjab Kings
//
//  Created by Apurva Jalgaonkar on 04/04/24.
//

import Foundation
//import MoEngageInApps

//MARK: - MoEngage InApp Notification
extension RootBaseViewController: MoEngageInAppNativeDelegate {
    func inAppClicked(withCampaignInfo inappCampaign: MoEngageInApps.MoEngageInAppCampaign, andNavigationActionInfo navigationAction: MoEngageInApps.MoEngageInAppNavigationAction, forAccountMeta accountMeta: MoEngageCore.MoEngageAccountMeta) {
        
        let keyValues = navigationAction.keyValuePairs
               print("keyValues: \(keyValues)")
              // let keyValues1: [String: Any] = keyValues["payload"] as! [String : Any]
               
//               if let keyValues1: [String: Any] = keyValues["payload"] as? [String : Any]  {
//                   print("Payload data found: \(keyValues1)")
//                   CommonUtilities.shared.manageRedirectionScreens(notificationData: keyValues1)
//               } else {
//                   print("Payload data not found or is not of the expected type.")
//                   // Handle the case where payload data is missing or not of the expected type.
//               }
        if let payloadString = keyValues["payload"] as? String,
           let payloadData = payloadString.data(using: .utf8),
           let keyValues1 = try? JSONSerialization.jsonObject(with: payloadData) as? [String: Any] {
            print("Payload data found: \(keyValues1)")
            CommonUtilities.shared.manageRedirectionScreens(notificationData: keyValues1)
        } else {
            print("Failed to convert payload data to dictionary format.")
            // Handle the case where payload data is missing, not a string, or cannot be converted to dictionary format.
        }
        
    }
    
    
    func MoEngageInAppSetup() {
        MoEngageSDKInApp.sharedInstance.showInApp()
        MoEngageSDKInApp.sharedInstance.setInAppDelegate(self)
    }
    
    func inAppShown(withCampaignInfo inappCampaign: MoEngageInAppCampaign, forAccountMeta accountMeta: MoEngageAccountMeta) {
        // Alert Show
    }
    
    func inAppDismissed(withCampaignInfo inappCampaign: MoEngageInAppCampaign, forAccountMeta accountMeta: MoEngageAccountMeta) {
        // Dismiss
    }
    
    func inAppClicked(withCampaignInfo inappCampaign: MoEngageInApps.MoEngageInAppCampaign, andNavigationActionInfo navigationAction: MoEngageInApps.MoEngageInAppAction, forAccountMeta accountMeta: MoEngageCore.MoEngageAccountMeta) {
        
        // FLRP Event
//        self.insertFLRPEventWith(activity: "Click on Popups", activityID: "click_on_popups")
        
        // Need to write code for redirection
//        let keyValues = navigationAction.keyValuePairs
//        if let screenData = keyValues["payload"] as? String, !screenData.isEmpty,
//           let inAppPayloadInfo = CommonUtilities.shared.getCodableObjectFromString(text: screenData, type: InAppPayloadInfo.self) {
//            CommonUtilities.shared.manageRedirectionFromInAppInfo(dataController: self, inAppPayloadInfoData: inAppPayloadInfo)
//
//
//
//        }
//
        
//        let keyValues = navigationAction.keyValuePairs
//               print("keyValues: \(keyValues)")
//              // let keyValues1: [String: Any] = keyValues["payload"] as! [String : Any]
//
////               if let keyValues1: [String: Any] = keyValues["payload"] as? [String : Any]  {
////                   print("Payload data found: \(keyValues1)")
////                   CommonUtilities.shared.manageRedirectionScreens(notificationData: keyValues1)
////               } else {
////                   print("Payload data not found or is not of the expected type.")
////                   // Handle the case where payload data is missing or not of the expected type.
////               }
//        if let payloadString = keyValues["payload"] as? String,
//           let payloadData = payloadString.data(using: .utf8),
//           let keyValues1 = try? JSONSerialization.jsonObject(with: payloadData) as? [String: Any] {
//            print("Payload data found: \(keyValues1)")
//            CommonUtilities.shared.manageRedirectionScreens(notificationData: keyValues1)
//        } else {
//            print("Failed to convert payload data to dictionary format.")
//            // Handle the case where payload data is missing, not a string, or cannot be converted to dictionary format.
//        }


    }
    
    func inAppClicked(withCampaignInfo inappCampaign: MoEngageInApps.MoEngageInAppCampaign, andCustomActionInfo customAction: MoEngageInApps.MoEngageInAppAction, forAccountMeta accountMeta: MoEngageCore.MoEngageAccountMeta) {
        
    }
    
    func selfHandledInAppTriggered(withInfo inappCampaign: MoEngageInApps.MoEngageInAppSelfHandledCampaign, forAccountMeta accountMeta: MoEngageCore.MoEngageAccountMeta) {
        
    }
}

