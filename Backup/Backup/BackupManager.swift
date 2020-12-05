import Foundation

class BackupManager{
    fileprivate var arrayOfBacups: [Backup] = []
    fileprivate var tempId: Int = -1;
    
    func addBackUp(dirPath: String, name: String) -> Int{
        self.tempId += 1
        arrayOfBacups.append(Backup(dirPath: dirPath, id: self.tempId, name: name))
        return self.tempId
    }
    
    func createRestorePoint(id: Int, typeOfPoint: TypeOfPoint, typeOfStorage: TypeOfStorage)throws{
        try arrayOfBacups[id].createRestorePoint(typeOfpoint: typeOfPoint, typeOfSaving: typeOfStorage)
    }
    
    func cleanPoints(id: Int, cleaner: PointCleaner)throws{
        try arrayOfBacups[id].cleanPoints(cleaner: cleaner)
    }
    
    func printBackUp(id: Int){
        arrayOfBacups[id].printBackUp()
    }
    
    func addFileIntoBackup(id: Int, filesNames: String...)throws {
        try arrayOfBacups[id].addFilesIntoBackup(filesNames: filesNames)
    }
    
    func deleteFilesFromBackup(id: Int, filesNames: [String]){
        arrayOfBacups[id].deleteFilesFromBackup(filesNames: filesNames)
    }
}
