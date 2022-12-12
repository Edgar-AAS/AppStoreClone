//
//  TodayMultipleHeader.swift
//  AppStoreClone
//
//  Created by Leonardo Almeida on 05/12/22.
import UIKit

class TodayMultipleHeader: UIView {
    
    var todayApp: TodayApp? {
        didSet {
            if let todayApp = todayApp {
                categoryLabel.text = todayApp.categoria
                titleLabel.text = todayApp.titulo
            }
        }
    }
    
    
    let categoryLabel: UILabel = .texLabel(text: "VIAGEM", fontSize: 18)
    let titleLabel: UILabel = .texBoldLabel(text: "Explre o mundo \nsem medo", fontSize: 28, numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.fillConstraints(
            top: self.safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 24, left: 24, bottom: 24, right: 24)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
