import Foundation
import Firebase

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    let placesReference = FIRDatabase.database().reference().child("places")
     
    
}
