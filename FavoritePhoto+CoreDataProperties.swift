//
//  FavoritePhoto+CoreDataProperties.swift
//  PhotosApp
//
//  Created by Eugene on 12.06.2022.
//
//

import Foundation
import CoreData


extension FavoritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePhoto> {
        return NSFetchRequest<FavoritePhoto>(entityName: "FavoritePhoto")
    }

    @NSManaged public var author: String?
    @NSManaged public var date: String?
    @NSManaged public var likes: Int16
    @NSManaged public var location: String?
    @NSManaged public var photoUrl: String?

}

extension FavoritePhoto : Identifiable {

}
