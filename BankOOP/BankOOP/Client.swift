import Foundation

class Client: Hashable{
    var account: IAccount?
    
    var clientInfo: [String:String]
    var index: Int
    
    var trustStatus: Bool
    
    init(index: Int, clientInfo: [String:String]) {
        self.index = index
        self.clientInfo = clientInfo
        
        if (clientInfo["address"] == nil) || (clientInfo["passportNumber"] == nil){
            self.trustStatus = false
        }
        else{
            self.trustStatus = true
        }
    }
    
    static func == (lhs: Client, rhs: Client) -> Bool {
        lhs.index == rhs.index
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
    
    func addAccount(account: IAccount){
        self.account = account
    }
    
    func getId() -> Int{
        return self.index
    }
}


