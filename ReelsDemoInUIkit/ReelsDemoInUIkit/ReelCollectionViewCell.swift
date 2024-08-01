//
//  ReelCollectionViewCell.swift
//  ReelsDemo(Apurva Guidance)
//
//  Created by Shounak Jindam on 30/07/24.
//

import UIKit
import AVFoundation

class ReelCollectionViewCell: UICollectionViewCell {

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlayer()
    }

    private func setupPlayer() {
        player = AVPlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.frame = self.contentView.bounds
        if let playerLayer = playerLayer {
            self.contentView.layer.addSublayer(playerLayer)
        }
    }

    func configure(with url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        player?.replaceCurrentItem(with: nil)
    }
}
