//
//  UIMaker.swift
//  CurrencyConverter
//
//  Created by sot on 16.02.2021.
//

import UIKit

// MARK: - Setup navigation controller
func setupNavigationController(_ controller: UINavigationController!,
                               item: UINavigationItem,
                               navigationTitle: String = "",
                               hideBackText: Bool = true,
                               leftButtons: [UIBarButtonItem] = [],
                               rightButtons: [UIBarButtonItem] = []) -> Void {
    item.title = navigationTitle
    item.leftBarButtonItems = leftButtons
    item.rightBarButtonItems = rightButtons
    if hideBackText {
        item.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    controller.navigationBar.tintColor = .red
    controller.navigationBar.isTranslucent = false
    controller.navigationBar.barTintColor = .systemBackground
    controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
    controller.navigationBar.barStyle = .default
    controller.navigationBar.shadowImage = UIImage()
}

struct UIMaker {
}
