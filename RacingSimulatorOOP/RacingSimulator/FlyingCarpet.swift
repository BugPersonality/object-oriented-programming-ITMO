import Foundation

class FlyingCarpet: AirTransport{    
    var name: String
    
    var speed: Double
    
    init() {
        self.name = "Flying Carpet"
        self.speed = 10
    }
    func distanceReducer(distance: Double) -> Double {
        if distance < 1000{
            return distance
        }
        else if distance < 5000{
            return distance * 0.97
        }
        else if distance < 10000{
            return distance * 0.9
        }
        else{
            return distance * 0.95
        }
    }
}
