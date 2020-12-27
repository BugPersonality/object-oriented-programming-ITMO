import Foundation

class DebitAccount: IAccount{
    var commission: Double = 0
    var percent: Double
    
    var upLimit: Double = Double.infinity
    var downLimit: Double = 0
    var untrastLimit: Double
    
    var balance: Double
    var time: Int
    
    var trustStatus: Bool
    
    init(percent: Double, untrastLimit: Double, trustStatus: Bool) {
        self.percent = percent
        
        self.time = 0
        self.balance = 0
        
        self.untrastLimit = untrastLimit
        
        self.trustStatus = trustStatus
    }
    
    func putMoney(money: Double) {
        self.balance += money
    }
    
    func withdrawMoney(money: Double)throws{
        if !self.trustStatus{
            if money > untrastLimit{
                throw errors.trustStatusError
            }
            else{
                if (money > self.balance){
                    throw errors.notEnoughMoney
                }
                else{
                    self.balance -= money
                }
            }
        }
        else{
            if (money > self.balance){
                throw errors.notEnoughMoney
            }
            else{
                self.balance -= money
            }
        }
    }
    
    func transferMoney(money: Double, accountToWhichToTransfer: inout IAccount)throws{
        if money > self.balance{
            throw errors.notEnoughMoney
        }
        if !self.trustStatus{
            if money > untrastLimit{
                throw errors.trustStatusError
            }
            else{
                self.balance -= money
                accountToWhichToTransfer.putMoney(money: money)
            }
        }
        else{
            self.balance -= money
            accountToWhichToTransfer.putMoney(money: money)
        }
    }
    
    func update() {
        if self.time == 3{
            self.balance += self.balance * (percent / 100)
            self.time = 0
        }
        else{
            self.time += 1
        }
    }
    
    enum errors: Error {
        case notEnoughMoney
        case trustStatusError
    }
}
