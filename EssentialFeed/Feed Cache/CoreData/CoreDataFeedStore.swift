//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Sami Ali on 10/9/20.
//

import Foundation
import CoreData

public final class CoreDataFeedStore: FeedStore {
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(withModelName: "FeedStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        let possibleDeleteError = deleteAllCachedData()
        completion(possibleDeleteError)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
        perform { context in
            let cache = ManagedCache.getUniqueManagedCache(in: context)
            cache.timestamp = timestamp
            cache.feed = feed.mapToManagedFeedImages(in: context).toNSOrderedSet
            
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
        
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
        perform { context in
            guard let managedCaches = try? context.fetch(ManagedCache.fetchRequest() as NSFetchRequest<ManagedCache>),
                  let firstObject = managedCaches.first,
                  let timestamp = firstObject.timestamp else {
                
                return completion(.empty)
            }
            
            let localFeedImages = firstObject.managedFeedImages.map( {$0.localFeedImage} )
            completion(.found(feed: localFeedImages, timestamp: timestamp))
        }
    }
    
    private func deleteAllCachedData() -> Error? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedCache")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let result = try context.execute(batchDeleteRequest) as! NSBatchDeleteResult
            let changes: [AnyHashable: Any] = [
                NSDeletedObjectsKey: result.result as! [NSManagedObjectID]
            ]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            return nil
        } catch {
            return error
        }
        
    }
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
    
}

