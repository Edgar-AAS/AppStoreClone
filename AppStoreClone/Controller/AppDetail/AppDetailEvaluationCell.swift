import UIKit

class AppDetailEvaluationCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var titleLabel: UILabel = .texBoldLabel(text: "Avaliações e opiniões", fontSize: 24)
    static let reuseIdentifier = String(describing: AppDetailEvaluationCell.self)
    var collectionView: UICollectionView!
    private let internalId = String(describing: AppDetailEvaluationCell.self)
    
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
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ComentsCell.self, forCellWithReuseIdentifier: ComentsCell.reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 0)
        )
        
        addSubview(collectionView)
        collectionView.fillConstraints(
            top: titleLabel.bottomAnchor,
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

extension AppDetailEvaluationCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.app?.comentarios?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComentsCell.reuseIdentifier, for: indexPath) as? ComentsCell
        
        if let comment = self.app?.comentarios?[indexPath.item] {
            cell?.setupCell(coment: comment)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: bounds.width-40, height: collectionView.bounds.height)
    }
}
