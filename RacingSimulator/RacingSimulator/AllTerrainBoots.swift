import Foundation

class AllTerrainBoots: LandTransport{
    var timeToRest: Double
    
    var name: String
    
    var speed: Double
    
    var countOfRest: Int
    
    init() {
        self.countOfRest = 0
        self.name = "AllTerrainBoots"
        self.speed = 6.0
        self.timeToRest = 60.0
    }
    
    func restTime() -> Double {
        if countOfRest == 0{
            countOfRest += 1
            return 10.0
        }
        else{
            return 5.0
        }
    }
    
    func resetCounter() {
        self.countOfRest = 0
    }
}
