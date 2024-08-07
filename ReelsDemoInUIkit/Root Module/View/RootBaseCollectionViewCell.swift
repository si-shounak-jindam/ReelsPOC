//
//  RootBaseCollectionViewCell.swift
//  Punjab Kings
//
//  Created by Abhijeet Gawde on 03/02/24.
//

import UIKit

class RootBaseCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}

