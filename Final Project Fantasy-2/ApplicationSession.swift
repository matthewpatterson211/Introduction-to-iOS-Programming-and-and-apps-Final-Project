import Foundation

// Application Session singleton
class ApplicationSession {
    static let sharedInstance = ApplicationSession()
    
    var persistence: HeroPersistenceInterface?
    
    private init() {
        if let appStorageUrl = FileManager.default.createDirectoryInUserLibrary(atPath: "HeroApp"),
            let persistence = HeroPersistence(atUrl: appStorageUrl, withDirectoryName: "hero") {
            self.persistence = persistence
        }
    }
}
