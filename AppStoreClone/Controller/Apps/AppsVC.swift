import UIKit

final class AppsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let appService = AppService()
    private var featuredApps: [FeaturedApp] = []
    private var appsGroup: [AppGroup] = []
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.reuseIdentifier)
        collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsHeader.reuseIdentifier)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.superviewCenter()
        fetchApps()
    }
        
    func fetchApps() {
        var topRateApps: [FeaturedApp]?
        var appsWeLove: AppGroup?
        var topPaidApps: AppGroup?
        var topFreeApps: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        appService.fetchFeaturedApps { (result) in
            switch result {
            case .success(let featuredAppsData):
                topRateApps = featuredAppsData
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        appService.fetchGroup(type: "apps-que-amamos") { (result) in
            switch result {
            case .success(let apps):
                appsWeLove = apps
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        appService.fetchGroup(type: "top-apps-gratis") { (result) in
            switch result {
            case .success(let apps):
                topPaidApps = apps
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        appService.fetchGroup(type: "top-apps-pagos") { (result) in
            switch result {
            case .success(let apps):
                topFreeApps = apps
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let apps = topRateApps {
                self.featuredApps = apps
            }
            
            if let apps = appsWeLove {
                self.appsGroup.append(apps)
            }
            
            if let apps = topPaidApps {
                self.appsGroup.append(apps)
            }
            
            if let apps = topFreeApps {
                self.appsGroup.append(apps)
            }
            
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}

extension AppsVC {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsHeader.reuseIdentifier, for: indexPath) as? AppsHeader
        header?.featureApps = featuredApps
        header?.collectionView.reloadData()
        return header ?? UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.width*0.8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.reuseIdentifier, for: indexPath) as? AppsGroupCell
        cell?.group = appsGroup[indexPath.item]
        cell?.appsHorizontalGroupVC.callback = { [weak self] (app) in
            let appDetailVC = AppDetailVC()
            appDetailVC.appId = app.id
            appDetailVC.app = app
            self?.navigationController?.pushViewController(appDetailVC, animated: true)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width, height: 280)
    }
}
