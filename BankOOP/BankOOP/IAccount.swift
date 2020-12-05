import Foundation

protocol IAccount{
    var time: Int { get set }
    var trustStatus: Bool { get set }
    var percent: Double { get set }
    var balance: Double { get set }
    
    var commission: Double { get set }
    var upLimit: Double { get set }
    var downLimit: Double { get set }
    var untrastLimit: Double { get set }
    
    func putMoney(money: Double)
    func withdrawMoney(money: Double)throws
    func transferMoney(money: Double, accountToWhichToTransfer: inout IAccount)throws
    func update()
}


