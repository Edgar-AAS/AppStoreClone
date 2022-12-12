import UIKit

extension UIImageView {
    static func iconImageView(widht: CGFloat = 64, height: CGFloat = 64) -> UIImageView {
        let image = UIImageView()
        image.size(size: .init(width: widht, height: height))
        image.backgroundColor = .white
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }
    
    static func screenshotImageView() -> UIImageView {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 12
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }
    
    static func todayImageView(named: String? = nil) -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        if let named = named {
            image.image = UIImage(named: named)
        }
        
        image.contentMode = .scaleAspectFit
        return image
    }
}
