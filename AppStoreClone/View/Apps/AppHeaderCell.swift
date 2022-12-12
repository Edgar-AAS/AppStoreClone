//
//  AppHeaderCell.swift
//  AppStoreClone
//
//  Created by Leonardo Almeida on 27/11/22.
//

import UIKit

class AppHeaderCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: AppHeaderCell.self)
    
    private let companyLabel: UILabel = .texLabel(text: "app Empresa", fontSize: 12)
    private let descriptionLabel: UILabel = .texLabel(text: "app Descrição header", fontSize: 20, numberOfLines: 2)
    private let imageView: UIImageView  = .screenshotImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        companyLabel.textColor = .blue
        
        let stackView = UIStackView(arrangedSubviews: [companyLabel, descriptionLabel, imageView])
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    
    func setup(featuredApp: FeaturedApp) {
        companyLabel.text = featuredApp.empresa
        descriptionLabel.text = featuredApp.descricao
        imageView.kf.setImage(with: URL(string: featuredApp.imagemUrl))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
