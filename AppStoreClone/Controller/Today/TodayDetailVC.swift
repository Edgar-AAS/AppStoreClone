import UIKit

class TodayDetailVC: UIViewController {
    var todayApp: TodayApp? {
        didSet {
            if let todayApp = todayApp {
                if todayApp.apps == nil {
                    self.addOnly()
                } else {
                    self.addMultiple()
                }
            }
        }
    }

    var centerView: UIView?
    var frame: CGRect?

    let closeButton: UIButton = .closeButton()
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var widhtConstraint: NSLayoutConstraint?
    
    private let onlyDetailVC = OnlyDetailVC()
    private let todayDetailMultipleVC = TodayDetailMultipleVC()
    
    //callBack
    var closeHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func addCloseButton() {
        view.addSubview(closeButton)
        closeButton.alpha = 0
        closeButton.addTarget(self, action: #selector(handleCloseClick), for: .touchUpInside)
        
        closeButton.fillConstraints(
            top: self.view.safeAreaLayoutGuide.topAnchor,
            leading: nil,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: 18, left: 0, bottom: 0, right: 24),
            size: .init(width: 32, height: 32)
        )
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .showHideTransitionViews, animations: {
            self.closeButton.alpha = 1
        }, completion: nil)
        
    }
    
    func closeAnimation() {
        
        self.todayDetailMultipleVC.tableView.setContentOffset(CGPoint(x: 0, y: -todayDetailMultipleVC.tableView.safeAreaInsets.top
        ), animated: false)
        self.todayDetailMultipleVC.tableView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .overrideInheritedCurve, animations: {
            if let frame = self.frame {
                self.topConstraint?.constant = frame.origin.y
                self.leadingConstraint?.constant = frame.origin.x
                self.widhtConstraint?.constant = frame.width
                self.heightConstraint?.constant = frame.height
                self.centerView?.layer.cornerRadius = 16
                self.todayDetailMultipleVC.tableView.contentOffset = .zero
                self.view.layoutIfNeeded()
            }
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func handleCloseClick() {
        self.closeButton.isHidden = true
        self.closeHandler?()
        closeAnimation()
    }
    
    func addOnly() {
        self.onlyDetailVC.todayApp = todayApp
        self.onlyDetailVC.referenceWidth = view.bounds.width
        self.centerView = onlyDetailVC.view
        self.animate()
    }
    
    func addMultiple() {
        todayDetailMultipleVC.todayApp = self.todayApp
        todayDetailMultipleVC.handlerClick = { [weak self] app in
            let detailVC = AppDetailVC()
            detailVC.title = app.nome
            detailVC.appId = app.id
            detailVC.app = app
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        self.centerView = todayDetailMultipleVC.view
        self.animate()
    }
    
    func animate() {
        guard let centerView = centerView else {
            return
        }
        
        guard let frame = frame else {
            return
        }
        
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.layer.cornerRadius = 16
        centerView.clipsToBounds = true
        view.addSubview(centerView)
        self.addCloseButton()
        
        self.topConstraint = centerView.topAnchor.constraint(equalTo: view.topAnchor, constant: frame.origin.y)
        self.leadingConstraint = centerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: frame.origin.x)
        self.widhtConstraint = centerView.widthAnchor.constraint(equalToConstant: frame.width)
        self.heightConstraint = centerView.heightAnchor.constraint(equalToConstant: frame.height)
        
        self.topConstraint?.isActive = true
        self.leadingConstraint?.isActive = true
        self.heightConstraint?.isActive = true
        self.widhtConstraint?.isActive = true
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .overrideInheritedCurve, animations: {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.heightConstraint?.constant = self.view.bounds.height
            self.widhtConstraint?.constant = self.view.bounds.width
            
            self.centerView?.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
