//
//  CoreDataCRUDHelper.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/11/21.
//

import UIKit

struct CoreDataCRUDHelper {
    //MARK: - CoreData Context
    static var allCurrentJokes = [SavedJokeData]()

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static func fetchSavedJokes() -> [SavedJokeData] {
        do {
            let jokes = try context.fetch(SavedJokeData.fetchRequest()) as? [SavedJokeData]
            return jokes?.reversed() ?? []
        } catch {
            print("DEBUG: Error fetching saved jokes from core data -> \(error.localizedDescription)")
        }

        return []
    }

    static func saveJoke(id: String, joke: String, completion: @escaping(Bool) -> Void) {
        let savedJokes = fetchSavedJokes()
        
        for savedJoke in savedJokes {
            guard let savedJokeID = savedJoke.id, savedJokeID != id else {
                completion(false)
                return
            }
        }

        let newSavedJoke = SavedJokeData(context: context)
        newSavedJoke.id = id
        newSavedJoke.joke = joke

        do {
            try context.save()
            completion(true)
        } catch {
            print("DEBUG: Error saving jokes to core data -> \(error.localizedDescription)")
            completion(false)
        }
    }

    static func deleteJoke(joke: SavedJokeData) {
        context.delete(joke)

        do {
            try context.save()
        } catch {
            print("DEBUG: Error delete jokes in core data -> \(error.localizedDescription)")
        }
    }

    static func updateJoke(item: SavedJokeData, newJoke: String) {
        item.joke = newJoke
        do {
            try context.save()
        } catch {
            print("DEBUG: Error update jokes in core data -> \(error.localizedDescription)")
        }
    }

}
