//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by sot on 16.02.2021.
//

import UIKit

var dataTask: URLSessionDataTask?

private func urlComponentsTemp(with path: String = "") -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    
    urlComponents.host = "cbr-xml-daily.ru"
    urlComponents.path = "/" + path
    
    return urlComponents
}

class CurrencyViewController: UIViewController {
    
    let rootStack: UIStackView = .init(type: .HStack, spacing: 10, alignment: .fill, distribution: .fillEqually)
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController(navigationController,
                                  item: navigationItem,
                                  navigationTitle: "Wow, much!")
        
        setupUI()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        NSLayoutConstraint.activate([
            rootStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            rootStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rootStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            rootStack.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

private extension CurrencyViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(rootStack)
        rootStack.addArrangedSubviews([ fromField, toField ])
        
        var urlComponents = urlComponentsTemp(with: "daily_json.js")
        urlComponents.queryItems = [
        ]
        
        guard let url = urlComponents.url else {
            return
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
                
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                return
            }
            
            guard let resp = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...301).contains(resp.statusCode) else {
                return
            }
                        
            guard let data = data else {
                return
            }
            
            do {
                let model = try JSONDecoder().decode(RootModel.self, from: data)
                print(model)
//                complete(model, success)
            } catch let DecodingError.dataCorrupted(context) {
//                Log.i(tag: "GET_GEO", context)
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
//                Log.e("Key '\(key)' not found: \(context.debugDescription)")
//                Log.e("codingPath: \(context.codingPath)")
                print(context)
            } catch let DecodingError.valueNotFound(value, context) {
//                Log.e("Value '\(value)' not found: \(context.debugDescription)")
//                Log.e("codingPath: \(context.codingPath)")
                print(context)
            } catch let DecodingError.typeMismatch(type, context)  {
//                Log.e("Type '\(type)' mismatch: \(context.debugDescription)")
//                Log.e("codingPath: \(context.codingPath)")
                print(context)
            } catch {
//                Log.e("error: \(error.localizedDescription)")
                print(error.localizedDescription)
            }
            
            print(data)
        }
        dataTask.resume()
    }
}
