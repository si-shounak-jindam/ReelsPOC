//
//  ViewController.swift
//  ReelsDemoInUIkit
//
//  Created by Shounak Jindam on 31/07/24.
//

import UIKit
import BrightcovePlayerSDK
import AVKit

class ViewController: UIViewController {
    
    var selectedDetailItem: SIFeedsDetailModel?
    var listingItem: SIFeedsListingItem?
    var widgetDetails: SILayoutBuilderWidget?
    var storiesVideoData: [String: Any]?
    
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var videoContent: UIView!
    lazy var viewModel = VideosVM()
    var avpvc: AVPlayerViewController?
    
    var videoURLs: [URL] = []
  //  var brightCovePlayer: BrightCovePlayerView? = BrightCovePlayerView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    print("ViewDidLoad: brightCovePlayer is \(brightCovePlayer == nil ? "nil" : "not nil")")
        print("viewDidLoad called")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        collView.collectionViewLayout = layout
        collView.delegate = self
        collView.dataSource = self
        collView.isPagingEnabled = true
        collView.register(UINib(nibName: "ReelCollectionViewCell", bundle: nil),
                          forCellWithReuseIdentifier: "ReelCollectionViewCell")
        fetchVideosListing(pageNumber: 1)
        //setupBrightcovePlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
   //     print("ViewDidAppear: brightCovePlayer is \(brightCovePlayer == nil ? "nil" : "not nil")")
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.videosListing.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCollectionViewCell", for: indexPath) as! ReelCollectionViewCell
        let videoURL = videoURLs[safe: indexPath.item]
        let videoListing = viewModel.videosListing[indexPath.item]
      //  cell.configureWithBCP(widgetItem: videoListing)
        cell.dataController = self
        cell.configureCell(listingItem: videoListing, dataController: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCollectionViewCell", for: indexPath) as! ReelCollectionViewCell
        let videoUrl = viewModel.videosListing[indexPath.item].videoUrl
//         self.loadVideoPlayer(brightCoveVideo: videoUrl as Any)
//        cell.loadBrightCoveVideo()
        
        //let videoUrl = viewModel.reelsListingArr[visiblePlayingIndexPath?.item ?? 0].videoUrl ?? .blank
        //cell.loadBrightCoveVideo()
        cell.playVideo(url: videoUrl ?? "")
        self.avpvc = cell.brightCovePlayer.avpvc
        

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ReelCollectionViewCell else { return }
        //cell.player?.pause()
    }
}

extension ViewController {
    func fetchVideosListing(pageNumber: Int) {
        viewModel.getVideosListing(pageNumber: pageNumber,
                                   onSuccess: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
               self.collView.reloadData()
  
            }
        },
        onFailure: { [weak self] error in
            guard let self = self else { return }
        })
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


