import Foundation

var backupManager = BackupManager()


let firstBackUpId = backupManager.addBackUp(dirPath: "/Users/danildubov/Swift/Backup/Backup/Files",
                                            name: "firstBackUp")

try backupManager.addFileIntoBackup(id: firstBackUpId, filesNames: "SwiftFunc20.txt", "SwiftFunc.txt")

try backupManager.createRestorePoint(id: firstBackUpId, typeOfPoint: .full, typeOfStorage: .separateStorage)

printLineIntoFile(filePath: "~/Swift/Backup/Backup/Files/SwiftFunc.txt")
try backupManager.createRestorePoint(id: firstBackUpId, typeOfPoint: .incremental, typeOfStorage: .separateStorage)

try backupManager.createRestorePoint(id: firstBackUpId, typeOfPoint: .full, typeOfStorage: .separateStorage)

printLineIntoFile(filePath: "~/Swift/Backup/Backup/Files/SwiftFunc.txt")
try backupManager.createRestorePoint(id: firstBackUpId, typeOfPoint: .incremental, typeOfStorage: .separateStorage)

try backupManager.createRestorePoint(id: firstBackUpId, typeOfPoint: .full, typeOfStorage: .separateStorage)

printLineIntoFile(filePath: "~/Swift/Backup/Backup/Files/SwiftFunc.txt")
try backupManager.createRestorePoint(id: firstBackUpId, typeOfPoint: .incremental, typeOfStorage: .separateStorage)

try backupManager.createRestorePoint(id: firstBackUpId, typeOfPoint: .incremental, typeOfStorage: .separateStorage)
backupManager.printBackUp(id: firstBackUpId)

// 8514 4667 8534 4687 8554 4707 4707
// f     i    f    i    f    i    i
try backupManager.cleanPoints(id: firstBackUpId, cleaner: PointCleaner(cleaningType: .countOfPoints(maxCountOfPoints: 5)))
backupManager.printBackUp(id: firstBackUpId)
