//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by Leonardo Almeida on 29/11/22.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    lazy var screenshotImageView: UIImageView = .screenshotImageView()
    static let reuseIdentifier = String(describing: ScreenshotCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(screenshotImageView)
        screenshotImageView.image = UIImage(named: "screenshot")
        screenshotImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
