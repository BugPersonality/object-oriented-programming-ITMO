import Foundation

class Bucket: AirTransport{
    var name: String
    
    var speed: Double
    
    init() {
        self.speed = 8.0
        self.name = "Bucket"
    }
    
    func distanceReducer(distance: Double) -> Double {
        return distance * 0.94
    }
}
