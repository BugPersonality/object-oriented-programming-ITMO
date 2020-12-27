import Foundation

class BactrianCamel: LandTransport{
    var countOfRest: Int
    var name: String
    var speed: Double
    var timeToRest: Double
    
    init() {
        self.name = "Bactrian Camel"
        self.speed = 10.0
        self.timeToRest = 30.0
        self.countOfRest = 0
    }
    
    func restTime() -> Double {
        if self.countOfRest == 0{
            self.countOfRest += 1
            return 5.0
        }
        else{
            return 8.0
        }
    }
    
    func resetCounter() {
        self.countOfRest = 0
    }
}
