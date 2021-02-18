//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by sot on 16.02.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import AOLogger

protocol CurrencyViewModel: class {
    func viewLoaded()
}

class CurrencyViewModelImpl: CurrencyViewModel {
    
    var data: PublishSubject<[String : Double]> = PublishSubject<[String : Double]>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var isSuccess: PublishSubject<Bool> = PublishSubject<Bool>()
    
    private var currencies = [String]()
    
    func viewLoaded() {
        getData()
    }
}

private extension CurrencyViewModelImpl {
    func getData() {
        setLoad()
        apiWorker.getCurrency { [self] (result) in
            switch result {
            case .success(let model):
                data.onNext(model)
                currencies.append(contentsOf: model.keys.sorted(by: <))
                setLoad(false)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setLoad(_ load: Bool = true) {
        isLoading.onNext(load)
        isSuccess.onNext(!load)
    }
}
