//
//  ReelCollectionViewCell.swift
//  ReelsDemo(Apurva Guidance)
//
//  Created by Shounak Jindam on 30/07/24.
//

import UIKit
import AVFoundation
import BrightcovePlayerSDK

class ReelCollectionViewCell: UICollectionViewCell {
    
    var dataController: UIViewController?
    var selectedVideoItem: SIFeedsListingItem?
    
    var viewModel = VideosVM()
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    @IBOutlet weak var brightCovePlayer: BrightCovePlayerView!
    private var playbackController: BCOVPlaybackController!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        
    }
    
    func configureCell(listingItem: SIFeedsListingItem?,dataController: UIViewController?) {
        // self.dataController = dataController
        self.selectedVideoItem = listingItem
    
        DispatchQueue.main.async {
            self.loadBrightCoveVideo()
        }
       
       playVideo(url:  self.selectedVideoItem?.videoUrl ?? "999")
    }
    
    func playVideo(url: String) {
        guard let brightCovePlayer = brightCovePlayer else {
            print("brightCovePlayer is nil")
            return
        }
        brightCovePlayer.requestContentFromPlaybackService(videoID: url)
    }
    
    func pauseVideo() {
        if brightCovePlayer != nil {
            DispatchQueue.main.async { [weak self] in
                self?.brightCovePlayer.avpvc.player?.pause()
            }
        }
    }
    
    func removeVideoPlayerFromCell() {
        if brightCovePlayer != nil {
            brightCovePlayer.playbackController?.pause()
            brightCovePlayer?.avpvc.player?.pause()
         //   brightCovePlayer?.avpvc.player?.stop()
            brightCovePlayer.avpvc.removeFromParent()
            brightCovePlayer?.avpvc.player = nil
        }
    }
    
    func loadBrightCoveVideo() {
        guard let dataController = self.dataController else { return }
        guard let brightCovePlayer = brightCovePlayer else { return }
        
        if let playbackController = brightCovePlayer.playbackController {
            print("PlaybackController is initialized: \(playbackController)")
            playbackController.isAutoPlay = true
        } else {
            print("PlaybackController is not initialized")
        }

        brightCovePlayer.setupBrightCoveUI()
        brightCovePlayer.avpvc.didMove(toParent: dataController)
        brightCovePlayer.backgroundColor = .clear
        brightCovePlayer.center = contentView.center
        brightCovePlayer.avpvc.showsPlaybackControls = true
        brightCovePlayer.avpvc.videoGravity = .resizeAspectFill
        brightCovePlayer.avpvc.view.backgroundColor = .clear
        brightCovePlayer.isUserInteractionEnabled = true
        brightCovePlayer.avpvc.showsPlaybackControls = true
    }

}
