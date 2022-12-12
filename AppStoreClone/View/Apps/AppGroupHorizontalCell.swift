import UIKit

class AppGroupHorizontalCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: AppGroupHorizontalCell.self)
    
    private lazy var iconAppImageView: UIImageView = .iconImageView()
    private lazy var appNameLabel: UILabel = .texLabel(text: "App nome", fontSize: 18, numberOfLines: 2)
    private lazy var companyLabel: UILabel = .texLabel(text: "App empresa", fontSize: 12, numberOfLines: 1)
    private lazy var getButton: UIButton = .getButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 80, y: bounds.height, width: bounds.width - 80, height: 0.8)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        layer.addSublayer(bottomLine)
        
        let titleCompanyStack = UIStackView(arrangedSubviews: [appNameLabel, companyLabel])
        titleCompanyStack.spacing = 4
        titleCompanyStack.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [iconAppImageView, titleCompanyStack, getButton])
        stackView.spacing = 12
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(app: App) {
        iconAppImageView.kf.setImage(with: URL(string: app.iconeUrl))
        appNameLabel.text = app.nome
        companyLabel.text = app.empresa
    }
}
