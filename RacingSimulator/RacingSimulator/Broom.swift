import Foundation

class Broom: AirTransport{
    var name: String
    
    var speed: Double
    
    init() {
        self.name = "Broom"
        self.speed = 20
    }
    
    func distanceReducer(distance: Double) -> Double {
        let procent = 1 - (floor(distance.truncatingRemainder(dividingBy: 1000.0)))
        return distance * procent
    }
}
