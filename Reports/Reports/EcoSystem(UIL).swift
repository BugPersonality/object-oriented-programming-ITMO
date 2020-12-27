import Foundation

class EcoSystem{
    static let `singleAccess` = EcoSystem()
    let employeEnv = EmployerEnvironment()
    let projectEnv = ProjectEnvironment()

    var date = Date()
    
    public func passOneDay() {
        for slave in employeEnv.slaves {
            slave.report!.close()
        }
        date.addTimeInterval(86400)
    }
}
