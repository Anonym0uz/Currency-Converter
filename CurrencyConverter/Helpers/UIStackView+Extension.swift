//
//  UIStackView+Extension.swift
//  PSWRecords
//
//  Created by Мак Аймак on 17.08.2020.
//  Copyright © 2020 PSW. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Initializers
public extension UIStackView {
    
    enum StackType: NSLayoutConstraint.Axis.RawValue {
        case HStack = 0
        case VStack = 1
    }
    
    /// Create Stack view like SwiftUI types
    convenience init(
        type: StackType,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        backColor: UIColor = .clear) {

        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = NSLayoutConstraint.Axis(rawValue: type.rawValue)!
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.backgroundColor = backColor
    }

    /// SwifterSwift: Adds array of views to the end of the arrangedSubviews array.
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }

    /// SwifterSwift: Removes all views in stack’s array of arranged subviews.
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
        
        for view in subviews {
            view.removeFromSuperview()
        }
    }

}
