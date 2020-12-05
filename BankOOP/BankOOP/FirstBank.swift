import Foundation

import Foundation

class FirstBank: IBank{
    private(set) var bankName: String
    
    private(set) var precent: Double
    private(set) var commission: Double
    
    private(set) var accountTerm: Int = 9
    private(set) var untrastLimit: Double = 1000
    private(set) var upLimit: Double = 10000
    private(set) var downLimit: Double = -900
    
    var cliets: [Client : clientsValues] = [:]
    
    init(precent: Double, commission: Double, name: String) {
        self.precent = precent
        self.commission = commission
        self.bankName = name
    }
}
