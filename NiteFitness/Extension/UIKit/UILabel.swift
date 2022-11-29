//
//  UILabel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import UIKit

extension UILabel {
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    
    var isTruncated: Bool {
       frame.width < intrinsicContentSize.width
    }

    var isClipped: Bool {
        frame.height < intrinsicContentSize.height
    }
}

extension UILabel {
    static func calculateHeight(with content: String?, font: UIFont?, width: CGFloat) -> CGFloat {
        let label = UILabel()
        label.font = font
        label.text = content
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label.systemLayoutSizeFitting(CGSize(width: width, height: .infinity), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
    }
    
    func strikeThrough(_ isStrikeThrough:Bool) {
        if isStrikeThrough {
            if let lblText = self.text {
                let attributeString =  NSMutableAttributedString(string: lblText)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
                self.attributedText = attributeString
            }
        } else {
            if let attributedStringText = self.attributedText {
                let txt = attributedStringText.string
                self.attributedText = nil
                self.text = txt
                return
            }
        }
    }
}

class SKFontLabel: UILabel {
    @IBInspectable var fontName: String {
        get { return "Roboto"}
        set { self.fontName = newValue }
    }

    @IBInspectable var fontSize: CGFloat {
        get { return 16}
        set { self.fontSize = newValue }
    }
}

// MARK: - EdgeInsetLabel
@IBDesignable
class EdgeInsetLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                left: -textInsets.left,
                bottom: -textInsets.bottom,
                right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

extension EdgeInsetLabel {
    @IBInspectable
    var leftTextInset: CGFloat {
        get { return textInsets.left }
        set { textInsets.left = newValue }
    }

    @IBInspectable
    var rightTextInset: CGFloat {
        get { return textInsets.right }
        set { textInsets.right = newValue }
    }

    @IBInspectable
    var topTextInset: CGFloat {
        get { return textInsets.top }
        set { textInsets.top = newValue }
    }

    @IBInspectable
    var bottomTextInset: CGFloat {
        get { return textInsets.bottom }
        set { textInsets.bottom = newValue }
    }
}

class PaddingLabel: UILabel {

    var edgeInset: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}

