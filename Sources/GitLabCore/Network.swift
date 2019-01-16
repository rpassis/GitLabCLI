//
//  Network.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

class Network {

    private let session: URLSession
    private let decoder: DecoderType

    init(session: URLSession = URLSession.shared, decoder: DecoderType = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(_ endpoint: EndPointType, then callback: @escaping ((T?, Error?) -> Void)) {
        do {
            let urlRequest = try endpoint.asURLRequest()
            self.session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                guard
                    let data = data,
                    let decodable: T? = try? self?.decoder.decode(data) else {
                        let error = error ?? NetworkError.unknown
                        callback(nil, error)
                        return
                }
                callback(decodable, nil)
            }.resume()
        } catch {
            callback(nil, error)
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case unknown
    var errorDescription: String? {
        return NSLocalizedString("Unknown error", comment: "Unknown error")
    }
}
