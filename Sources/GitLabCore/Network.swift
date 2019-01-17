//
//  Network.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation
import RxSwift

class Network {

    private let session: URLSession
    private let decoder: DecoderType

    init(session: URLSession = URLSession.shared, decoder: DecoderType = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    @discardableResult
    func request<T: Decodable>(_ endpoint: EndPointType, then callback: @escaping ((T?, Error?) -> Void)) -> URLSessionTask? {
        do {
            let urlRequest = try endpoint.asURLRequest()
            let task = self.session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                guard
                    let data = data,
                    let decodable: T? = try? self?.decoder.decode(data) else {
                        let error = error ?? NetworkError.unknown
                        callback(nil, error)
                        return
                }
                callback(decodable, nil)
            }
            task.resume()
            return task
        } catch {
            callback(nil, error)
        }
        return nil
    }
}

enum NetworkError: Error, LocalizedError {
    case unknown
    var errorDescription: String? {
        return NSLocalizedString("Unknown error", comment: "Unknown error")
    }
}

extension Reactive where Base: Network {

    func request<T: Decodable>(_ endpoint: EndPointType) -> Single<T> {
        return Single<T>.create { event in
            let task = self.base.request(endpoint) { (decodable: T?, error: Error?) in
                guard let decodable = decodable else {
                    let error = error ?? NetworkError.unknown
                    event(.error(error))
                    return
                }
                event(.success(decodable))
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
