//
//  APIResponseDataModel.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 18/12/24.
//

import Foundation
import CoreData
import UIKit

@objc(CoreDataAPIResponseModel)
public class CoreDataAPIResponseModel: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataAPIResponseModel> {
        return NSFetchRequest<CoreDataAPIResponseModel>(entityName: "CoreDataAPIResponseModel")
    }

    @NSManaged public var key: String?
    @NSManaged public var responseData: Data?
    
    static func save(data: Data, forKey key: String) {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<CoreDataAPIResponseModel> = CoreDataAPIResponseModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", key)
        if let responseModelArray = try? managedContext.fetch(fetchRequest), let  responseModel = responseModelArray.last {
            responseModel.responseData = data
            PersistenceController.shared.saveContext()
            return
        }
        let responseModel = CoreDataAPIResponseModel(context: managedContext)
        responseModel.key = key
        responseModel.responseData = data
        PersistenceController.shared.saveContext()
    }

    static func getData(key: String) -> Data? {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<CoreDataAPIResponseModel> = CoreDataAPIResponseModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", key)
        do {
            let responseModelArray = try managedContext.fetch(fetchRequest)
            if let responseModel = responseModelArray.last {
                return responseModel.responseData
            }
            return responseModelArray.last?.responseData
        } catch {
            print("Failed to fetch data for key '\(key)': \(error.localizedDescription)")
            return nil
        }
    }
    
    static func deleteData(key: String) {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<CoreDataAPIResponseModel> = CoreDataAPIResponseModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", key)
        if let responseModelArray = try? managedContext.fetch(fetchRequest), let  responseModel = responseModelArray.last {
            managedContext.delete(responseModel)
            PersistenceController.shared.saveContext()
        }
    }
    
    static func deleteAll() {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<CoreDataAPIResponseModel> = CoreDataAPIResponseModel.fetchRequest()
        do {
            let deleteResultRequests = try managedContext.fetch(fetchRequest)
            for deleteResultRequest in deleteResultRequests {
                managedContext.delete(deleteResultRequest)
            }
            PersistenceController.shared.saveContext()
        } catch {}
    }
}
