//
//  EventCategory.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation

public class EventCategory: Codable {
    public let categoryId: String
    public let categoryName: String
    public let events: [Event]
    
    private enum CodingKeys: String, CodingKey {
        case categoryId = "i"
        case categoryName = "d"
        case events = "e"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try container.decode(String.self, forKey: .categoryId)
        categoryName = try container.decode(String.self, forKey: .categoryName)
        events = try container.decode([Event].self, forKey: .events)
    }
    
    public func encode(to encoder: Encoder) throws {
        fatalError("Encoding not implemented")
    }
}

public enum FetchError: Error {
    case statusCodeError
    case parseError
  }
