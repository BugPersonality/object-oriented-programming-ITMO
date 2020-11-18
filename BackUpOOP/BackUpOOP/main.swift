import Foundation

// Create Backup Manager
var backupManager = BackupManager()

// Add first backup into backup manager
let firstBackUpId = backupManager.addBackUp(dirPath: "/Users/danildubov/Swift/BackUpOOP/BackUpOOP/Files",
                                            name: "firstBackUp")

// Add first elements into first backup
do{
    try backupManager.createBackUp(id: firstBackUpId,
                                   filesNames: "SwiftFunc20.txt", "SwiftFunc.txt")
}catch{
    print("\(error)")
}

// Create full separate point without new arguments
do{
    try backupManager.createRestorePoint(id: firstBackUpId,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: firstBackUpId)
}catch{
    print("\(error)")
}

// Create full separate point with new arguments
do{
    try backupManager.createRestorePoint(id: firstBackUpId,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: ["stickr1.png"])
    backupManager.printBackUp(id: firstBackUpId)
}catch{
    print("\(error)")
}

// Clean Points by date
do{
    try backupManager.cleanPoints(id: firstBackUpId, cleaner: PointCleaner(cleaningType:
                                                                            .dateOfPoints(dateUntilWhichDeleteAll: timeForClean())))
    backupManager.printBackUp(id: firstBackUpId)
}catch{
    
}

// Create full separate point without new arguments
do{
    try backupManager.createRestorePoint(id: firstBackUpId,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: firstBackUpId)
}catch{
    print("\(error)")
}

// Create full separate point with new arguments
do{
    try backupManager.createRestorePoint(id: firstBackUpId,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: ["stickr1.png"])
    backupManager.printBackUp(id: firstBackUpId)
}catch{
    print("\(error)")
}

// Create full joint point without new arguments
do{
    try backupManager.createRestorePoint(id: firstBackUpId,
                                         typeOfPoint: .full,
                                         typeOfStorage: .jointStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: firstBackUpId)
    
}catch {
    print("\(error)")
}

// Change file
printLineIntoFile(filePath: "~/Swift/BackUpOOP/BackUpOOP/Files/SwiftFunc.txt")

// Create incremental separate point with new args
do{
    try backupManager.createRestorePoint(id: firstBackUpId,
                                         typeOfPoint: .incremental,
                                         typeOfStorage: .separateStorage,
                                         filesNames: ["sticker.png"])
    backupManager.printBackUp(id: firstBackUpId)
}catch{
    print("\(error)")
}

// Change file
printLineIntoFile(filePath: "~/Swift/BackUpOOP/BackUpOOP/Files/SwiftFunc20.txt")

// Create incremental separate point without new args
do{
    try backupManager.createRestorePoint(id: firstBackUpId,
                                         typeOfPoint: .incremental,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: firstBackUpId)
}catch{
    print("\(error)")
}

// Case №1

print("\n CASE №1 \n")

let secondBackup = backupManager.addBackUp(dirPath: "/Users/danildubov/Swift/BackUpOOP/BackUpOOP/Files", name: "secondBAckUp")

do{
    try backupManager.createBackUp(id: secondBackup, filesNames: "sticker.png", "stickr1.png")
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: secondBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: secondBackup)
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: secondBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: secondBackup)
}catch{
    print("\(error)")
}

do{
    try backupManager.cleanPoints(id: secondBackup, cleaner: PointCleaner(cleaningType: .countOfPoints(maxCountOfPoints: 1)))
    backupManager.printBackUp(id: secondBackup)
}catch{
    print("\(error)")
}

// Case №2

print("\n CASE №2 \n")

let thirdBackup = backupManager.addBackUp(dirPath: "/Users/danildubov/Swift/BackUpOOP/BackUpOOP/Files", name: "thirdBackup")

do{
    try backupManager.createBackUp(id: thirdBackup, filesNames: "sticker.png", "stickr1.png")
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: thirdBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: thirdBackup)
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: thirdBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: thirdBackup)
}catch{
    print("\(error)")
}

do{
    try backupManager.cleanPoints(id: thirdBackup,cleaner: PointCleaner(cleaningType:
                                                                            .sizeOfPoint(maxSizeOfAllPointInBytes: 701931.0)))
    backupManager.printBackUp(id: thirdBackup)
}catch{
    print("\(error)")
}

// Case №4

print("\n CASE №4 \n")

let fourthBackup = backupManager.addBackUp(dirPath: "/Users/danildubov/Swift/BackUpOOP/BackUpOOP/Files", name: "fourthBackup")

do{
    try backupManager.createBackUp(id: fourthBackup, filesNames: "sticker.png", "stickr1.png")
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: fourthBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: fourthBackup)
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: fourthBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
    backupManager.printBackUp(id: fourthBackup)
}catch{
    print("\(error)")
}
// Went beyound time and size but not for count
do{
    try backupManager.cleanPoints(id: fourthBackup, cleaner: PointCleaner(cleaningType:
                                                                            .gybrid(type: .wentBeyondAll(
                                                                                        maxCountOfPoints: 7,
                                                                                        dateUntilWhichDeleteAll: timeForClean(),
                                                                                        maxSizeOfAllPointInBytes: 100000.0))))
    backupManager.printBackUp(id: fourthBackup)
}catch{
    print("\(error)")
}

// Went beyound all
do{
    try backupManager.cleanPoints(id: fourthBackup, cleaner: PointCleaner(cleaningType:
                                                                            .gybrid(type: .wentBeyondAll(
                                                                                        maxCountOfPoints: 1,
                                                                                        dateUntilWhichDeleteAll: timeForClean(),
                                                                                        maxSizeOfAllPointInBytes: 100000.0))))
    backupManager.printBackUp(id: fourthBackup)
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: fourthBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
}catch{
    print("\(error)")
}

do{
    try backupManager.createRestorePoint(id: fourthBackup,
                                         typeOfPoint: .full,
                                         typeOfStorage: .separateStorage,
                                         filesNames: nil)
}catch{
    print("\(error)")
}

// Went beyound time 
do{
    try backupManager.cleanPoints(id: fourthBackup, cleaner: PointCleaner(cleaningType:
                                                                            .gybrid(type: .wentBeyondOne(
                                                                                        maxCountOfPoints: 7,
                                                                                        dateUntilWhichDeleteAll: timeForClean(),
                                                                                        maxSizeOfAllPointInBytes: 100000.0))))
    backupManager.printBackUp(id: fourthBackup)
}catch{
    print("\(error)")
}
