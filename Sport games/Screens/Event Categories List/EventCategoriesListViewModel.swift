//
//  EventCategoriesListViewModel.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation
import Bond
import Fetch

class EventCategoriesListViewModel {
    private let context: EventCategoriesContextQuerible
    var model: EventCategoies? {
        didSet {
            guard let model = model else { return }
            categories.value = model.categories
        }
    }
    let categories = Observable<[EventCategory]>([])
    let errorShouldBeShown = Observable<Bool>(false)
    let errorMessage = Observable<String>("")
    
    init(context: EventCategoriesContextQuerible = EventCategoriesContext()) {
        self.context = context
    }
    
    public func fetchCategories() {
        context.fetchAllCategories { [weak self] result in
            self?.handleFetch(result: result)
            
        }
    }
    
    private func handleFetch(result: FetchResult<EventCategoies>) {
        switch result {
        case let .success(fetchedCategories):
            self.errorShouldBeShown.value = false
            self.model = fetchedCategories
            
        case let .failure(error):
            prepareErrorMessageFrom(error: error)
            self.errorShouldBeShown.value = true
        }
    }
    
    private func prepareErrorMessageFrom(error: Error) {
        if let error = error as? FetchError {
            switch error {
            case .parseError:
                errorMessage.value = "Service currently unavailable. We are working on it. The problem will be solved soon!"
            case .statusCodeError:
                errorMessage.value = "Something went wrong during loading. Please pull down to refresh."
            }
        } else {
            errorMessage.value = "Something went wrong during loading"
        }
    }
}

