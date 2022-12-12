import UIKit

class AppsHorizontalGroupVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var apps: [App] = []
    var callback: ((App) -> ())?
    
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppGroupHorizontalCell.self, forCellWithReuseIdentifier: AppGroupHorizontalCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
    }
}

extension AppsHorizontalGroupVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppGroupHorizontalCell.reuseIdentifier, for: indexPath) as? AppGroupHorizontalCell
        cell?.setup(app: apps[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
}
    
extension AppsHorizontalGroupVC {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width-40, height: view.bounds.height/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(apps[indexPath.item])
    }
}
