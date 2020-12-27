import Foundation

import Foundation

extension EcoSystem{
    class EmployerEnvironment{
        
        public class ReportForOneDay: Report{

            private(set) var changes = [EcoSystem.EmployerEnvironment.Employe.Modification]()
            
            static func buildReport(id: Int, title: String, message: String, date: Date, employee: Employe) -> ReportForOneDay {
                return ReportForOneDay(id: id, title: title, message: message, date: date, slave: employee, type: day())
            }
            
            func sync() {
                if state is Open{
                    for change in slave.modification {
                        for change_ in changes{
                            if change.id == change_.id{
                                changes.append(change)
                            }
                        }
                    }
                }
                else{
                    return
                }
            }
        }
        
        class Report: Equatable {

            private(set) var id: Int

            private(set) var title: String

            private(set) var message: String

            private(set) var date: Date

            private(set) var slave: Employe

            private(set) public var state: State = Open()

            private(set) var reportType: ReportType

            init(id: Int, title: String, message: String, date: Date, slave: Employe, type: ReportType) {
                self.id = id
                self.title = title
                self.message = message
                self.date = date
                self.slave = slave
                self.reportType = type
            }

            func edit(field: Field) {
                if state is Open{
                    if field is Title{
                        let _field = field as! Title
                        message = _field.text
                    }
                    else{
                        let _field = field as! Message
                        message = _field.text
                    }
                }
                else{
                    return
                }
            }

            func close() {
                if state is Open{
                    
                    state = Closed()
                    slave.report = nil
                    slave.reports.append(self)

                    if reportType is day{
                        let self_ = self as! EcoSystem.EmployerEnvironment.ReportForOneDay
                        EcoSystem.`singleAccess`.projectEnv.project!.reportsForOneDay.append(self_)
                    }
                    else if reportType is phase{
                        let self_ = self as! EcoSystem.EmployerEnvironment.PhaseReport
                        EcoSystem.`singleAccess`.projectEnv.project!.reportsPhase.append(self_)
                    }
                }
                else{
                    return
                }
            }

            static func == (lhs: Report, rhs: Report) -> Bool {
                return lhs.id == rhs.id
            }

            class Field {}

            class Title: Field{
                var text: String
                
                init(text: String) {
                    self.text = text
                }
            }
            
            class Message: Field{
                var text: String
                
                init(text: String) {
                    self.text = text
                }
            }

            class State { }
            
            class Open: State { }
            
            class Closed: State { }
        }
        
        class PhaseReport: Report{
            
            private(set) var reports = [ReportForOneDay]()
            
            static func create(id: Int, title: String, message: String, date: Date, employee: Employe) -> PhaseReport {
                return PhaseReport(id: id, title: title, message: message, date: date, slave: employee, type: phase())
            }
            
            func sync(of type: ReportType) {
                if state is Open{
                    let reportForOneDay = EcoSystem.`singleAccess`.projectEnv.project!.reportsForOneDay
                    
                    if type is employe{
                        for report in reportForOneDay.filter({ $0.slave == slave }) {
                            for report_ in reports{
                                if report == report_{
                                    reports.append(report)
                                }
                            }
                        }

                    }
                    else if type is command{
                        for report in reportForOneDay {
                            for report_ in reports{
                                if report == report_ &&  report.slave.isSubordinate(of: self.slave){
                                    reports.append(report)
                                }
                            }
                        }
                    }
                }
                else{
                    return
                }
            }
            
            class ReportType { }
            
            class employe: ReportType { }
            
            class command: ReportType { }
        }

        private(set) var slaves = [Employe]()

        private(set) var chief: Employe? = nil
        
        public func createEmployee(name: String, head: Employe? = nil) -> Employe? {
            if slaves.count == 0{
                if head == nil {
                    slaves.append(Employe.slave(id: slaves.count, name: name))
                    chief = slaves.last
                }
                else{
                    return nil
                }
            }
            else{
                if let head = head{
                    slaves.append(Employe.slave(id: slaves.count, name: name, head: head))
                }
                else{
                    return nil
                }
            }
        
            return slaves.last
        }

        
        class ReportType { }
        
        class day: ReportType { }
        
        class phase: ReportType { }

        class Motion: Equatable{
            static func == (lhs: EcoSystem.EmployerEnvironment.Motion, rhs: EcoSystem.EmployerEnvironment.Motion) -> Bool {
                lhs.date == rhs.date
            }

            var date: Date
            var slave: Employe

            init(date: Date, slave: Employe) {
                self.date = date
                self.slave = slave
            }

            func returnDate() -> Date {
                return date
            }

            func returnEmploye() -> Employe {
                return slave
            }
        }

        class OpenMotion: Motion { }

        class ActivateMotion: Motion { }

        class ResolveMotion: Motion { }

        class AddMotion: Motion { }

        class MessageMotion: Motion { }

        class EmployeMotion: Motion { }
    }
}
