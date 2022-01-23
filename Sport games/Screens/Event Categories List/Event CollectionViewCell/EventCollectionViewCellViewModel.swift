//
//  EventCollectionViewCellViewModel.swift
//  Sport games
//
//  Created by Mykola Rudenko on 23.01.2022.
//

import Foundation
import Bond
import UIKit

final class EventCollectionViewCellViewModel {
    var model: Event? {
        didSet {
            guard let model = model else { return }
            eventName.value = model.name
            prepareStartDateStringFrom(date: model.eventStartTime)
            prepareFavouriteButtonImageFor(state: model.isFavourite)
            
        }
    }
    
    let startDateString = Observable<String>("")
    let favouriteButtonImage = Observable<UIImage?>(nil)
    let eventName = Observable<String>("")
    let isFavourite = Observable<Bool>(false)
    let shouldReloadCollection = Observable<Bool>(false)
    
    func favouriteButtonTapped() {
        guard let isCurrentlyFavourite = model?.isFavourite else { return }
        model?.isFavourite = !isCurrentlyFavourite
        shouldReloadCollection.value = true
    }
    
    private func prepareStartDateStringFrom(date: Date) {
        startDateString.value = date.getFormattedDate(format: "HH:MM:SS")
    }
    
    private func prepareFavouriteButtonImageFor(state isFavourite: Bool) {
        if isFavourite {
            favouriteButtonImage.value = UIImage(named: "star.fill")
        } else {
            favouriteButtonImage.value = UIImage(named: "star")
        }
    }
    
}
