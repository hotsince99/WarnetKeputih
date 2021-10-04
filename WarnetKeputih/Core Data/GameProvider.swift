//
//  GameProvider.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 02/10/21.
//

import CoreData

class GameProvider {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameRawg")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getAllFavoriteGame(completion: @escaping(_ games: [GameFavorite]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameFavoriteEntity")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameFavorite] = []
                for result in results {
                    let game = GameFavorite(
                        id: result.value(forKeyPath: "id") as? Int32,
                        name: result.value(forKeyPath: "name") as? String,
                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                        rating: result.value(forKeyPath: "rating") as? Float,
                        released: result.value(forKeyPath: "released") as? String,
                        desc: result.value(forKeyPath: "desc") as? String,
                        website: result.value(forKeyPath: "website") as? String
                    )
                    
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func addGameToFavorite(
        _ id: Int32,
        _ name: String,
        _ backgroundImage: String,
        _ rating: Float,
        _ released: String,
        _ desc: String,
        _ website: String,
        completion: @escaping() -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "GameFavoriteEntity", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(id, forKeyPath: "id")
                game.setValue(name, forKeyPath: "name")
                game.setValue(backgroundImage, forKeyPath: "backgroundImage")
                game.setValue(rating, forKeyPath: "rating")
                game.setValue(released, forKeyPath: "released")
                game.setValue(desc, forKeyPath: "desc")
                game.setValue(website, forKeyPath: "website")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func removeGameFromFavorite(_ gameId: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameFavoriteEntity")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(gameId)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
   }
    
    func isFavorite(gameId: Int, completion: @escaping (Bool) -> Void) {
        let taskContext = newTaskContext()
    
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameFavoriteEntity")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(gameId)")
            do {
                let _ = try (taskContext.fetch(fetchRequest).first != nil) ? completion(true) : completion(false)
            } catch {
                print(error)
            }
        }
    }
    
    
    
}
