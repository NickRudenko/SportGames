//
//  EventCategoryTableViewCellViewModel.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation
import Bond
import UIKit

final class EventCategoryTableViewCellViewModel {
    let title = Observable<String>("")
    let categoryImage = Observable<UIImage?>(nil)
    let isCategoryCollapsed = Observable<Bool>(true)
    let collapseButtonImage = Observable<UIImage?>(UIImage(named: "chevron.down"))
    let events = Observable<[Event]>([])
    
    var model: EventCategory? {
        didSet {
            guard let model = model else { return }
            title.value = model.categoryName
            events.value = model.events.sorted()
            setIconFor(category: model.categoryName)
        }
    }
    
    func collapseButtonTapped() {
        isCategoryCollapsed.value = !isCategoryCollapsed.value
        if isCategoryCollapsed.value {
            collapseButtonImage.value = UIImage(named: "chevron.down")
        } else {
            collapseButtonImage.value = UIImage(named: "chevron.up")
        }
    }
    
    func setEvents() {
        guard let model = model else { return }
        events.value = model.events.sorted()
    }
    
    private func setIconFor(category: String) {
        switch category {
        case "SOCCER":
            categoryImage.value = UIImage(named: "soccer_icon")
        case "TENNIS":
            categoryImage.value = UIImage(named: "tennis_icon")
        case "BASKETBALL":
            categoryImage.value = UIImage(named: "basketball_icon")
        default:
            categoryImage.value = nil
        }
    }
    
    
}
