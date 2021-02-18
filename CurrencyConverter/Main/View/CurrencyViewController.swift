//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by sot on 16.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyViewController: UIViewController {
    
    // MARK: Private props
    private let rootStack: UIStackView = .init(type: .VStack, spacing: 10, alignment: .fill, distribution: .fillEqually)
    private let fieldsStack: UIStackView = .init(type: .HStack, spacing: 10, alignment: .fill, distribution: .fillEqually)
    
    private var items = PublishSubject<[String : Double]>()
    private var currency = [String : Double]()
    private let viewModel: CurrencyViewModelImpl = CurrencyViewModelImpl()
    private lazy var notifier: CurrencyViewModel = viewModel
    private let disBag = DisposeBag()
    
    let pickerView: CPickerView = CPickerView()
    
    let fromField: CTextField = {
        CTextField()
            .setAlignment(.left)
            .setKeyboardType(.decimalPad)
            .setPlaceholder("From")
            .setTextColor(.label)
            .showBorder()
    }()
    
    let toField: CTextField = {
        CTextField()
            .setAlignment(.left)
            .setKeyboardType(.decimalPad)
            .setPlaceholder("To")
            .setTextColor(.label)
            .showBorder()
    }()
    
    let btn: UIButton = {
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Test", for: .normal)
        b.backgroundColor = .cyan
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController(navigationController,
                                  item: navigationItem,
                                  navigationTitle: "Wow, much!")
        
        setupUI()
        setupBinding()
        notifier.viewLoaded()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        NSLayoutConstraint.activate([
            rootStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            rootStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rootStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            rootStack.heightAnchor.constraint(equalToConstant: 40),
            
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.topAnchor.constraint(equalTo: rootStack.bottomAnchor, constant: 20),
            btn.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

private extension CurrencyViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(rootStack)
        rootStack.addArrangedSubview(fieldsStack)
        fieldsStack.addArrangedSubviews([ fromField, toField ])
        view.addSubview(btn)
        view.setNeedsUpdateConstraints()
    }
    
    func setupBinding() {
        viewModel
            .data
            .observe(on: MainScheduler.instance)
            .bind(to: items)
            .disposed(by: disBag)
        
        items
            .bind { (models) in
                self.currency = models
            }
            .disposed(by: disBag)
        
        btn.rx
            .controlEvent(.touchUpInside)
            .bind { [self] (_) in
                pickerView.show(on: self)
                pickerView.setData(Array(currency.keys.sorted(by: <)))
            }
            .disposed(by: disBag)
    }
}
