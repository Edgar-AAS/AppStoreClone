import UIKit

class TodayCell: UICollectionViewCell {
    
    var todayApp: TodayApp? {
        didSet {
            if let todayApp = todayApp {
                categoryLabel.text = todayApp.categoria
                titleLabel.text = todayApp.titulo
                descriptionLabel.text = todayApp.descricao
                
                if let image = todayApp.imagemUrl {
                    imageView.image = UIImage(named: image)
                }
                
                if let backgroundColor = todayApp.backgroundColor {
                    self.backgroundColor = UIColor(hexString: backgroundColor)
                }
            }
        }
    }
    
    static let reuseIdentifier = String(describing: TodayCell.self)
    private lazy var categoryLabel: UILabel = .texLabel(text: "VIAGEM", fontSize: 18)
    private lazy var titleLabel: UILabel = .texBoldLabel(text: "Explore o mundo \nsem medo", fontSize: 28, numberOfLines: 2)
    lazy var imageView: UIImageView = .todayImageView(named: "destaque-1")
    private lazy var descriptionLabel: UILabel = .texLabel(text: "Podemos viajar o mundo em busca da beleza, mas nunca encontraremos se nao a carregarmos dentro de nós.", fontSize: 14, numberOfLines: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        clipsToBounds = true
        
        let boxView = UIView()
        boxView.clipsToBounds = true
        boxView.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: boxView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: boxView.centerXAnchor).isActive = true
        imageView.size(size: .init(width: bounds.width, height: 250))
        
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, boxView, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.fillConstraints(
            top: self.safeAreaLayoutGuide.topAnchor,
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
