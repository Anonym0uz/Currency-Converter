//
//  APIWorkerImpl.swift
//  CurrencyConverter
//
//  Created by sot on 17.02.2021.
//

import UIKit
import AOLogger

var apiWorker: APIWorker = APIWorkerImpl()

private enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol APIWorker: class {
    /// Get all currency
    func getCurrency(complete: @escaping ((Result<[String : Double], Error>) -> Void))
}

class APIWorkerImpl: APIWorker {
    func getCurrency(complete: @escaping (Result<[String : Double], Error>) -> Void) {
        setupRequest(RootModel.self, path: "latest.js") { (result) in
            switch result {
            case .success(let model):
                complete(.success(model.rates ?? [String : Double]()))
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
}

private extension APIWorkerImpl {
    
    func urlComponentsTemp(with path: String = "") -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        
        urlComponents.host = "cbr-xml-daily.ru"
        urlComponents.path = "/" + path
        
        return urlComponents
    }
    
    func setupRequest<T: Codable>(_ parseModel: T.Type, path: String, method: HTTPMethod = .get, body: [URLQueryItem] = [], complete: @escaping (Result<T, Error>) -> Void)  {
        var urlComponents = urlComponentsTemp(with: path)
        urlComponents.queryItems = body
        
        guard let url = urlComponents.url else {
            return
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.httpBody = (method == .post) ? urlComponents.percentEncodedQuery?.data(using: .utf8) : nil
                
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                complete(.failure(error))
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
                let model = try JSONDecoder.snakeCaseISO8601Date.decode(T.self, from: data)
                complete(.success(model))
            } catch let DecodingError.dataCorrupted(context) {
                Log.i(tag: "HM...", context)
            } catch let DecodingError.keyNotFound(key, context) {
                Log.e("Key '\(key)' not found: \(context.debugDescription)")
                Log.e("codingPath: \(context.codingPath)")
            } catch let DecodingError.valueNotFound(value, context) {
                Log.e("Value '\(value)' not found: \(context.debugDescription)")
                Log.e("codingPath: \(context.codingPath)")
            } catch let DecodingError.typeMismatch(type, context)  {
                Log.e("Type '\(type)' mismatch: \(context.debugDescription)")
                Log.e("codingPath: \(context.codingPath)")
            } catch {
                Log.e("error: \(error.localizedDescription)")
                complete(.failure(error))
            }
        }
        dataTask.resume()
    }
}

extension JSONDecoder {
    static var snakeCaseISO8601Date: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
