import Foundation

protocol IBank {
    var bankName: String { get }
    
    var precent: Double { get }
    var commission: Double { get }
    
    var accountTerm: Int { get }
    
    var untrastLimit: Double { get }
    var upLimit: Double { get }
    var downLimit: Double { get }

    var cliets: [Client:clientsValues] { get set }
    
    mutating func addClient(client: Client, typeAccount: TypebankAccounts)
    mutating func putMoney(client: Client, money: Double) throws
    mutating func withdrawMoney(client: Client, money: Double) throws
    mutating func transferMoney(from client1: Client, to Client2: Client, money: Double) throws
    mutating func undo(client: Client) throws
    mutating func update()
    mutating func printInfo()
}

extension IBank{
    mutating func addClient(client: Client, typeAccount: TypebankAccounts){
        cliets[client] = clientsValues(commands: [], client: client)
        
        switch typeAccount {
        case .creditAccount:
            self.cliets[client]?.clientInfo.addAccount(account: CreditAccount(percent: self.precent,
                                                                upLimit: self.upLimit,
                                                                downLimit: self.downLimit,
                                                                untrastLimit: self.untrastLimit,
                                                                commission: self.commission,
                                                                trustStatus: client.trustStatus))
        case .debitAccount:
            self.cliets[client]?.clientInfo.addAccount(account: DebitAccount(percent: self.precent,
                                                               untrastLimit: self.untrastLimit,
                                                               trustStatus: client.trustStatus))
        case .depositAccount:
            self.cliets[client]?.clientInfo.addAccount(account: DepositAccount(percent: self.precent,
                                                                               upLimit: self.upLimit,
                                                                               accountTerm: self.accountTerm,
                                                                               untrastLimit: self.untrastLimit,
                                                                               trustStatus: client.trustStatus))
        }
    }
    
    mutating func putMoney(client: Client, money: Double)throws{
        if cliets[client] != nil {
            let command = PutMoneyCommand(from: &cliets[client]!.clientInfo, money: money)
            command.execute()
            cliets[client]!.commands.append(command)
        }
        else{
            throw bankErrors.theСlientIsNotRegisteredWithTheBank
        }
    }
    
    mutating func withdrawMoney(client: Client, money: Double) throws{
        if cliets[client] != nil{
            let command = WithdrawMoneyCommand(from:  &cliets[client]!.clientInfo, money: money)
            try command.execute()
            cliets[client]!.commands.append(command)
        }
        else{
            throw bankErrors.theСlientIsNotRegisteredWithTheBank
        }
    }
    
    mutating func transferMoney(from client1: Client, to client2: Client, money: Double) throws{
        if cliets[client1] != nil && cliets[client2] != nil{
            let command = TransferMoneyCommand(from:  &cliets[client1]!.clientInfo,
                                               to:  &cliets[client2]!.clientInfo,
                                               money: money)
            try command.execute()
            cliets[client1]!.commands.append(command)
        }
        else{
            throw bankErrors.theСlientIsNotRegisteredWithTheBank
        }
    }
    
    mutating func undo(client: Client) throws{
        if cliets[client] != nil {
            if (cliets[client]?.commands.count)! > 0{
                try cliets[client]?.commands.last?.undo()
            }
            else{
                throw bankErrors.clientDoesntExistAnyCommands
            }
        }
        else{
            throw bankErrors.theСlientIsNotRegisteredWithTheBank
        }
    }
    
    mutating func update(){
        for (_, value) in self.cliets{
            value.clientInfo.account?.update()
        }
    }
    
    mutating func printInfo(){
        print("Info about bank - \(self.bankName)")
        
        for (_, value) in self.cliets{
            let name = String(value.clientInfo.clientInfo["name"]!)
            let secoundName = String(value.clientInfo.clientInfo["secondName"]!)
            let adress = String(value.clientInfo.clientInfo["address"] ?? "NONE")
            let passport = String(value.clientInfo.clientInfo["passportNumber"] ?? "NONE")
            let balance = value.clientInfo.account!.balance
                
            print("Client name: \(name),  Client Secound Name: \(secoundName)")
            print("Client adress: \(adress), Client Passport: \(passport)")
            print("\t balance on account: \(String(describing: balance)) руб.")
        }
        print("---------------------------------------------------------\n")
    }
    
}
enum bankErrors: Error{
    case theСlientIsNotRegisteredWithTheBank
    case clientDoesntExistAnyCommands
}

enum TypebankAccounts{
    case debitAccount
    case depositAccount
    case creditAccount
}

class clientsValues {
    var commands: [ICommand]
    var clientInfo: Client
    
    init(commands: [ICommand], client: Client) {
        self.clientInfo = client
        self.commands = commands
    }
}
