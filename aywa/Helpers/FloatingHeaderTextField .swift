//
//  FloatingHeaderTextField.swift
//  ViewAnimation
//
//  Created by Navneet on 12/25/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

class FloatingHeaderTextField: UITextField {
    
    @IBInspectable
    open var activeColor: UIColor = .cyan {
        didSet {
            if isActive {
                setActiveState()
            }
        }
    }
    
    @IBInspectable
    open var inActiveColor: UIColor = .gray {
        didSet {
            if !isActive {
                setInActiveState()
            }
        }
    }
    
    open var placeholderFontScale: CGFloat = 0.7
    
    open var isActive: Bool = false {
        didSet {
            isActive ? setActiveState() : setInActiveStateIfShould()
        }
    }
    
    var placeholderLabel = UILabel()
    var underLineLayer: CAShapeLayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height))
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        
        underLineLayer = CAShapeLayer()
        underLineLayer.path = path.cgPath
        self.layer.addSublayer(underLineLayer)
        
        placeholderLabel = UILabel()
        if !(self.text?.isEmpty)! {
            isActive = true
            placeholderLabel.text = placeholder
            textFieldDidBeginEditing()
        } else {
            isActive = false
        }
        
        addSubview(placeholderLabel)
    }
    
    override open func drawPlaceholder(in rect: CGRect) {
        super.drawPlaceholder(in: rect)
        placeholderLabel.text = placeholder
        placeholder = nil
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: Notification.Name.UITextFieldTextDidEndEditing, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc func textFieldDidBeginEditing() {
        
        UIView.animate(withDuration: 0.25) {
            self.isActive = true
        }
    }
    
    @objc func textFieldDidEndEditing() {
        let isNotEmpty = text?.characters.isEmpty ?? true
        
        if isNotEmpty {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.isActive = false
            })
        }
    }
    
    func setInActiveState()  {
        underLineLayer.fillColor = UIColor.clear.cgColor
        underLineLayer.strokeColor = inActiveColor.cgColor
        placeholderLabel.textColor = inActiveColor
        
        self.placeholderLabel.transform = CGAffineTransform.identity
        self.placeholderLabel.frame = CGRect(x: 13, y: 0, width: self.bounds.width - 10, height: self.bounds.height)
    }
    
    func setActiveState() {
        underLineLayer.fillColor = UIColor.clear.cgColor
        underLineLayer.strokeColor = activeColor.cgColor
        placeholderLabel.textColor = activeColor
        
        self.placeholderLabel.frame = CGRect(x: 13, y: -20, width: self.bounds.size.width - 20, height: 44)
        self.placeholderLabel.transform = CGAffineTransform(scaleX: self.placeholderFontScale, y: self.placeholderFontScale)
        self.placeholderLabel.frame.origin = CGPoint(x: 13, y: self.placeholderLabel.frame.origin.y)
    }
    
    func setInActiveStateIfShould() {
        if (self.text?.isEmpty)! {
            self.setInActiveState()
        }
    }
    
}
