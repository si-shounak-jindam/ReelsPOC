//
//  ViewController.swift
//  ReelsDemoInUIkit
//
//  Created by Shounak Jindam on 31/07/24.
//

import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var collView: UICollectionView!
    
    var videoURLs: [URL] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        collView.collectionViewLayout = layout
        collView.delegate = self
        collView.dataSource = self
        collView.isPagingEnabled = true
        collView.register(UINib(nibName: "ReelCollectionViewCell", bundle: nil),
                          forCellWithReuseIdentifier: "ReelCollectionViewCell")
        
        //loadLocalVideoURLs()
        loadVideoURLs()
    }
    
    func loadLocalVideoURLs() {
        if let video1URL = Bundle.main.url(forResource: "1", withExtension: "mp4"),
           let video2URL = Bundle.main.url(forResource: "2", withExtension: "mp4"), 
           let video3URL = Bundle.main.url(forResource: "3", withExtension: "mp4") {
            videoURLs = [video1URL, video2URL, video3URL]
        } else {
            print("Error: Videos not found in the bundle")
        }
        collView.reloadData()
    }
    
    func loadVideoURLs() {
        if let videoURL = URL(string: "https://static.pexels.com/lib/videos/free-videos.mp4"),
           let videoURL1 = URL(string: "https://static.pexels.com/lib/videos/free-videos.mp4"),
           let videoURL3 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
           let videoURL4 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
           let videoURL5 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"),
           let videoURL6 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
           let videoURL7 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"),
           let videoURL8 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"),
           let videoURL12 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"){
            videoURLs = [videoURL, videoURL1, videoURL3, videoURL4, videoURL5, videoURL6, videoURL7, videoURL8, videoURL12]
        } else {
            print("Error: Invalid video URL")
        }
        
        collView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCollectionViewCell", for: indexPath) as! ReelCollectionViewCell
        let videoURL = videoURLs[indexPath.item]
        cell.configure(with: videoURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ReelCollectionViewCell else { return }
        let videoURL = videoURLs[indexPath.item]
        cell.configure(with: videoURL)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ReelCollectionViewCell else { return }
        cell.player?.pause()
    }
}

