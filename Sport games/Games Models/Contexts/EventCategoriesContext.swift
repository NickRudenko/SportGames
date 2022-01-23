//
//  EventCategoriesContext.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation
import Fetch

public protocol EventCategoriesContextQuerible {
    /// perform fetching all event categories
    func fetchAllCategories(completion: @escaping (FetchResult<EventCategoies>) -> Void)
}

public final class EventCategoriesContext: EventCategoriesContextQuerible {
    let session = Session()
    
    public func fetchAllCategories(completion: @escaping (FetchResult<EventCategoies>) -> Void) {
        let request = EventCategoriesRequest()
        session.perform(request, completion: completion)
    }

}
