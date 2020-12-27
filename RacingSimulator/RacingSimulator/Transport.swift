import Foundation

protocol Transport {
    var name: String { get }
    
    var speed: Double { get }
    
    func getFinalTime(distance: Double) -> Double
}
