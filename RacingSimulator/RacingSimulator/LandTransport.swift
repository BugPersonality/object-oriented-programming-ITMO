import Foundation

protocol LandTransport: Transport {
    var countOfRest: Int { get set }
    var timeToRest: Double { get }
    func restTime() -> Double
    func resetCounter()
}

extension LandTransport{
    func getFinalTime(distance: Double) -> Double {
        var curentTime = distance / self.speed
        
        let restcount = Int(floor(curentTime / timeToRest))
        
        for _ in 0..<restcount{
            curentTime += self.restTime()
        }
        
        resetCounter()
        return curentTime
    }
}
