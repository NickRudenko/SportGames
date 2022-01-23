//
//  EventCategories.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation
import Fetch

public struct EventCategoies: Codable {
    public let categories: [EventCategory]
}

extension EventCategoies: Parsable {
    public static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<EventCategoies> {
        guard response.status == 200 else {
            if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
                return .failure(error)
              }
            return .failure(FetchError.statusCodeError)
            }
        guard let data = response.data,
              let categories = try? JSONDecoder().decode([EventCategory].self, from: data)
        else {
                  return .failure(FetchError.parseError)
              }
        return .success(EventCategoies(categories: categories))
    }
    
}
