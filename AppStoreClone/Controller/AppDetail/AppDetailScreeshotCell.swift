//
//  AppDetailScreeshotCell.swift
//  AppStoreClone
//
//  Created by Leonardo Almeida on 29/11/22.
//

import UIKit


class AppDetailScreeshotCell: UICollectionViewCell {
    private lazy var titlelabel: UILabel = .texBoldLabel(text: "Pré visualização", fontSize: 24)
    private var collectionView: UICollectionView!
    static let reuseIdentifier  = String(describing: AppDetailScreeshotCell.self)
    private let internalIdentifier = "cellId"
    
    var app: App? {
        didSet {
            if app != nil {
                self.collectionView.reloadData()
            }
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast
        
        addSubview(titlelabel)
        addSubview(collectionView)
        
        titlelabel.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 20)
        )
        
        collectionView.fillConstraints(
            top: titlelabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppDetailScreeshotCell: UICollectionViewDelegate {
    
}

extension AppDetailScreeshotCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.app?.screenshotUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseIdentifier, for: indexPath) as? ScreenshotCell
        
        if let imageUrl = self.app?.screenshotUrls?[indexPath.item] {
            cell?.screenshotImageView.kf.setImage(with: URL(string: imageUrl))
        }
        
        return cell ?? UICollectionViewCell()
    }
}

extension AppDetailScreeshotCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 220, height: collectionView.bounds.height)
    }
}
