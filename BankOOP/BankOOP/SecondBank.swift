import Foundation

class SecondBank: IBank{
    private(set) var bankName: String
    
    private(set) var precent: Double
    private(set) var commission: Double
    
    private(set) var accountTerm: Int = 15
    private(set) var untrastLimit: Double = 900
    private(set) var upLimit: Double = 9000
    private(set) var downLimit: Double = -1000
    
    var cliets: [Client : clientsValues] = [:]
    
    init(precent: Double, commission: Double, name: String) {
        self.precent = precent
        self.commission = commission
        self.bankName = name
    }
}
