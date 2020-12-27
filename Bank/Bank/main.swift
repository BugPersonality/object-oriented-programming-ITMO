import Foundation

func getListOfClients() -> [[Substring]]{
    let task = Process()
    let pipe = Pipe()
    let command = "cat /Users/danildubov/Swift/BankOOP/BankOOP/spisok.txt"
    
    task.standardOutput = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/bash"
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    let outputSplitByEnter = output.split(separator: "\n")
    var outputSplitByEnterAndGaps: [[Substring]] = []

    for i in outputSplitByEnter{
        outputSplitByEnterAndGaps.append(i.split(separator: " "))
    }
    
    return outputSplitByEnterAndGaps
}

func createClients(clients: inout [Client])throws {
    let people = getListOfClients()

    for man in people{
        let builderForClient = ClientBuilder()
        
        let client = try builderForClient
            .setIndex(index: Int(man[0]) ?? -1)
            .setSecondName(secondName: String(man[1]))
            .setName(name: String(man[2]))
            .setPassportNumber(passportNumber: String(man[3]))
            .setAdress(address: String(man[4]))
            .build()

        clients.append(client)
    }
}

var clients: [Client] = []

do{
    try createClients(clients: &clients)
}
catch{
    print(error)
}

var client1 = clients[0]
var client2 = clients[1]
var client3 = clients[2]
var client4 = clients[3]
var client5 = clients[4]

var firstBank = FirstBank(precent: 20, commission: 1, name: "firstBank")
var secondBank = SecondBank(precent: 5, commission: 0.5, name: "SecondBank" )

firstBank.addClient(client: client1, typeAccount: .debitAccount)
firstBank.addClient(client: client2, typeAccount: .creditAccount)
firstBank.addClient(client: client3, typeAccount: .depositAccount)

secondBank.addClient(client: client4, typeAccount: .debitAccount)
secondBank.addClient(client: client5, typeAccount: .depositAccount)

try firstBank.putMoney(client: client1, money: 1000)
try firstBank.putMoney(client: client2, money: 2000)
try firstBank.putMoney(client: client3, money: 1000)

firstBank.printInfo()

try firstBank.withdrawMoney(client: client1, money: 100)
try firstBank.transferMoney(from: client1, to: client2, money: 200)
try firstBank.transferMoney(from: client1, to: client3, money: 100)

firstBank.printInfo()

try firstBank.withdrawMoney(client: client2, money: 300)
try firstBank.transferMoney(from: client2, to: client1, money: 300)
try firstBank.transferMoney(from: client2, to: client3, money: 300)

while true{
    firstBank.update()
    firstBank.printInfo()
    sleep(1)
}
