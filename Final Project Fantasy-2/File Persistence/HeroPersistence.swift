import Foundation

protocol HeroPersistenceInterface {
    var savedHero: [Hero] { get }
    func save(hero: Hero)
    func delete(removename: String)
}

final class HeroPersistence: FileStoragePersistence, HeroPersistenceInterface {
    
    
    
    func delete(removename: String) {
        removeFile(withName: removename)
    }
    let directoryUrl: URL
    let fileType: String = "json"
    
    init?(atUrl baseUrl: URL, withDirectoryName name: String) {
        guard let directoryUrl = FileManager.default.createDirectory(atUrl: baseUrl, appendingPath: name) else { return nil }
        self.directoryUrl = directoryUrl
    }
    
    var savedHero: [Hero] {
        return names.compactMap {
            guard let workoutData = read(fileWithId: $0) else { return nil }
            
            return try? JSONDecoder().decode(Hero.self, from: workoutData)
        }
    }
    
    func save(hero: Hero) {
        let test = (savedHero.firstIndex (where: ({ $0.id == hero.id}))) ?? nil
        if (test == nil)
        {
            save(object: hero, withId: hero.id.uuidString)
            
            
        }
        
    }
    
    
}

