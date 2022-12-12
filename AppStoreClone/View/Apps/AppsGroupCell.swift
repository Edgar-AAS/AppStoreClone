//
//  AppsGroupCell.swift
//  AppStoreClone
//
//  Created by Leonardo Almeida on 28/11/22.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: AppsGroupCell.self)
    
    lazy var titleLabel: UILabel = .texBoldLabel(text: "App grupo titulo", fontSize: 24)
    
    let appsHorizontalGroupVC = AppsHorizontalGroupVC()

    var group: AppGroup? {
        didSet {
            if let group = group {
                titleLabel.text = group.titulo
                appsHorizontalGroupVC.apps = group.apps
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing:trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20)
        )
        
        addSubview(appsHorizontalGroupVC.view)
        
        appsHorizontalGroupVC.view.fillConstraints(
            top: titleLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    deinit {
        print("teste")
    }
    
}
