import Foundation

class RaceSimulator{
    var transportList: [Transport] = []
    
    var registrationStatus = true
    var raceName: String = ""
    
    func registrationOnAirRace (args: AirTransport...){
        if registrationStatus{
            for transport in args {
                transportList.append(transport)
            }
            raceName = "Air Race"
            print("\n")
            print("Registration on \(raceName) Started and closed")
            registrationStatus = false
        }
        else{
            print("\n Now there is a \(raceName). \n Registration closed \n")
        }
    }
    
    func registrationOnLandRace(args: LandTransport...){
        if registrationStatus{
            for transport in args {
                transportList.append(transport)
            }
            raceName = "Land Race"
            print("\n")
            print("Registration on \(raceName) Started and closed")
            registrationStatus = false
        }
        else{
            print("\n Now there is a \(raceName). \n Registration closed \n")
        }
    }
    
    func registrationOnMultiRace(args: Transport...){
        if registrationStatus{
            for transport in args {
                transportList.append(transport)
            }
            raceName = "Multi Race"
            print("\n")
            print("Registration on \(raceName) Started and closed")
            registrationStatus = false
        }
        else{
            print("\n Now there is a \(raceName). \n Registration closed \n")
        }
    }
    
    func startRaceAndFindWinner(distance: Double) -> Transport? {
        if transportList.count > 0{
            print("\(raceName) Started")
            var curentWinner: Transport = transportList[0]
            var currentWinnerTime: Double = Double.infinity
            
            for transport in transportList{
                if transport.getFinalTime(distance: distance) <= currentWinnerTime{
                    curentWinner = transport
                    currentWinnerTime = transport.getFinalTime(distance: distance)
                }
            }
        
        
        registrationStatus = true
        transportList.removeAll()
        
        print("In the \(raceName),🥳 \(curentWinner.name) 🥳 won with a time of ⏱ \(currentWinnerTime) ⏱ conventional units")
        print("\(raceName) Ended")
        print("\n")
        
        return curentWinner
        }
        else{
            print("🙀 No body take part in race 🙀")
            return nil
        }
    }
}
