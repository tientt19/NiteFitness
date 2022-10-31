//
//  UIView.swift
//  myElcom
//
//  Created by Valerian on 13/05/2022.
//

import UIKit

// MARK: - Border
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    var width: CGFloat {
        return bounds.width
    }

    var height: CGFloat {
        return bounds.height
    }

    func roundCorners(cornes: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = cornes
    }

    func makeRound() {
        let cornerRadius = min(width, height) / 2
        self.cornerRadius = cornerRadius
    }
}
// MARK: - SKShadow
extension UIView {
    func addSKShadow(shadowColor: UIColor, offset: CGSize, radius: CGFloat, opacity: Float = 1) {
        layoutIfNeeded()
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        let cornerRadius = layer.cornerRadius
        let roundedRect = CGRect(x: 0, y: height / 2, width: width, height: height / 2)
        let shadowPath = UIBezierPath(roundedRect: roundedRect,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shadowPath = shadowPath
    }

    func addShadow(offSet: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offSet
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }

    func addShadow(width: CGFloat, height: CGFloat, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func addShadowDefault() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 4.0
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.5
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
}

// vuongbachthu
// MARK: View Layout
extension UIView {
    
    @IBInspectable
    var cornerCircle: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                self.layer.shadowColor = color.cgColor
            } else {
                self.layer.shadowColor = nil
            }
        }
    }
}

// MARK: - Nib
// swiftlint:disable force_cast
extension UIView {
    static func loadFromNib() -> Self {
        return UINib(nibName: String(describing: self), bundle: nil)
            .instantiate(withOwner: self, options: nil)[0] as! Self
    }
}

// MARK: Round Corners View
extension UIView {
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
            
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

//MAR: Gradient View
extension UIView {
    func addGradientLayer(startColor: UIColor?, centerColor: UIColor?, endColor: UIColor?) {
        let gradientLayer = CAGradientLayer()
        
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.frame = self.bounds
            if let centerColor = centerColor {
                gradientLayer.colors = [startColor.cgColor, centerColor.cgColor, endColor.cgColor]
            } else {
                gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            }
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) //startPoint //
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0) //endPoint
            
            self.layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func removeGradientLayer() {
        if let listSubLayer = self.layer.sublayers {
            for (index, subLayer) in listSubLayer.enumerated() {
                if subLayer is CAGradientLayer {
                    self.layer.sublayers!.remove(at: index)
                }
            }
        }
    }
}

// MARK: UIViewBgGradient
class UIViewBgGradient: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGradientLayer(startColor: .black, centerColor: .white, endColor: .black)
    }
}

// MARK: UIViewCornerRoundTop
class UIViewRoundCornerTop: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorner(corners: [.topLeft, .topRight], radius: 16)
    }
}

// MARK: UIViewRoundCornerShadowTop
class UIViewRoundCornerShadowTop: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorner(corners: [.topLeft, .topRight], radius: 24)
        
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.7).cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 8
        self.clipsToBounds = false
    }
}

// MARK: UIViewRoundCornerBottom
class UIViewRoundCornerBottom: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorner(corners: [.bottomLeft, .bottomRight], radius: 20)
        
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.6).cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
    }
}

// MARK: UIViewRoundCornerLeft
class UIViewRoundCornerLeft: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorner(corners: [.bottomLeft, .topLeft], radius: 8)
        self.clipsToBounds = true
    }
}

// MARK: UIViewCellShadowRadius
class UIViewCellShadowRadius: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
    }
}

// MARK: UIViewCellShadowRadius
class UIViewCellCollShadowRadius: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius = 10
        self.clipsToBounds = false
        
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 4
    }
}

// MARK: UIViewRound
class UIViewRound: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.height/2
    }
}

// MARK: UIViewShadowRadius
class UIViewShadowRadius: UIView {
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
        
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 4
    }
}

// vuongbachthu
// MARK: UIView Border Line
class UIViewBorderLine: UIView {
    private var bottomLineColorAssociatedKey: UIColor = .black
    private var topLineColorAssociatedKey: UIColor = .black
    private var rightLineColorAssociatedKey: UIColor = .black
    private var leftLineColorAssociatedKey: UIColor = .black
    
    @IBInspectable var bottomLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &bottomLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &bottomLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var bottomLineWidth: CGFloat {
        get {
            return self.bottomLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addBottomBorderWithColor(color: self.bottomLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var topLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &topLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &topLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var topLineWidth: CGFloat {
        get {
            return self.topLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addTopBorderWithColor(color: self.topLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var rightLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &rightLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &rightLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var rightLineWidth: CGFloat {
        get {
            return self.rightLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addRightBorderWithColor(color: self.rightLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var leftLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &leftLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &leftLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var leftLineWidth: CGFloat {
        get {
            return self.leftLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addLeftBorderWithColor(color: self.leftLineColor, width: newValue)
            }
        }
    }
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "topBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
        self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 1111) )
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "rightBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
         self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 2222) )
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "bottomBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
        self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 3333) )
    }
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "leftBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
        self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 4444) )
    }
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        if let objectView = object as? UIView,
            objectView === self,
            keyPath == #keyPath(UIView.bounds) {
            switch context {
            case UnsafeMutableRawPointer(bitPattern: 1111):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "topBorderLayer" {
                        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: border.frame.height)
                    }
                }
            case UnsafeMutableRawPointer(bitPattern: 2222):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "rightBorderLayer" {
                         border.frame = CGRect(x: self.frame.size.width - border.frame.width, y: 0, width: border.frame.width, height: self.frame.size.height)
                    }
                }
            case UnsafeMutableRawPointer(bitPattern: 3333):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "bottomBorderLayer" {
                        border.frame = CGRect(x: 0, y: self.frame.size.height - border.frame.height, width: self.frame.size.width, height: border.frame.height)
                    }
                }
            case UnsafeMutableRawPointer(bitPattern: 4444):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "leftBorderLayer" {
                       border.frame = CGRect(x: 0, y: 0, width: border.frame.width, height: self.frame.size.height)
                    }
                }
            default:
                break
            }
        }
    }
    func removePreviouslyAddedLayer(name: String) {
        if self.layer.sublayers?.count ?? 0 > 0 {
            self.layer.sublayers?.forEach {
                if $0.name == name {
                    $0.removeFromSuperlayer()
                }
            }
        }
    }
}

// MARK: UIViewRoundBlue
class UIViewRoundBlue: UIView {
    override func awakeFromNib() {
        self.cornerRadius = self.frame.height / 2
    }
}

// MARK: - Programatically constraints
extension UIView {
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    /// Add constraints programatically.
    ///
    /// - Parameters:
    ///   - top:            constraint to top anchor
    ///   - left:           constraint to left anchor
    ///   - bottom:         constraint to bottom anchor
    ///   - right:          constraint to right anchor
    ///   - paddingTop:     top padding
    ///   - paddingLeft:    left padding
    ///   - paddingBottom:  bottom padding
    ///   - paddingRight:   right padding
    ///   - width:          set width
    ///   - height:         set height
    /// - Returns: Void
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    /// Center to superview
    ///
    /// - Parameters:
    ///   - view:      center to view
    ///   - yConstant: set y constraint
    /// - Returns: Void
    func center(inView view: UIView, xConstant: CGFloat? = 0, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xConstant!).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    /// Center X to superview
    ///
    /// - Parameters:
    ///   - view:       superview
    ///   - topAnchor:  constraint to top anchor
    ///   - paddingTop: add padding top
    /// - Returns: Void
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    /// Center Y to superview
    ///
    /// - Parameters:
    ///   - view:        superview
    ///   - leftAnchor:  constraint to left anchor
    ///   - paddingLeft: add padding left
    ///   - constant:    constant set to center y anchor
    /// - Returns: Void
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    /// Set view dimensions
    ///
    /// - Parameters:
    ///     - width:  set width anchor
    ///     - height: set height anchor
    /// - Returns: Void
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Set constaint full to superview
    ///
    /// - Parameters:
    ///   - view: superview
    /// - Returns: Void
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
   
    /// Constraints by visual format.
    ///
    /// - Parameters:
    ///   - format: format
    ///   - views:  constraint in view
    /// - Returns: Void
    func addVisualFormatConstraint(format: String, views: UIView...) {
        var viewDictionaries = [String: UIView]()
        
        for (key, view) in views.enumerated() {
            let key = "v\(key)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionaries[key] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionaries))
    }
    
    /// fill superview
    /// - Returns: Void
    func fillSuperView() {
        self.superview?.addVisualFormatConstraint(format: "H:|[v0]|", views: self)
        self.superview?.addVisualFormatConstraint(format: "V:|[v0]|", views: self)
    }
    
    /// Remove all subviews in view.
     func removeSubviews() {
        subviews.forEach({$0.removeFromSuperview()})
    }
    
    func constraintToAllSides(of container: UIView, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: topOffset),
            leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: leftOffset),
            trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: rightOffset),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: bottomOffset)
        ])
    }
}

extension UIView {
    func cardView()-> Void {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
}
