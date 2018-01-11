//
//  SearchBarExtension.swift
//  aywa
//
//  Created by Bestpeers on 11/01/18.
//  Copyright © 2018 Alpha Solutions. All rights reserved.
//

import Foundation
import UIKit
extension UISearchBar {
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    func getSearchBarTextField() -> UITextField? {
        return getViewElement(type: UITextField.self)
    }
    func setTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.textColor = color
            textField.font = UIFont(name: "Helvetica", size: 22)
        }
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
    func setPlaceholderTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.font = UIFont(name: "Helvetica", size: 22)
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: color])
            
        }
    }
    func setMagnifyingGlassColorTo(color: UIColor)
    {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
    func hideorShowLeftSearchIcon(isShow: Bool) {
        if !isShow {
            if let textField = getSearchBarTextField() {
                //        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as! UITextField
                textField.leftViewMode = UITextFieldViewMode.never
            }
        }
    }
}