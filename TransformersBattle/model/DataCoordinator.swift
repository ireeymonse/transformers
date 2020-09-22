//
//  DataCoordinator.swift
//  TransformersBattle
//
//  Created by Iree García on 20/09/20.
//

import CoreData

final class DataCoordinator {
   static let shared = DataCoordinator()
   private init() {}

   lazy var container: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Model")
      container.loadPersistentStores { _, error in
         if let error = error {
            fatalError("Unresolved error \(error)")
         }
      }
      return container
   }()

   static func perform(_ task: @escaping (NSManagedObjectContext) -> Void) {
      task(shared.container.viewContext)
   }

   static func fetch<T: NSManagedObject>(_ completion: @escaping ([T]) -> Void) {
      perform { context in
         let request = NSFetchRequest<T>(entityName: String(describing: T.self))
         do {
            request.returnsObjectsAsFaults = false
            completion(try context.fetch(request))
         } catch {
            print(#function, error)
            completion([])
         }
      }
   }

   static func performBackgroundTask(_ task: @escaping (NSManagedObjectContext) -> Void) {
      shared.container.performBackgroundTask(task)
   }

   var api: TransformersAPIProtocol = API()
}

// MARK: - API integration

extension DataCoordinator {
   /// Helps you to integrate the cached transformers in your view
   static func transformersListResults() -> NSFetchedResultsController<CachedTransformer> {
      let request = NSFetchRequest<CachedTransformer>(entityName: String(describing: CachedTransformer.self))
      // TODO: fetch in the background
      return .init(fetchRequest: request,
                   managedObjectContext: shared.container.viewContext,
                   sectionNameKeyPath: nil,
                   cacheName: nil)
   }

   static func save(_ modified: Transformer, completion: @escaping (Error?) -> Void) {
      shared.api.saveTransformer(modified) { response in
         // get updated transformer from response
         let updated: Transformer
         do {
            updated = try response.decode()
         } catch {
            return completion(error)
         }

         perform { context in
            let persisted = CachedTransformer(context: context)
            persisted.id = updated.id
            persisted.name = updated.name
            persisted.team = updated.team.rawValue
            persisted.strength = Int16(updated.strength)
            persisted.intelligence = Int16(updated.intelligence)
            persisted.speed = Int16(updated.speed)
            persisted.endurance = Int16(updated.endurance)
            persisted.rank = Int16(updated.rank)
            persisted.courage = Int16(updated.courage)
            persisted.firepower = Int16(updated.firepower)
            persisted.skill = Int16(updated.skill)
            // probably not even necessary
            try? context.save()
         }
         completion(nil)
      }
   }
}
