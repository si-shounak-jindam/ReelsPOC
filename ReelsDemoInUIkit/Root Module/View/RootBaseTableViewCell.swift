//
//  RootBaseTableViewCell.swift
//  Punjab Kings
//
//  Created by Abhijeet Gawde on 03/02/24.
//

import UIKit

class RootBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}



