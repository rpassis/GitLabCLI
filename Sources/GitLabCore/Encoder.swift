//
//  Encoder.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

protocol EncoderType {
    func encode<T: Encodable>(_ encodable: T) throws -> Data
}

protocol DecoderType {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

extension JSONDecoder: DecoderType {
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try decode(T.self, from: data)
    }
}

extension JSONDecoder: EncoderType {
    func encode<T: Encodable>(_ encodable: T) throws -> Data {
        return try encode(encodable)
    }
}
