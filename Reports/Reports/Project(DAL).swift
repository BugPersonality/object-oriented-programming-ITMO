import Foundation

extension EcoSystem.ProjectEnvironment {
    public final class Project {
        var name: String
        var stages = [Phase]()
        var stage: Phase?
        var reportsForOneDay = [EcoSystem.EmployerEnvironment.ReportForOneDay]()
        var reportsPhase = [EcoSystem.EmployerEnvironment.PhaseReport]()
        var numberOfReports: Int = 0
        
        private init(name: String) {
            self.name = name
        }
        
        static func project(name: String) -> Project {
            return Project(name: name)
        }
        
        func add(stages: [PhaseSubmission]) -> Project? {
            if self.stages.isEmpty{
                for stage in stages {
                    let newStage = Phase.stage(id: self.stages.count, message: stage.message)
                    newStage.add(tasks: stage.tasks)
                    
                    self.stages.append(newStage)
                }
                stage = self.stages[0]
                return self
            }
            else{
                return nil
            }
        }
        
        private func searchTaskBySubordinate(employee: EcoSystem.EmployerEnvironment.Employe) -> [EcoSystem.ProjectEnvironment.Project.Phase.Task] {
            var returned = [EcoSystem.ProjectEnvironment.Project.Phase.Task]()
            
            for subordinate in employee.slaves {
                returned.append(contentsOf: subordinate.deputedTasks)
            }
            
            return returned
        }
        
        class PhaseSubmission{
            var message: String
            var tasks: [EcoSystem.ProjectEnvironment.Project.Phase.TaskSubmission]
            
            init(message: String, tasks: [EcoSystem.ProjectEnvironment.Project.Phase.TaskSubmission]) {
                self.message = message
                self.tasks = tasks
            }
        }
        
        class Phase {
            public let id: Int
            
            var tasks = [EcoSystem.ProjectEnvironment.Project.Phase.Task]()
            
            var message: String
            
            private init(id: Int, message: String) {
                self.id = id
                self.message = message
            }
            
            static func stage(id: Int, message: String) -> Phase {
                return Phase(id: id, message: message)
            }

            func add(tasks: [TaskSubmission]) {
                for task in tasks {
                    self.tasks.append(Task.task(id: self.tasks.count, message: message, employe: task.struct_, stage: self))
                    task.struct_.depute(task: self.tasks.last!)
                }
            }
            
            class TaskSubmission{
                var message: String
                var struct_: EcoSystem.EmployerEnvironment.Employe
                
                init(message: String, struct_: EcoSystem.EmployerEnvironment.Employe) {
                    self.message = message
                    self.struct_ = struct_
                }
            }
            
            class Task: Equatable{
                
                let id: Int
                
                var state: StateOfTask = OpenTask()

                let stage: EcoSystem.ProjectEnvironment.Project.Phase

                var employe: EcoSystem.EmployerEnvironment.Employe

                var message: String
                
                var changes = [EcoSystem.EmployerEnvironment.Motion]()
                
                let creation: Date
                
                init(id: Int, message: String, employe: EcoSystem.EmployerEnvironment.Employe, stage: EcoSystem.ProjectEnvironment.Project.Phase, creation: Date) {
                    self.id = id
                    self.message = message
                    self.employe = employe
                    self.stage = stage
                    self.creation = creation
                }
                
                static func task(id: Int, message: String, employe: EcoSystem.EmployerEnvironment.Employe, stage: EcoSystem.ProjectEnvironment.Project.Phase) -> Task {
                    let task = Task(id: id, message: message, employe: employe, stage: stage, creation: EcoSystem.`singleAccess`.date)
                    employe.depute(task: task)
                    return task
                }
                
                func set(employe: EcoSystem.EmployerEnvironment.Employe) {
                    changes.append(EcoSystem.EmployerEnvironment.ActivateMotion(date: EcoSystem.`singleAccess`.date, slave: self.employe))
                    self.employe = employe
                }
                
                func set(state: StateOfTask) {
                    if state is OpenTask{
                        changes.append(EcoSystem.EmployerEnvironment.OpenMotion(date: EcoSystem.`singleAccess`.date, slave: self.employe))
                    }
                    else if state is ActiveTask{
                        changes.append(EcoSystem.EmployerEnvironment.ActivateMotion(date: EcoSystem.`singleAccess`.date, slave: self.employe))
                    }
                    else if state is ResolvedTask{
                        changes.append(EcoSystem.EmployerEnvironment.ResolveMotion(date: EcoSystem.`singleAccess`.date, slave: self.employe))
                    }
                    
                    self.state = state
                }
                
                func edit(cell: Cell) {
                    if !(state is ResolvedTask){
                        message = cell.text
                        employe.modification.append(EcoSystem.EmployerEnvironment.Employe.Modification(id: employe.modification.count, task: self, motion: EcoSystem.EmployerEnvironment.MessageMotion(date: EcoSystem.`singleAccess`.date, slave: self.employe)))
                        changes.append(EcoSystem.EmployerEnvironment.MessageMotion(date: EcoSystem.`singleAccess`.date, slave: self.employe))
                    }
                    else{
                        return
                    }
                }
                
                static func == (lhs: Task, rhs: Task) -> Bool {
                    return lhs.stage.id == rhs.stage.id && lhs.id == rhs.id
                }
                
                public class StateOfTask { }

                public class OpenTask: StateOfTask { }

                public class ActiveTask: StateOfTask { }

                public class ResolvedTask: StateOfTask { }
                
                struct Cell {
                    var text: String
                }
            }
        }
    }
}
