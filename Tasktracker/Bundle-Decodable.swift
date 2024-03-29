//
//  Bundle-Decodable.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/30/21.
//

//MARK: NOTE
// Great extension for deconding but only when the JSON is in the inside the app. DO not use this for decoding from the internet.

import Foundation

extension Bundle {
   
   func decode<T: Decodable>(_ type: T.Type, from file: String,
            dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
            keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
      
      guard let url = self.url(forResource: file, withExtension: nil) else {
         fatalError("Failed to locate \(file) in bundle.")
      }
      
      guard let data = try? Data(contentsOf: url) else {
         fatalError("Failed to locate \(file) in bundle.")
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = dateDecodingStrategy
      decoder.keyDecodingStrategy = keyDecodingStrategy
      
      do {
         return try decoder.decode(T.self, from: data)
      } catch DecodingError.keyNotFound(let key, let context) {
         fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
      } catch DecodingError.typeMismatch(_, let context) {
         fatalError("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
      } catch DecodingError.valueNotFound(let type, let context) {
         fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
      } catch DecodingError.dataCorrupted(_) {
         fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
      } catch {
         fatalError("Failed to decode \(file) fomr bundle: \(error.localizedDescription)")
      }
      
   }//func
   
}//ext

