//
//  Event.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation

public class Event: Codable, Comparable {
    public static func < (lhs: Event, rhs: Event) -> Bool {
        let sameFavouriteState = lhs.isFavourite == rhs.isFavourite
        if sameFavouriteState {
            return lhs.eventStartTime > rhs.eventStartTime
        } else {
            return lhs.isFavourite
        }
    }
    
    public static func == (lhs: Event, rhs: Event) -> Bool {
        let sameFavouriteState = lhs.isFavourite == rhs.isFavourite
        let sameEventId = lhs.eventId == rhs.eventId
        let sameSportId = lhs.sportId == rhs.sportId
        return sameFavouriteState && sameEventId && sameSportId
    }
    
    public let eventId: String
    public let sportId: String
    public let name: String
    public let eventStartTime: Date
    public var isFavourite = false
    
    enum CodingKeys: String, CodingKey {
        case eventId = "i"
        case sportId = "si"
        case name = "d"
        case eventStartTime = "tt"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventId = try container.decode(String.self, forKey: .eventId)
        sportId = try container.decode(String.self, forKey: .sportId)
        name = try container.decode(String.self, forKey: .name)
        let unixTimeInterval = try container.decode(TimeInterval.self, forKey: .eventStartTime)
        eventStartTime = Date(timeIntervalSince1970: unixTimeInterval)
    }
    
    public func encode(to encoder: Encoder) throws {
        fatalError("Encoding not implemented")
    }
}
