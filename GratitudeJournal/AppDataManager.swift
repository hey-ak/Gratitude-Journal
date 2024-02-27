import Foundation
import UIKit

// Define your struct without UIImage
struct ItemData: Codable {
    let id: Int
    let title: String
    let date: Date
    let imageURL: String
    
    // Conversion method from Item to ItemData
    static func fromItem(_ item: Item) -> ItemData {
        return ItemData(id: item.id, title: item.title, date: item.date, imageURL: item.imageURL)
    }
}

struct ScoreDataModel:Codable {
    let totleScore: Double
}

// Define a class to handle UserDefaults operations for ItemData
class ItemDataManager {
    // UserDefaults key
    private let key = "items"
    private let scoreKey = "scoreKey"
    // Singleton instance
    static let shared = ItemDataManager() 
    
    // Private initializer for singleton
    private init() {}
    
    public func fetchScoreData() -> ScoreDataModel {
        if let scoreData = UserDefaults.standard.data(forKey: scoreKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(ScoreDataModel.self, from: scoreData) {
                return decoded
            }
        }
        return ScoreDataModel.init(totleScore: 0.0)
    }
    
    
    public func storeScoreData(_ data:ScoreDataModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: scoreKey)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Method to store items in UserDefaults
    func storeItems(items: [ItemData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    // Method to fetch items from UserDefaults
    func fetchItems() -> [Item] {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ItemData].self, from: data) {
                return decoded.map { itemData in
                    var item = Item(id: itemData.id, title: itemData.title, date: itemData.date, imageURL: itemData.imageURL, image: nil)
                    item.loadImageFromDocumentsDirectory()
                    return item
                }
            }
        }
        return []
    }
    
    private func fetchOriginalData() -> [ItemData] {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ItemData].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    // Method to add a new item
    func addItem(_ newItem: Item) {
        var newItem = newItem
        newItem.saveImageToDocumentsDirectory() // Save image to documents directory
        guard let imageURL = newItem.imageURLInDocumentsDirectory() else { return }
        newItem.imageURL = imageURL.absoluteString
        var items = fetchOriginalData()
        let newItemData = ItemData.fromItem(newItem)
        items.append(newItemData)
        
        storeItems(items: items)
    }
    
    func generateUniqueID() -> Int {
        let timestamp = Int(Date().timeIntervalSince1970 * 1000) // Convert to milliseconds
        let randomNumber = Int.random(in: 0..<1000)
        let uniqueIDString = "\(timestamp)\(randomNumber)"
        return Int(uniqueIDString) ?? 0 // Convert the string to an integer, defaulting to 0 if conversion fails
    }
}

// Define your struct with UIImage
struct Item:Identifiable {
    let id: Int
    let title: String
    let date: Date
    var imageURL: String
    var image: UIImage? // UIImage property for the image
    
    // Method to get the URL of the image in the documents directory
    func imageURLInDocumentsDirectory() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent("image_\(id).jpg")
    }
    
    // Method to save the image to the documents directory
    func saveImageToDocumentsDirectory() {
        guard let imageURL = imageURLInDocumentsDirectory(),
              let image = image,
              let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        do {
            try imageData.write(to: imageURL)
        } catch {
            print("Error saving image to documents directory: \(error)")
        }
    }
    
    // Method to load the image from the documents directory
    mutating func loadImageFromDocumentsDirectory() {
        guard let imageURL = imageURLInDocumentsDirectory(),
              let imageData = try? Data(contentsOf: imageURL),
              let loadedImage = UIImage(data: imageData) else {
            return
        }
        image = loadedImage
    }
}




















