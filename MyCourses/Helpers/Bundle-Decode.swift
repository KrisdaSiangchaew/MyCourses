//
//  Bundle-Decode.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 5/12/2563 BE.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Cannot find \(file) in the bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Cannot load \(file) from the bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode from \(file) due to missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("Failed to decode from \(file) due to corrupt data - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode from \(file) due to mismatch type - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(_, let context) {
            fatalError("Failed to decode from \(file) due to value not found - \(context.debugDescription)")
        } catch {
            fatalError("Failed to decode from \(file) - \(error.localizedDescription)")
        }
    }
}
