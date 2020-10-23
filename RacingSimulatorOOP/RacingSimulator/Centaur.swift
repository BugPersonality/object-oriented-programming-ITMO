import Foundation

class Centaur: LandTransport{
    var timeToRest: Double
    
    var name: String
    
    var speed: Double
    
    var countOfRest: Int
    
    init() {
        self.countOfRest = 0
        self.name = "Centaur"
        self.speed = 15.0
        self.timeToRest = 8.0
    }
    
    func restTime() -> Double {
        return 2.0
    }
}
