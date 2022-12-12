import UIKit

class TodayMultipleTableViewCell: UITableViewCell {
    var app: App? {
        didSet {
            if let app = app {
                iconImageView.kf.setImage(with: URL(string: app.iconeUrl))
                titleLabel.text = app.nome
                companyLabel.text = app.empresa
            }
        }
    }
    
    
    static let reuseIdentifier = String(describing: TodayMultipleTableViewCell.self)
    
    let iconImageView: UIImageView = .iconImageView(widht: 48, height: 48)
    let titleLabel: UILabel = .texLabel(text: "App nome", fontSize: 16)
    let companyLabel: UILabel = .texLabel(text: "App empresa", fontSize: 14)
    let getButton: UIButton = .getButton()
    
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let titleCompanyStackView = UIStackView(arrangedSubviews: [titleLabel, companyLabel])
        titleCompanyStackView.spacing = 4
        titleCompanyStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleCompanyStackView, getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillConstraints(
            top: topAnchor,
            leading: nil,
            trailing: nil,
            bottom: bottomAnchor,
            padding: .init(top: 14, left: 0, bottom: 14, right: 0)
        )
        
        self.leadingConstraint = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        self.trailingConstraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        
        self.leadingConstraint?.isActive = true
        self.trailingConstraint?.isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
