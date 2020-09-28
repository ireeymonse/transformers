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

   var api: TransformersAPIProtocol = API()
}

// MARK: - Private operations

private extension DataCoordinator {
   static var viewContext: NSManagedObjectContext {
      return shared.container.viewContext
   }

   static func perform(_ task: @escaping (NSManagedObjectContext) -> Void) {
      task(shared.container.viewContext)
   }

   static func fetch<T: NSManagedObject>(predicate: NSPredicate? = nil) throws -> [T] {
      let request = T.request
      request.predicate = predicate
      request.returnsObjectsAsFaults = false
      return try viewContext.fetch(request)
   }

   static func performBackgroundTask(_ task: @escaping (NSManagedObjectContext) -> Void) {
      shared.container.performBackgroundTask(task)
   }
}

extension NSObjectProtocol where Self: NSManagedObject {
   static var request: NSFetchRequest<Self> {
      return NSFetchRequest<Self>(entityName: String(describing: self))
   }
}

// MARK: - API integration

extension DataCoordinator {
   /// Helps you to integrate the cached transformers in your view
   static func fetchTransformerList(cacheOnly: Bool = false, update: @escaping ([Transformer]?) -> Void) {
      // get from cache
      do {
         let results: [CachedTransformer] = try fetch()
         let list = results.map { Transformer(cache: $0) }
         update(list)
      } catch {
         if cacheOnly { update(nil) } // ensures calling update at least once
      }
      if cacheOnly { return }

      // fetch in the background
      shared.api.getTransformers { response in
         do {
            let result: Transformer.List = try response.decode()
            update(result.transformers)
            purge(with: result.transformers)
         } catch {
            update(nil)
         }
      }
   }

   // FIXME: use ids to improve the algorithm
   private static func purge(with remotes: [Transformer]) {
      // destroy everything
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CachedTransformer.self))
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
      do {
         try shared.container.persistentStoreCoordinator.execute(deleteRequest, with: viewContext)
      } catch {}
      // create anew

      for remote in remotes {
         // find or create
         let local = CachedTransformer(context: viewContext)
         local.id = remote.id
         local.name = remote.name
         local.team = remote.team.rawValue
         local.strength = Int16(remote.strength)
         local.intelligence = Int16(remote.intelligence)
         local.speed = Int16(remote.speed)
         local.endurance = Int16(remote.endurance)
         local.rank = Int16(remote.rank)
         local.courage = Int16(remote.courage)
         local.firepower = Int16(remote.firepower)
         local.skill = Int16(remote.skill)
      }
      // probably not even necessary
      try? viewContext.save()
   }

   static func fetchTransformer(id: String?) -> CachedTransformer? {
      guard let id = id else {
         return nil
      }
      let predicate = NSPredicate(format: "id == %@", id)
      return try? fetch(predicate: predicate).first
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

         // find or create
         let persisted = fetchTransformer(id: updated.id) ?? CachedTransformer(context: viewContext)
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
         try? viewContext.save()

         completion(nil)
      }
   }

   static func deleteTransformer(id: String, completion: @escaping (Error?) -> Void) {
      shared.api.removeTransformer(id: id) { response in
         guard response.isSuccessful else {
            return completion(response.error ?? APIError.noData)
         }
         fetchTransformer(id: id).map { found in
            viewContext.delete(found)
         }
         completion(nil)
      }
   }
}

private extension Transformer {
   init(cache: CachedTransformer) {
      id = cache.id
      name = cache.name ?? ""
      team = Team(rawValue: cache.team ?? "") ?? .decepticon
      strength = Int(cache.strength)
      intelligence = Int(cache.intelligence)
      speed = Int(cache.speed)
      endurance = Int(cache.endurance)
      rank = Int(cache.rank)
      courage = Int(cache.courage)
      firepower = Int(cache.firepower)
      skill = Int(cache.skill)
   }
}
