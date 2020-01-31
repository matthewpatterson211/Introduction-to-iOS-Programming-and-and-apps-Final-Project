import Foundation

protocol WorkoutPersistenceInterface {
    var savedWorkouts: [Workout] { get }
    func save(workout: Workout)
    func delete(removename: String)
}

final class WorkoutPersistence: FileStoragePersistence, WorkoutPersistenceInterface {

    func delete(removename: String) {
        removeFile(withName: removename)
    }
    let directoryUrl: URL
    let fileType: String = "json"
    
    init?(atUrl baseUrl: URL, withDirectoryName name: String) {
        guard let directoryUrl = FileManager.default.createDirectory(atUrl: baseUrl, appendingPath: name) else { return nil }
        self.directoryUrl = directoryUrl
    }
    
    var savedWorkouts: [Workout] {
        return names.compactMap {
            guard let workoutData = read(fileWithId: $0) else { return nil }
            
            return try? JSONDecoder().decode(Workout.self, from: workoutData)
        }
    }
    
    func save(workout: Workout) {
        let test = (savedWorkouts.firstIndex (where: ({ $0.id == workout.id}))) ?? nil
        if (test == nil)
        {
        save(object: workout, withId: workout.id.uuidString)
            
        
        }

    }
    
 
    }

