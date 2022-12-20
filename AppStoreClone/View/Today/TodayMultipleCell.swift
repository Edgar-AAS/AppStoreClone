import UIKit

class TodayMultipleCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: TodayMultipleCell.self)
    let categoryLabel: UILabel = .texLabel(text: "VIAGEM", fontSize: 18)
    let titleLabel: UILabel = .texBoldLabel(text: "Explore o mundo \nsem medo", fontSize: 28, numberOfLines: 2)
    
    var tablewView: UITableView!
    
    var todayApp: TodayApp? {
        didSet {
            if let todayApp = todayApp {
                categoryLabel.text = todayApp.categoria
                titleLabel.text = todayApp.titulo
                tablewView.reloadData()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        clipsToBounds = true
        
        tablewView = UITableView()
        tablewView.register(TodayMultipleTableViewCell.self, forCellReuseIdentifier: TodayMultipleTableViewCell.reuseIdentifier)
        tablewView.dataSource = self
        tablewView.isUserInteractionEnabled = false
        tablewView.separatorInset = UIEdgeInsets(top:  0, left: 64, bottom: 0, right: 0)
        
                
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.fillConstraints(
            top: self.safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 24, left: 24, bottom: 24, right: 24)
        )
        
        
        addSubview(tablewView)
        tablewView.fillConstraints(
            top: stackView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 24, left: 24, bottom: 24, right: 24)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodayMultipleCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.todayApp?.apps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodayMultipleTableViewCell.reuseIdentifier, for: indexPath) as? TodayMultipleTableViewCell
        cell?.app = self.todayApp?.apps?[indexPath.item]
        return cell ?? UITableViewCell()
    }
}
