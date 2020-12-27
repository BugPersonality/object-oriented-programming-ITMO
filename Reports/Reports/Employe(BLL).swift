import Foundation

extension EcoSystem.EmployerEnvironment{
    class Employe: Equatable{
        let id: Int
        let name: String
        var chief: Employe?
        var distance: Int
        var slaves = [Employe]()
        var deputedTasks = [EcoSystem.ProjectEnvironment.Project.Phase.Task]()
        var modification = [Modification]()
        var report: Report?
        var reportsOfSlaves : PhaseReport?
        var reports = [Report]()

        init(id: Int, name: String, head: Employe?, distance: Int) {
            self.id = id
            self.name = name
            self.chief = head
            self.distance = distance
        }
        
        static func slave(id: Int, name: String, head: Employe? = nil) -> Employe {
            var distance = 0
            
            if let h = head {
                distance = h.distance + 1
            }
            
            let employee = Employe(id: id, name: name, head: head, distance: distance)
            
            if let head = head {
                head.addSuborninate(suborninate: employee)
            }
            
            return employee
        }

        private func addSuborninate(suborninate: Employe) {
            slaves.append(suborninate)
        }

        func depute(task: EcoSystem.ProjectEnvironment.Project.Phase.Task) {
            for task_ in deputedTasks{
                if task_ == task{
                    return
                }
            }

            deputedTasks.append(task)

            if task.employe != self {
                task.employe.remove(task: task)
            }
            
            modification.append(Modification(id: modification.count, task: task,
                                             motion: EcoSystem.EmployerEnvironment.EmployeMotion(date: EcoSystem.`singleAccess`.date, slave: task.employe)))
            task.set(employe: self)
        }

        func add(to stage: EcoSystem.ProjectEnvironment.Project.Phase, tasks: [EcoSystem.ProjectEnvironment.Project.Phase.TaskSubmission]) {
            stage.add(tasks: tasks)
            
            for task in stage.tasks[stage.tasks.count - tasks.count ..< stage.tasks.count] {
                modification.append(Modification(id: modification.count, task: task,
                                                 motion: EcoSystem.EmployerEnvironment.AddMotion(date: EcoSystem.`singleAccess`.date, slave: self)))
            }
        }

        func remove(task: EcoSystem.ProjectEnvironment.Project.Phase.Task) {
            var index = -10
            
            for i in deputedTasks.indices{
                if deputedTasks[i] == task{
                    index = i
                }
            }
            
            if index != -10{
                deputedTasks.remove(at: index)
            }
            else{
                return
            }
        }

        func reopen(task: EcoSystem.ProjectEnvironment.Project.Phase.Task) {
            if !(task.state is EcoSystem.ProjectEnvironment.Project.Phase.Task.ResolvedTask) {
                return
            }
            task.set(state: EcoSystem.ProjectEnvironment.Project.Phase.Task.OpenTask())
            modification.append(Modification(id: modification.count, task: task,
                                             motion: EcoSystem.EmployerEnvironment.OpenMotion(date: EcoSystem.`singleAccess`.date, slave: self)))
        }

        func activateTask(at id: Int?) {
            if deputedTasks.contains(where: { $0.state is EcoSystem.ProjectEnvironment.Project.Phase.Task.ActiveTask }) {
                return
            }

            var task: EcoSystem.ProjectEnvironment.Project.Phase.Task
            
            if let _ = id {
                var index = -10
                for i in deputedTasks.indices{
                    if deputedTasks[i].id == id{
                        index = i
                    }
                }
                if index != -10 {
                    deputedTasks[index].set(state: EcoSystem.ProjectEnvironment.Project.Phase.Task.ActiveTask())
                    task = deputedTasks[index]
                }
                else {
                    return
                }
            }
            else {
                var index = -10
                for i in deputedTasks.indices{
                    if deputedTasks[i].state is EcoSystem.ProjectEnvironment.Project.Phase.Task.OpenTask{
                        index = i
                    }
                }
                if index != -10 {
                    deputedTasks[index].set(state: EcoSystem.ProjectEnvironment.Project.Phase.Task.ActiveTask())
                    task = deputedTasks[index]
                }
                else {
                    return
                    
                }
            }
            
            modification.append(Modification(id: modification.count, task: task,
                                             motion: EcoSystem.EmployerEnvironment.ActivateMotion(date: EcoSystem.`singleAccess`.date, slave: self)))
        }

        func complete(at id: Int?) {
            var index = -10
            for i in deputedTasks.indices{
                if deputedTasks[i].state is EcoSystem.ProjectEnvironment.Project.Phase.Task.ActiveTask{
                    index = i
                }
            }
            if index != -10 {
                deputedTasks[index].set(state: EcoSystem.ProjectEnvironment.Project.Phase.Task.ResolvedTask() )
                modification.append(Modification(id: modification.count,
                                                 task: deputedTasks[index],
                                                 motion: EcoSystem.EmployerEnvironment.ResolveMotion(date: EcoSystem.`singleAccess`.date, slave: self)))
            }
        }

        func createReport(title: String, message: String, type: ReportType) {
            if report == nil {
                if type is day{
                    report = ReportForOneDay.buildReport(id: EcoSystem.`singleAccess`.projectEnv.project!.numberOfReports, title: title, message: message, date: EcoSystem.`singleAccess`.date, employee: self)
                    EcoSystem.`singleAccess`.projectEnv.project!.numberOfReports += 1
                }
                else if type is phase{
                    if let _ = EcoSystem.`singleAccess`.projectEnv.project?.stage{
                        var index = -10
                        for i in deputedTasks.indices{
                            if deputedTasks[i].state is EcoSystem.ProjectEnvironment.Project.Phase.Task.ResolvedTask{
                                index = i
                            }
                        }
                        if index != -10{
                            return
                        }
                        
                        report = PhaseReport.create(id: EcoSystem.`singleAccess`.projectEnv.project!.reportsPhase.count, title: title, message: message, date: EcoSystem.`singleAccess`.date, employee: self)
                    }
                    else{
                        return
                    }
                }
            }
            else{
                return
            }
            
        }
        
        func modifier(head: Employe) {
            if let _ = self.chief{
                if head.isSubordinate(of: self) {
                    return
                }
                if self.chief! == head {
                    return
                }
                var index = -10
                for i in self.chief!.slaves.indices{
                    if self.chief!.slaves[i] == self{
                        index = i
                    }
                }
                self.chief!.slaves.remove(at: index)
                self.chief = head
                head.slaves.append(self)
            }
            else{
                return
            }
        }

        func isSubordinate(of employee: Employe) -> Bool {
            if self.chief == nil {
                return false
            }
            if self.chief! == employee {
                return true
            }
            else {
                return self.chief!.isSubordinate(of: employee)
            }
        }

        static func == (lhs: Employe, rhs: Employe) -> Bool {
            return lhs.id == rhs.id
        }
        
        struct Modification {
            
            let id: Int

            let task: EcoSystem.ProjectEnvironment.Project.Phase.Task

            let motion: Motion
        }
        
    }
}
