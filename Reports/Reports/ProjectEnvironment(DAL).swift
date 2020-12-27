import Foundation

extension EcoSystem {
    class ProjectEnvironment{
        
        private(set) var project: Project?
        
        func build(denotationOfProject: String) -> Project? {
            if project == nil{
                project = Project.project(name: denotationOfProject)
                return project
            }
            else{
                return nil
            }
        }
    }
}
