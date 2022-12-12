import UIKit

class SearchCell: UITableViewCell {
    let iconImageView: UIImageView = .iconImageView()
    let titlelabel: UILabel = .texLabel(text: "App nome", fontSize: 18, numberOfLines: 2)
    let companyLabel: UILabel = .texLabel(text: "Empresa nome", fontSize: 14)
    let getButton: UIButton = .getButton()
    
    let screenshot1ImageView: UIImageView = .screenshotImageView()
    let screenshot2ImageView: UIImageView = .screenshotImageView()
    let screenshot3ImageView: UIImageView = .screenshotImageView()
    
    static let searchCellReuseId = String(describing: SearchCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let groupedLabelsStackView = UIStackView(arrangedSubviews: [
            titlelabel,
            companyLabel
        ])
        
        groupedLabelsStackView.spacing = 8
        groupedLabelsStackView.axis = .vertical
        
        let headerStackView = UIStackView(arrangedSubviews: [
            iconImageView,
            groupedLabelsStackView,
            getButton
        ])
    
        headerStackView.spacing = 12
        headerStackView.alignment = .center
        
        let screenshotStackView = UIStackView(arrangedSubviews: [
            screenshot1ImageView,
            screenshot2ImageView,
            screenshot3ImageView
        ])
        
        screenshotStackView.spacing = 12
        screenshotStackView.distribution = .fillEqually
        
        let globalStackView = UIStackView(arrangedSubviews: [
            headerStackView,
            screenshotStackView
        ])
        

        globalStackView.axis = .vertical
        globalStackView.spacing = 16
        
        addSubview(globalStackView)
        globalStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupAppCell(app: App?) {
        guard let model = app else { return }
        titlelabel.text = model.nome
        companyLabel.text = model.empresa
        iconImageView.kf.setImage(with: URL(string: model.iconeUrl))
        setupScreenshot(model: model)
    }
    
    func setupScreenshot(model: App) {
        if let screenshots = model.screenshotUrls {
            if screenshots.count > 0 {
                screenshot1ImageView.kf.setImage(with: URL(string: screenshots[0]))
            }
            
            if screenshots.count > 1 {
                screenshot2ImageView.kf.setImage(with: URL(string: screenshots[1]))
            }
            
            if screenshots.count > 2 {
                screenshot3ImageView.kf.setImage(with: URL(string: screenshots[2]))
            }
        }
    }
}
