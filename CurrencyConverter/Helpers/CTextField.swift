//
//  CTextField.swift
//  CurrencyConverter
//
//  Created by Alexander Orlov on 16.02.2021.
//

import Foundation
import UIKit

// MARK: - CTextField by UITextField
class CTextField: UITextField {
    
    var borderView: UIView?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        leftViewMode = .always
        leftView = UIView(frame: .init(x: 0, y: 0, width: 15, height: 15))
        rightViewMode = .always
        rightView = UIView(frame: .init(x: 0, y: 0, width: 15, height: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CTextField {
    /// By default, view is setted & mode is .always
    func setLeftView(_ v: UIView, mode: UITextField.ViewMode = .always) -> CTextField {
        leftView = v
        leftViewMode = mode
        return self
    }
    /// By default, view is setted & mode is .always
    func setRightView(_ v: UIView, mode: UITextField.ViewMode = .always) -> CTextField {
        rightView = v
        rightViewMode = mode
        return self
    }
    
    func setKeyboardType(_ t: UIKeyboardType) -> CTextField {
        keyboardType = t
        return self
    }
    
    func setAlignment(_ a: NSTextAlignment) -> CTextField {
        textAlignment = a
        return self
    }
    
    func setTextColor(_ c: UIColor) -> CTextField {
        textColor = c
        return self
    }
    
    func setPlaceholder(_ p: String) -> CTextField {
        placeholder = p
        return self
    }
    
    func setText(_ t: String?) -> CTextField {
        text = t
        return self
    }
    
    func setTag(_ i: Int) -> CTextField {
        tag = i
        return self
    }
    
    func isValid() -> Bool {
        guard let txt = text else {
            return false
        }
        if !txt.isEmpty &&
            txt.count > 0 &&
            txt != " " &&
            txt != "0" {
            return true
        }
        return false
    }
    
    func trimmed() -> String {
        guard let txt = text else {
            return ""
        }
        return txt.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension CTextField {
    func showBorder() -> CTextField {
        borderView = UIView()
        guard let borderView = borderView else {
            fatalError("Border setup error.")
        }
        borderView.backgroundColor = .lightGray
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            borderView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        return self
    }
}
