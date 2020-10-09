//
//  Helpers.swift
//  EssentialFeed
//
//  Created by Sami Ali on 10/9/20.
//

import CoreData

public extension ManagedFeedImage {
    var localFeedImage: LocalFeedImage {
        return LocalFeedImage(id: id!, description: imageDescription, location: location, url: url!)
    }
}

internal extension ManagedCache {
    var managedFeedImages: [ManagedFeedImage] {
        return feed?.array as? [ManagedFeedImage] ?? []
    }
    
    @nonobjc class func fetchCache(in context: NSManagedObjectContext) throws -> ManagedCache? {
        let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    static func getUniqueManagedCache(in context: NSManagedObjectContext) -> ManagedCache {
        if let managedCaches = try? fetchCache(in: context) {
            context.delete(managedCaches)
        }
        
        return ManagedCache(context: context)
    }
}

internal extension Array {
    var toNSOrderedSet: NSOrderedSet {
        return NSOrderedSet(array: self)
    }
}

internal extension Array where Element == LocalFeedImage {
    
    func mapToManagedFeedImages(in context: NSManagedObjectContext) -> [ManagedFeedImage] {
        
        let managedFeedArray = self.map { (localImage) -> ManagedFeedImage in
            let managedFeedImage = ManagedFeedImage(context: context)
            managedFeedImage.id = localImage.id
            managedFeedImage.imageDescription = localImage.description
            managedFeedImage.location = localImage.location
            managedFeedImage.url = localImage.url
            return managedFeedImage
        }
        
        return managedFeedArray
    }
}

internal extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        guard let url = bundle.url(forResource: name, withExtension: "momd") else {
            return nil
        }
        
        return NSManagedObjectModel(contentsOf: url)
    }
}


internal extension NSPersistentContainer {
    enum LoadError: Swift.Error {
        case didNotFindModel
        case didFailToLoadPersistentStores(Swift.Error)
    }
    
    static func load(withModelName name: String, url: URL, in bundle: Bundle) throws -> NSPersistentContainer {
        guard let managedObjectModel = NSManagedObjectModel.with(name: name, in: bundle) else {
            throw LoadError.didNotFindModel
        }
        
        let container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)
        
        var loadError: Swift.Error?
        
        let description = NSPersistentStoreDescription(url: url)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (_, error) in
            loadError = error
        }
        
        try loadError.map({ throw LoadError.didFailToLoadPersistentStores($0)})
        return container
    }
}
