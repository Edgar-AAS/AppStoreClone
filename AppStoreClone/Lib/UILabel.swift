import UIKit

extension UILabel {
    static func texLabel(text: String, fontSize: CGFloat, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = numberOfLines
        return label
    }
    
    static func texBoldLabel(text: String, fontSize: CGFloat, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.numberOfLines = numberOfLines
        return label
    }
}


