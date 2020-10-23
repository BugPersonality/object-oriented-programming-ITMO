import Foundation

protocol AirTransport: Transport{
    func distanceReducer (distance: Double) -> Double
}

extension AirTransport{
    func getFinalTime(distance: Double) -> Double {
        return (distanceReducer(distance: distance)) / speed
    }
}
