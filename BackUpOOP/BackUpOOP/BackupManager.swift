import Foundation

class BackupManager{
    fileprivate var arrayOfBacups: [BackUp] = []
    fileprivate var tempId: Int = -1;
    
    func addBackUp(dirPath: String, name: String) -> Int{
        self.tempId += 1
        arrayOfBacups.append(BackUp(dirPath: dirPath, id: self.tempId, name: name))
        return self.tempId
    }
    
    func createBackUp(id: Int, filesNames: String...)throws{
        try arrayOfBacups[id].createBackup(filesNames: filesNames)
    }
    
    func createRestorePoint(id: Int, typeOfPoint: TypeOfPoint, typeOfStorage: TypeOfStorage, filesNames: [String]?)throws{
        try arrayOfBacups[id].createRestorePoint(typeOfpoint: typeOfPoint, typeOfSaving: typeOfStorage, filesNames: filesNames)
    }
    
    func cleanPoints(id: Int, cleaner: PointCleaner)throws{
        try arrayOfBacups[id].cleanPoints(cleaner: cleaner)
    }
    
    func printBackUp(id: Int){
        arrayOfBacups[id].printBackUp()
    }
}
