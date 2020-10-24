import Foundation

class FastCamel: LandTransport{
    var timeToRest: Double
    
    var name: String
    
    var speed: Double
    
    var countOfRest: Int
    
    init() {
        self.timeToRest = 10.0
        self.speed = 40.0
        self.name = "Fast Camel"
        self.countOfRest = 0
    }
    
    func restTime() -> Double {
        if countOfRest == 0{
            countOfRest += 1
            return 5.0
        }
        else if countOfRest == 1{
            countOfRest += 1
            return 6.5
        }
        else{
            return 8.0
        }
    }
    
    func resetCounter() {
        self.countOfRest = 0
    }
}
