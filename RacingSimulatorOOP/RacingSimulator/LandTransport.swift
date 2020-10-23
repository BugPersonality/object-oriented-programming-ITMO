import Foundation

protocol LandTransport: Transport {
    var countOfRest: Int { get set }
    var timeToRest: Double { get }
    func restTime() -> Double
}

extension LandTransport{
    func getFinalTime(distance: Double) -> Double {
        
        var curentTime = 0.0
        var curentDistantion = 0.0
        
        while curentDistantion < distance{
            
            curentTime += timeToRest + restTime()
            curentDistantion += speed * timeToRest
        }
        
        if curentDistantion > distance{
            let extraDistance = curentDistantion - distance
            let extraTime = extraDistance / speed
            
            curentTime -= extraTime
        }
        
        return curentTime
    }
}
