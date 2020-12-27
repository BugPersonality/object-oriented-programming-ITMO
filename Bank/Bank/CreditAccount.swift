import Foundation

class CreditAccount: IAccount{
    var commission: Double
    var percent: Double
    
    var upLimit: Double
    var downLimit: Double
    var untrastLimit: Double
    
    var balance: Double
    var time: Int
    var trustStatus: Bool
    
    var buffer: Double = 0
    
    init(percent: Double, upLimit: Double, downLimit: Double, untrastLimit: Double, commission: Double, trustStatus: Bool) {
        self.percent = percent
        self.commission = commission
        
        self.upLimit = upLimit
        self.downLimit = downLimit
        self.untrastLimit = untrastLimit
        
        self.time = 0
        self.balance = 0
        
        self.trustStatus = trustStatus
    }
    
    func putMoney(money: Double) {
        if (self.balance < 0)
        {
            var currentMoney = money
            currentMoney -= money * (self.percent / 100)
            self.balance += currentMoney
        }
        else{
            self.balance += money
        }
    }
    
    func withdrawMoney(money: Double) throws {
        var currentMoney = money
        if (self.balance < 0){
            currentMoney += money * (self.percent / 100)
            self.balance -= currentMoney
        }
        if (self.balance - currentMoney < downLimit){
            throw errors.attempToWithdrawMoreThanTheDownLimit
        }
        else{
            if !self.trustStatus{
                if currentMoney > untrastLimit{
                    throw errors.trustStatusError
                }
                else{
                    self.balance -= currentMoney
                }
            }
            else{
                self.balance -= currentMoney
            }
        }
    }
    
    func transferMoney(money: Double, accountToWhichToTransfer: inout IAccount) throws {
        var currentMoney = money
        if (self.balance < 0){
            currentMoney += money * (self.percent / 100)
            self.balance -= currentMoney
        }
        if (self.balance - currentMoney < downLimit){
            throw errors.attempToWithdrawMoreThanTheDownLimit
        }
        else{
            if !self.trustStatus{
                if currentMoney > untrastLimit{
                    throw errors.trustStatusError
                }
                else{
                    self.balance -= currentMoney
                    accountToWhichToTransfer.putMoney(money: currentMoney)
                }
            }
            else{
                self.balance -= currentMoney
                accountToWhichToTransfer.putMoney(money: currentMoney)
            }
        }
    }
    
    func update() {
        if self.time != 3{
            buffer += self.balance * (self.percent / 365)
            self.time += 1
        }
        else{
            self.balance += self.buffer
            self.time = 0
            self.buffer = 0
        }
    }
    
    enum errors: Error {
        case attempToWithdrawMoreThanTheDownLimit
        case notEnoughMoney
        case trustStatusError
    }
}
