//
//  ContentViewModel.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 17/12/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var content: [ContentModel] = []
    private var responseData: [ContentResult] = []
    private var networkManager: NetworkManagerProtocol?
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchAndSetContent() async {
        do {
            guard let results = try await networkManager?.fetchContent() else { return }
            self.responseData = results
            DispatchQueue.main.async {
                let newContent = self.getContentArray(results)
                self.content = self.mergeUniqueContent(currentContent: self.content, newContent: newContent)
                self.saveContent()
            }
        } catch {
            print("Failed to fetch and set content:", error)
        }
    }
    
    func saveContent() {
        do {
            let jsonData = try JSONEncoder().encode(self.content)
            CoreDataAPIResponseModel.save(data: jsonData, forKey: "HomeContent")
            print("Data saved successfully: \(jsonData)")
        } catch {
            print("Failed to encode content: \(error)")
        }
    }

    
    func getSavedContent() {
        guard let cachedData = CoreDataAPIResponseModel.getData(key: "HomeContent") else {
            print("No cached data found")
            return
        }
        do {
            let decoder = JSONDecoder()
            let savedContent = try decoder.decode([ContentModel].self, from: cachedData)
            DispatchQueue.main.async {
                self.content = savedContent
            }
        } catch {
            print("Failed to decode cached data into ContentModel: \(error)")
        }
    }
    
    func getContentArray(_ results: [ContentResult]) -> [ContentModel] {
        let contentArray = results.map { response in
            ContentModel(
                value: response.id?.value ?? "",
                fullName: "\(response.name?.first ?? "") \(response.name?.last ?? "")",
                address: """
                \(response.location?.street?.number ?? 0) \(response.location?.street?.name ?? ""), \
                \(response.location?.city ?? ""), \(response.location?.state ?? ""), \(response.location?.country ?? "")
                """,
                image: response.picture?.large ?? ""
            )
        }
        return contentArray
    }
    
    private func mergeUniqueContent(currentContent: [ContentModel], newContent: [ContentModel]) -> [ContentModel] {
        var existingIDs = Set(currentContent.map { $0.value })
        var mergedContent = currentContent
        for item in newContent {
            if !existingIDs.contains(item.value) {
                mergedContent.append(item)
                existingIDs.insert(item.value)
            }
        }
        
        return mergedContent
    }
}
