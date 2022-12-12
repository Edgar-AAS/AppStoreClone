import UIKit

class ComentsCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ComentsCell.self)
    
    private lazy var titleLabel: UILabel = .texBoldLabel(text: "Muito bom", fontSize: 16)
    private lazy var comentsLabel: UILabel = .texLabel(text: "Super recomendo esse app, muito interessante", fontSize: 16, numberOfLines: 0)
    
    private lazy var evaluationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.size(size: .init(width: 120, height: 24))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.background
        layer.cornerRadius = 12
        layer.masksToBounds = true
        clipsToBounds = true
        
        let headerStackView = UIStackView(arrangedSubviews: [titleLabel, evaluationImageView])
        let comentsStackView = UIStackView(arrangedSubviews: [comentsLabel])
        comentsStackView.alignment = .top
        
        let stackView = UIStackView(arrangedSubviews: [headerStackView, comentsStackView])
        stackView.axis = .vertical
        stackView.spacing = 12
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(coment: AppComentario?) {
        guard let coment = coment else {
            return
        }
        
        titleLabel.text = coment.titulo
        comentsLabel.text = coment.descricao
        evaluationImageView.image = UIImage(named: "avaliacao-\(coment.avaliacao)")
    }
}
