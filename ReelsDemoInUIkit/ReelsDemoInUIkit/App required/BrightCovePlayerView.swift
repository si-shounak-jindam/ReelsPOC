//
//  BrightCovePlayerView.swift
//  ReelsDemoInUIkit
//
//  Created by Shounak Jindam on 05/08/24.
//

import UIKit
import BrightcovePlayerSDK
import AVKit

protocol BrightCovePlayerViewDelegate: AnyObject {
    func brightCoveVideoEnded()
}

class BrightCovePlayerView: UIView {
    
    let kSIPlaybackServicePolicyKey = "BCpkADawqM2sxZPshV4hGeRLA4YMn_7FIoR6Q9Cf0HgDPDY37ANyy5DH4LAbh6UC6V7HKAn8YmBEYIELuhNKjGkm0S79YOUwindf4n_rPpsrmDugdhl0STVputQHP9DGCiKrKJSvUt1ASYzG0Km6NX2yfVtX27hkWhoEHA"
    let kSIAccountID = "6415615747001"
    
    let sharedSDKManager = BCOVPlayerSDKManager.shared()
    var playbackService: BCOVPlaybackService?
    var playbackController: BCOVPlaybackController?
    let avpvc: AVPlayerViewController = AVPlayerViewController()
    var videoDuration:Int?
    var videoName:String?
    var videoSecondsView: Double?
    var videoPercentageView: Double = 0.0
    var flag25 = false
    var flag50 = false
    var flag75 = false
    var flag100 = false
    var percentageVideoView: String?
    var videoSecondsViewDouble: Double?
    
    weak var delegate: BrightCovePlayerViewDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialSetup()
    }
    
    fileprivate func initialSetup() {
        playbackService = BCOVPlaybackService(accountId: kSIAccountID, policyKey: kSIPlaybackServicePolicyKey)
        playbackController = sharedSDKManager?.createPlaybackController()
        playbackController?.delegate = self
        playbackController?.analytics.account = kSIAccountID
        playbackController?.isAutoAdvance = true
        playbackController?.isAutoPlay = true
        
        playbackController?.options = [ kBCOVAVPlayerViewControllerCompatibilityKey : true ]
        avpvc.delegate = self

    }
    
    func setupBrightCoveUI() {
        guard let playerView = avpvc.view else { return }
        
        self.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: self.topAnchor),
            playerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            playerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            playerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func requestContentFromPlaybackService(videoID: String) {
        playbackService?.findVideo(withVideoID: videoID, parameters: nil, completion: { [weak self] (video: BCOVVideo?, _, error: Error?) in
            if let strongSelf = self, let video = video {
                self?.videoName = "\(video.properties["name"] as AnyObject)"
                strongSelf.playbackController?.setVideos([video] as NSFastEnumeration)
            }
            if let error = error {
                print("Bright Cove Error: ", error.localizedDescription)
            }
        })
    }
    
    func requestVideoContentFromPlayBackService(videoID: String , completion: @escaping (Any?) -> Void) {
        playbackService?.findVideo(withVideoID: videoID, parameters: nil, completion: { [weak self] (video: BCOVVideo?, _, error: Error?) in
            if let video = video {
                completion(video)
            }
            if let error = error {
                completion(nil)
                print("Bright Cove Error: ", error.localizedDescription)
            }
        })
    }
}

extension BrightCovePlayerView: BCOVPlaybackControllerDelegate {
    func playbackController(_ controller: BCOVPlaybackController!, didAdvanceTo session: BCOVPlaybackSession!) {
        avpvc.player = session.player
        avpvc.player?.play()
    }
    func playbackController(_ controller: BCOVPlaybackController!, playbackSession session: BCOVPlaybackSession!, didReceive lifecycleEvent: BCOVPlaybackSessionLifecycleEvent!) {
        if lifecycleEvent.eventType == kBCOVPlaybackSessionLifecycleEventPause {
            
            videoPauseEvent()
        } else if lifecycleEvent.eventType == kBCOVPlaybackSessionLifecycleEventEnd {
            videoEndEvent()
        } else if lifecycleEvent.eventType == kBCOVPlaybackSessionLifecycleEventPlay {
            videoStart()
        }
    }
    func playbackController(_ controller: BCOVPlaybackController!, playbackSession session: BCOVPlaybackSession!, didProgressTo progress: TimeInterval) {
        
        guard !(progress.isNaN || progress.isInfinite) else { return }
        self.videoSecondsView = (progress >  0.0 || progress != nil)   ? progress : 0.0
        self.videoPercentageView = progress > 0.0 ? progress / (Double(videoDuration ?? 0)) * 100 : 0.0
        self.videoSecondsViewDouble = Double(self.videoSecondsView ?? 0)
        self.videoSecondsViewDouble = progress
        let progressPercentage = progress / Double(videoDuration ?? 0) * 100
        guard !(progressPercentage.isNaN || progressPercentage.isInfinite) else { return }
        self.videoInOPercentage(percent: Int(videoPercentageView ?? 0.0))
    }
    func videoInOPercentage(percent:Int) {
        if percent == 25 {
            if flag25 == false {
                flag25 = true
                self.percentageVideoView = "25%"
//                FirebaseEvents.videoProgressFirebaseLogEvents(video_percent_viewed: "25", video_name: videoName ?? .blank, video_duration: self.videoDuration ?? 0, video_seconds_viewed: Int(videoSecondsView ?? 0.0))
            }
        } else if percent == 50 {
            if flag50 == false {
                flag50 = true
                self.percentageVideoView = "50%"
//                FirebaseEvents.videoProgressFirebaseLogEvents(video_percent_viewed: "50", video_name: videoName ?? .blank, video_duration: self.videoDuration ?? 0, video_seconds_viewed: Int(videoSecondsView ?? 0.0))
            }
        } else if percent == 75 {
            if flag75 == false {
                flag75 = true
                self.percentageVideoView = "75%"
//                FirebaseEvents.videoProgressFirebaseLogEvents(video_percent_viewed: "75", video_name: videoName ?? .blank, video_duration: self.videoDuration ?? 0, video_seconds_viewed: Int(videoSecondsView ?? 0.0))
            }
        } else if percent == 99 {
            if flag100 == false {
                flag100 = true
                self.percentageVideoView = "100%"
//                FirebaseEvents.videoProgressFirebaseLogEvents(video_percent_viewed: "100", video_name: videoName ?? .blank, video_duration: self.videoDuration ?? 0, video_seconds_viewed: Int(videoSecondsView ?? 0.0))
            }
        }
    }
    func videoStart() {
        print("Start")
//        FirebaseEvents.videoStartFirebaseLogEvents(video_duration: self.videoDuration ?? 0, video_name: videoName ?? .blank)
    }
    func videoEndEvent() {
        print("Complete")
        delegate?.brightCoveVideoEnded()
//        FirebaseEvents.videoCompleteFirebaseLogEvents(video_duration: self.videoDuration ?? 0, video_name: videoName ?? .blank, video_seconds_viewed: Int(videoSecondsView ?? 0.0))
    }
    func videoPauseEvent()  {
        if videoPercentageView.isInfinite || videoPercentageView.isNaN {
            // Handle the case of infinite or NaN
            print("Double value is either infinite or NaN")
        }
//        else {
//            FirebaseEvents.videoPauseFirebaseLogEvents(video_percent_viewed: "\(Int(videoPercentageView ?? 0.0))%", video_name: videoName ?? .blank, video_duration: self.videoDuration ?? 0, video_seconds_viewed: Int(videoSecondsView ?? 0.0 ) )
//        }

    }
}

extension BrightCovePlayerView: AVPlayerViewControllerDelegate {
    func playerViewController(_ playerViewController: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        // The system pauses when entering full screen, we need to 'resume' manually.
        coordinator.animate(alongsideTransition: nil) { _ in
            self.avpvc.player?.play()
        }
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        // The system pauses when returning from full screen, we need to 'resume' manually.
        coordinator.animate(alongsideTransition: nil) { _ in
            self.avpvc.player?.play()
        }
    }
}
