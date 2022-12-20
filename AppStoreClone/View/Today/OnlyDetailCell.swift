import UIKit

class OnlyDetailCell: UITableViewCell {
    static let reuseIdentifier = String(describing: OnlyDetailCell.self)
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        let textAtributes = NSMutableAttributedString(string: "Lorem ipsum", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        textAtributes.append(NSAttributedString(string: " é simplesmente uma simulacao de texto da industria tipografica de impressos e vem sendo ultilizado desde o seculo XVI, quando um impressor desconhecido pegou uma bandeja de tipos e embaralhou para fazer um livro de modelos de tipos.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        
        textAtributes.append(NSAttributedString(
            string: "\n\nDe onde ele vem?",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        )
        
        textAtributes.append(NSAttributedString(string: " é simplesmente uma simulacao de texto da industria tipografica de impressos e vem sendo ultilizado desde o seculo XVI, quando um impressor desconhecido pegou uma bandeja de tipos e embaralhou para fazer um livro de modelos de tipos.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        textAtributes.append(NSAttributedString(
            string: "\n\nDe onde ele vem?",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        )
        
        textAtributes.append(NSAttributedString(string: " é simplesmente uma simulacao de texto da industria tipografica de impressos e vem sendo ultilizado desde o seculo XVI, quando um impressor desconhecido pegou uma bandeja de tipos e embaralhou para fazer um livro de modelos de tipos.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        textAtributes.append(NSAttributedString(
            string: "\n\nDe onde ele vem?",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        )
        
        textAtributes.append(NSAttributedString(string: " é simplesmente uma simulacao de texto da industria tipografica de impressos e vem sendo ultilizado desde o seculo XVI, quando um impressor desconhecido pegou uma bandeja de tipos e embaralhou para fazer um livro de modelos de tipos.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        
        label.attributedText = textAtributes
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(
            top: 24,
            left: 24,
            bottom: 24,
            right: 24
        ))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
