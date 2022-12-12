import UIKit

class TodayVC: UICollectionViewController {
    let acticityIndicatorView: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = UIColor.orange
        ai.startAnimating()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var todayApps: [TodayApp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayCell.reuseIdentifier)
        collectionView.register(TodayMultipleCell.self, forCellWithReuseIdentifier: TodayMultipleCell.reuseIdentifier)
        collectionView.register(TodayHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TodayHeader.reuseIdentifier)
        view.addSubview(acticityIndicatorView)
        acticityIndicatorView.superviewCenter()
        fetchFeatureApps()
    }
    
    func fetchFeatureApps() {
        TodayService.fetchFeaturedToday { [weak self] (result) in
            switch result {
            case .success(let todayApps):
                DispatchQueue.main.async {
                    self?.todayApps = todayApps
                    self?.collectionView.reloadData()
                    self?.acticityIndicatorView.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TodayVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCell.reuseIdentifier, for: indexPath) as? TodayCell
            cell?.todayApp = todayApps[indexPath.item]
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMultipleCell.reuseIdentifier, for: indexPath) as? TodayMultipleCell
            cell?.todayApp = todayApps[indexPath.item]
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: 90)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayHeader.reuseIdentifier, for: indexPath) as? TodayHeader
        return header ?? UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let frame = cell.superview?.convert(cell.frame, to: nil) {
                tabBarController?.tabBar.isHidden = true
                
                let modalView = TodayDetailVC()
                modalView.modalPresentationStyle = .overCurrentContext
                
                modalView.closeHandler = {
                    self.tabBarController?.tabBar.isHidden = false
                }
                
                let modalNav = UINavigationController(rootViewController: modalView)
                modalNav.modalPresentationStyle = .overCurrentContext
                modalNav.view.backgroundColor = .clear
                
                self.present(modalNav, animated: false) {
                    modalView.frame = frame
                    modalView.todayApp = self.todayApps[indexPath.item]
                }
            }
        }
    }
}

extension TodayVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width - 48, height: view.bounds.width + 48)
    }
}

