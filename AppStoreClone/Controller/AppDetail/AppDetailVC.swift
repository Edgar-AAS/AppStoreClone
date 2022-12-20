import UIKit

enum AppDetailCellType: Int {
    case headerCell
    case descriptionCell
    case screenshotCell
    case evaluationCell
}

class AppDetailVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let networkService = AppService()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.color = .gray
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    var appId: Int! {
        didSet {
            self.fetchApp(appdId: appId)
        }
    }
    
    var app: App?
    var loading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(AppDetailHeaderCell.self, forCellWithReuseIdentifier: AppDetailHeaderCell.reuseIdentifier)
        collectionView.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: AppDetailDescriptionCell.reuseIdentifier)
        collectionView.register(AppDetailScreeshotCell.self, forCellWithReuseIdentifier: AppDetailScreeshotCell.reuseIdentifier)
        collectionView.register(AppDetailEvaluationCell.self, forCellWithReuseIdentifier: AppDetailEvaluationCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        view.addSubview(activityIndicator)
        activityIndicator.superviewCenter()
    }
    
    func fetchApp(appdId: Int) {
        networkService.fetchAppId(appId: appId) { [weak self] (result) in
            switch result {
            case .success(let appId):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.loading = false
                    self?.app = appId
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.loading ? 1 : 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = AppDetailCellType(rawValue: indexPath.item)
        
        switch cellType {
        case .headerCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailHeaderCell.reuseIdentifier, for: indexPath) as? AppDetailHeaderCell
            cell?.setupCell(app: app)
            return cell ?? UICollectionViewCell()
        case .descriptionCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailDescriptionCell.reuseIdentifier, for: indexPath) as? AppDetailDescriptionCell
            cell?.app = app
            return cell ?? UICollectionViewCell()
        case .screenshotCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailScreeshotCell.reuseIdentifier, for: indexPath) as? AppDetailScreeshotCell
            cell?.app = self.app
            return cell ?? UICollectionViewCell()
        case .evaluationCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailEvaluationCell.reuseIdentifier, for: indexPath) as? AppDetailEvaluationCell
            cell?.app = self.app
            return cell ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht: CGFloat = view.bounds.width
        var height: CGFloat = 170
        
        if indexPath.item == 1 {
            let descriptionCell = AppDetailDescriptionCell(frame: .init(x: 0, y: 0, width: widht, height: 1000))
            descriptionCell.app = self.app
            descriptionCell.layoutIfNeeded()
            
            let estimatedCellSize = descriptionCell.systemLayoutSizeFitting(CGSize(width: widht, height: 1000))
            height = estimatedCellSize.height
        }
        
        if indexPath.item == 2 {
            height = 550
        }
        
        if indexPath.item == 3 {
            height = 280
        }
        
        return .init(width: widht, height: height)
    }
}
