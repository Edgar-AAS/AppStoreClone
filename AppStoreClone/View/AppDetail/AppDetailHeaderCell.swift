import UIKit
import Kingfisher

class AppDetailHeaderCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: AppDetailHeaderCell.self)
    
    private lazy var iconImageView: UIImageView = .iconImageView(widht: 128, height: 128)
    private lazy var nameLabel: UILabel = .texLabel(text: "App nome", fontSize: 20, numberOfLines: 2)
    private lazy var companylabel: UILabel = .texLabel(text: "App empresa", fontSize: 14)
    private lazy var getButton: UIButton = .getButton()
    
    
    func setupCell(app: App?) {
        guard let app = app else {
            return
        }
        guard let imageUrl = URL(string: app.iconeUrl) else {
            return
        }
        
        iconImageView.kf.setImage(with: imageUrl)
        nameLabel.text = app.nome
        companylabel.text = app.empresa
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let buttonStackView = UIStackView(arrangedSubviews: [getButton, UIView()])
        
        let verticalStackView = UIStackView(arrangedSubviews: [nameLabel, companylabel, buttonStackView])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 12
        
        iconImageView.image = UIImage(named: "icone")
                
        let globalStackView = UIStackView(arrangedSubviews: [iconImageView, verticalStackView])
        addSubview(globalStackView)
        globalStackView.alignment = .center
        globalStackView.spacing = 12
        globalStackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


