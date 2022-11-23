import UIKit

extension UIImageView {
    static func iconImageView(widht: CGFloat = 64, height: CGFloat = 64) -> UIImageView {
        let image = UIImageView()
        image.size(size: .init(width: widht, height: height))
        image.backgroundColor = .purple
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }
    
    static func screenshotImageView() -> UIImageView {
        let image = UIImageView()
        image.backgroundColor = .purple
        image.layer.cornerRadius = 12
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }
    
    func loadImage(from imageUrl: String) {
        guard let imageUrl = URL(string: imageUrl) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: imageUrl) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
