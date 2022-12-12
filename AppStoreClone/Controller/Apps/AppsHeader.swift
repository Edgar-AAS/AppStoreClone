import UIKit

class AppsHeader: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    
    static let reuseIdentifier = String(describing: AppsHeader.self)
    
    var featureApps: [FeaturedApp] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(AppHeaderCell.self, forCellWithReuseIdentifier: AppHeaderCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension AppsHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: bounds.width-40, height: bounds.height-5)
    }
}

extension AppsHeader {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppHeaderCell.reuseIdentifier, for: indexPath) as? AppHeaderCell
        cell?.setup(featuredApp: featureApps[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}
