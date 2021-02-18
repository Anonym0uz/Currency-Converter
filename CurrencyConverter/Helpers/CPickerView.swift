//
//  CPickerView.swift
//  CurrencyConverter
//
//  Created by sot on 18.02.2021.
//

import Foundation
import UIKit

protocol CPickerViewDelegate {
    
}

class CPickerView: UIPickerView {
    
    private var cDelegate: CPickerViewDelegate?
    
    private var items = [Any]() {
        didSet {
            reloadAllComponents()
        }
    }
    
    private var activeView: CPickerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Custom functions
extension CPickerView {
    func setData(_ data: [Any]) {
        items = data
    }
    
    // Present
    func show(on controller: UIViewController) {
        if let view = activeView {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.activeView?.alpha = 0
            } completion: { [weak self] (_) in
                view.removeFromSuperview()
                self?.activeView = nil
            }
            return
        }
        activeView = CPickerView(frame: .zero)
        activeView?.alpha = 0
        activeView?.delegate = self
        activeView?.dataSource = self
        cDelegate = controller as? CPickerViewDelegate
        if let view = activeView {
            UIView.animate(withDuration: 0.3) {
                controller.view.addSubview(view)
                view.alpha = 1
            }
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor),
                view.heightAnchor.constraint(equalToConstant: 200),
            ])
        }
    }
}

extension CPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { items[row] as? String }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { items.count }
}
