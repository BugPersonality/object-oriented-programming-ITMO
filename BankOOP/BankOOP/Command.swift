import Foundation

class ICommand{
    var fromAccount: Client
    var money: Double
    var toAccount: Client?
    
    init(from account: inout Client, money: Double) {
        self.fromAccount = account
        self.money = money
    }
    
    init(from client1: inout Client, to client2: inout Client, money: Double) {
        self.toAccount = client2
        self.fromAccount = client1
        self.money = money
    }
    
    func execute()throws {
        throw errors.overrideTheFunction
    }
    
    func undo()throws {
        throw errors.overrideTheFunction
    }
    
    enum errors: Error {
        case overrideTheFunction
    }
}

class PutMoneyCommand: ICommand {
    override func execute() {
        self.fromAccount.account!.putMoney(money: self.money)
    }
    override func undo() {
        self.fromAccount.account!.balance -= self.money
    }
}

class WithdrawMoneyCommand: ICommand {
    override func execute()throws {
        try self.fromAccount.account!.withdrawMoney(money: money)
    }
    override func undo() {
        self.fromAccount.account!.balance += self.money
    }
}

class TransferMoneyCommand: ICommand{    
    override func execute()throws {
        if toAccount != fromAccount{
            try self.fromAccount.account!.transferMoney(money: self.money,
                                                        accountToWhichToTransfer: &(self.toAccount!.account!))
        }
    }
    override func undo() {
        self.fromAccount.account!.balance += self.money
        self.toAccount!.account!.balance -= self.money
    }
}
