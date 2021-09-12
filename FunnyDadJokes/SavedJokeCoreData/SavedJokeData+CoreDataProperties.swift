//
//  SavedJokeData+CoreDataProperties.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/11/21.
//
//

import Foundation
import CoreData


extension SavedJokeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedJokeData> {
        return NSFetchRequest<SavedJokeData>(entityName: "SavedJokeData")
    }

    @NSManaged public var joke: String?
    @NSManaged public var id: String?

}

extension SavedJokeData : Identifiable {

}
