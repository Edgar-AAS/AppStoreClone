//
//  TodayHeader.swift
//  AppStoreClone
//
//  Created by Leonardo Almeida on 05/12/22.
//

import UIKit


class TodayHeader: UICollectionReusableView {
    static let reuseIdentifier = String(describing: TodayHeader.self)
    
    let dataLabel: UILabel = .texLabel(text: "SEGUNDA, 5 DE DEZEMBRO", fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dataLabel)
        dataLabel.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 32, left: 24, bottom: 0, right: 0)
        )
        
        addSubview(titleLabel)
        titleLabel.fillConstraints(
            top: nil,
            leading: leadingAnchor,
            trailing: nil,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 24, bottom: 0, right: 0)
        )
        
        addSubview(profileImageView)
        profileImageView.fillConstraints(
            top: nil,
            leading: nil,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 24)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hoje"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 34)
        return label
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.size(size: .init(width: 36, height: 36))
        image.layer.cornerRadius = 18
        image.clipsToBounds = true
        image.image = UIImage(systemName: "person.circle")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
}
