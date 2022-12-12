import UIKit


class AppDetailDescriptionCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: AppDetailDescriptionCell.self)
    private lazy var titleLabel: UILabel = .texBoldLabel(text: "Novidades", fontSize: 24)
    private lazy var descriptionLabel: UILabel = .texLabel(text: "Descrição", fontSize: 14, numberOfLines: 0)
    
    var app: App? {
        didSet {
            if let app = app {
                descriptionLabel.text = app.descricao
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.spacing = 12
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
