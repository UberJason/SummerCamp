import Combine
import SwiftData
import SwiftUI

import CoreData

@Observable
public class CampStore {
    public enum Storage {
        case appGroup(String), inMemory
    }

    public static let appGroupIdentifier = "group.com.jyjapps.summercamp"

    @MainActor
    public static let shared = CampStore(storage: .appGroup(appGroupIdentifier))
    
    #if DEBUG
    public static let inMemory = CampStore(storage: .inMemory)
    #endif
    
    private let container: ModelContainer
    @MainActor public var mainContext: ModelContext { container.mainContext }
    
    private let _operationSubject = PassthroughSubject<Void, Never>()
    public var changePublisher: AnyPublisher<Void, Never> { _operationSubject.eraseToAnyPublisher() }
    
    private init(storage: Storage) {
        let configuration: ModelConfiguration
            
        switch storage {
        case .appGroup(let identifier):
            configuration = ModelConfiguration(
                isStoredInMemoryOnly: false,
                allowsSave: true,
                groupContainer: .identifier(identifier)
            )
        case .inMemory:
            configuration = ModelConfiguration(
                isStoredInMemoryOnly: true,
                allowsSave: true
            )
        }

        do {
            #if DEBUG
//            try Self.__initializeCloudKitDebugSchema(configuration)
            #endif
            self.container = try ModelContainer(
                for: SDScheduleItem.self,
                configurations: configuration
            )
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        #if DEBUG
        if CommandLine.arguments.contains("-resetData") {
            deleteAllData()
        }
        #endif
    }
    
    #if DEBUG
    private static func __initializeCloudKitDebugSchema(_ config: ModelConfiguration) throws {
        // Use an autorelease pool to make sure Swift deallocates the persistent
        // container before setting up the SwiftData stack.
        try autoreleasepool {
            let desc = NSPersistentStoreDescription(url: config.url)
            let opts = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.JYJApps.SummerCamp")
            desc.cloudKitContainerOptions = opts
            // Load the store synchronously so it completes before initializing the
            // CloudKit schema.
            desc.shouldAddStoreAsynchronously = false
            if let mom = NSManagedObjectModel.makeManagedObjectModel(for: [SDScheduleItem.self]) {
                let ckContainer = NSPersistentCloudKitContainer(name: "SummerCamp", managedObjectModel: mom)
                ckContainer.persistentStoreDescriptions = [desc]
                ckContainer.loadPersistentStores {_, err in
                    if let err {
                        fatalError(err.localizedDescription)
                    }
                }
                // Initialize the CloudKit schema after the store finishes loading.
                try ckContainer.initializeCloudKitSchema()
                // Remove and unload the store from the persistent container.
                if let store = ckContainer.persistentStoreCoordinator.persistentStores.first {
                    try ckContainer.persistentStoreCoordinator.remove(store)
                }
            }
        }
    }
    #endif

    private func _allItems<T: PersistentModel>(_ type: T.Type, context: ModelContext) -> [T] {
        let fetchDescriptor = FetchDescriptor<T>()
        do {
            return try context.fetch(fetchDescriptor)
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    @available(iOS, deprecated: 18.0, message: "This method doesn't on iOS 17 because #Predicate can't work out .id from Identifiable. See if it works in iOS 18?")
    private func _item<T: PersistentModel & Identifiable>(id: String, _ type: T.Type, context: ModelContext) -> T? where T.ID == String {
        let fetchDescriptor = FetchDescriptor<T>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            return try context.fetch(fetchDescriptor).first
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

#if DEBUG
extension CampStore {
    func deleteAllData() {
        // container.deleteAllData() doesn't actually delete data: https://www.hackingwithswift.com/quick-start/swiftdata/how-to-completely-reset-a-swiftdata-modelcontainer
        
        Task {
            let context = ModelContext(container)
            try! context.delete(model: SDScheduleItem.self)
            try! context.save()
        }
    }
}
#endif
/*
 
 // Adding a thing:
 
 let tag = SDTag(name: "3", resolvedColor: Color.Resolved(red: 0, green: 1, blue: 0), entries: [])
 let tag2 = SDTag(name: "2", color: .green, environment: EnvironmentValues(), entries: [])
 container.mainContext.insert(tag)
 container.mainContext.insert(tag2)

 // Saving a thing:
 do {
     try container.mainContext.save()
 } catch let error {
     print(error.localizedDescription)
 }
 
 // Fetching a thing:
 
 let fetchDescriptor = FetchDescriptor<SDTag>(
     predicate: #Predicate { $0.name == "3" }
 )
 
 do {
     let results = try container.mainContext.fetch(fetchDescriptor)
     print(results)
 } catch let error {
     print(error.localizedDescription)
 }
 
 // Deleting a thing:
 
 let tag = // an SDTag
 container.mainContext.delete(tag)
 
 
 
 */
