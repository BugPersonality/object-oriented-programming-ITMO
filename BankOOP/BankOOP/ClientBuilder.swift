import Foundation

protocol IClientBuilder{
    func build()throws -> Client
    func setName(name: String) -> IClientBuilder
    func setSecondName(secondName: String) -> IClientBuilder
    func setAdress(address: String) -> IClientBuilder
    func setIndex(index: Int) -> IClientBuilder
    func setPassportNumber(passportNumber: String) -> IClientBuilder
}

class ClientBuilder: IClientBuilder{
    private var clientInfo: [String:String] = [:]
    private var index: Int = -1
    
    func build()throws -> Client {
        if (clientInfo["name"] == nil) || (clientInfo["secondName"] == nil) || (index == -1){
            throw ClientBuilderExceptions.missingNameSecondNameOrIndex
        }else{
            let tempClient = Client(index: self.index, clientInfo: self.clientInfo)
            resetFields()
            return tempClient
        }
    }
    
    func setName(name: String) -> IClientBuilder {
        self.clientInfo["name"] = name
        return self
    }
    
    func setSecondName(secondName: String) -> IClientBuilder {
        self.clientInfo["secondName"] = secondName
        return self
    }
    
    func setAdress(address: String) -> IClientBuilder {
        if address != "nil" {
            self.clientInfo["address"] = address
        }
        return self
    }
    
    func setIndex(index: Int) -> IClientBuilder {
        self.index = index
        return self
    }
    
    func setPassportNumber(passportNumber: String) -> IClientBuilder{
        if passportNumber != "nil"{
            self.clientInfo["passportNumber"] = passportNumber
        }
        return self
    }
    
    private func resetFields(){
        self.clientInfo = [:]
        self.index = -1
    }
}

enum ClientBuilderExceptions: Error{
    case missingNameSecondNameOrIndex
}
