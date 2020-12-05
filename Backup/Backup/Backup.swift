import Foundation

class Backup{
    private let backupName: String
    private var backupId: Int
    private var directoryPath: String
    
    private var filesForBeckup: [FileInfo] = []
    private var points: [RestorePoint] = []
    
    init(dirPath: String, id: Int, name: String) {
        self.backupName = name
        self.directoryPath = dirPath
        self.backupId = id
    }
    
    func addFilesIntoBackup(filesNames: [String])throws{
        var tempFileNameList: [FileInfo] = []
        
        for fileName in filesNames{
            
            var flag = true
            
            for existFileName in filesForBeckup{
                if fileName == existFileName.fileName{
                    flag = false
                }
            }
            
            if flag{
                let fileInfo = try getInfoAboutFile(fileName: fileName)
                
                let fileDate = fileInfo[5] + " " + fileInfo[6] + fileInfo[7]
                
                tempFileNameList.append(FileInfo(name: fileName, date: fileDate, size: Double(fileInfo[4]) ?? 0))
            }
            else{
                continue
            }
        }
        
        for fileName in tempFileNameList{
            filesForBeckup.append(fileName)
        }
    }
    
    func deleteFilesFromBackup(filesNames: [String]){
        for fileName in filesNames{
            for i in 0..<filesForBeckup.count{
                if fileName == filesForBeckup[i].fileName{
                    filesForBeckup.remove(at: i)
                    break
                }
            }
        }
    }
    
    func createRestorePoint(typeOfpoint: TypeOfPoint, typeOfSaving: TypeOfStorage) throws{
        
        if filesForBeckup.isEmpty{
            throw BackupError.ArrayEmptyError("No such files for backup")
        }
        
        try updateInfoAboutFiles()
        
        switch typeOfpoint {
        
        case .full:
            switch  typeOfSaving{
            
            case .jointStorage:
                points.append(FullRestorePoint(files: filesForBeckup, typeOfStorage: .jointStorage))
                
            case .separateStorage:
                points.append(FullRestorePoint(files: filesForBeckup, typeOfStorage: .separateStorage))
            }
        case .incremental:
            switch typeOfSaving {
            
            case .jointStorage:
                let tempIncrementalPoint = IncrementalRestorePoint(typeOfStorage: .jointStorage)
                try tempIncrementalPoint.collectPoint(filesForBeckup: filesForBeckup, points: points)
                points.append(tempIncrementalPoint)
                
            case .separateStorage:
                let tempIncrementalPoint = IncrementalRestorePoint(typeOfStorage: .separateStorage)
                try tempIncrementalPoint.collectPoint(filesForBeckup: filesForBeckup, points: points)
                points.append(tempIncrementalPoint)
                
            }
        }
        sleep(1)
    }
    
    private func updateInfoAboutFiles() throws{
        var newFilesForBAckupArray: [FileInfo] = []
        
        for file in self.filesForBeckup{
            let tempName = file.fileName
            var fileInfo: [String]
            
            do {
                fileInfo = try getInfoAboutFile(fileName: tempName)
            } catch  {
                print("\(tempName) don't exist")
                continue
            }
            
            let fileDate = fileInfo[5] + " " + fileInfo[6] + fileInfo[7]
            
            newFilesForBAckupArray.append(FileInfo(name: tempName, date: fileDate, size: Double(fileInfo[4]) ?? 0))
        }
        if !newFilesForBAckupArray.isEmpty{
            self.filesForBeckup.removeAll()
            self.filesForBeckup = newFilesForBAckupArray
        }
        else{
            throw BackupError.ArrayEmptyError("No files for backup")
        }
    }
    
    private func getInfoAboutFile(fileName: String) throws -> [String]{
        let task = Process()
        let pipe = Pipe()
        let command = "ls -l \(self.directoryPath)/\(fileName)"
        
        task.standardOutput = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/bash"
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        if output.isEmpty{
            throw BackupError.NoSuchFileOrDirectoryError("directory \(self.directoryPath) or file \(fileName) doesn't exist")
        }
        else{
            var fileInfo: [String] = output.components(separatedBy: " ")
            
            fileInfo.removeAll(where: {$0 == ""})
            
            let subItem8 = String(fileInfo[8][fileInfo[8].startIndex..<fileInfo[8].index(fileInfo[8].endIndex,
                                                                                         offsetBy: -1)])
            fileInfo[8] = subItem8
            
            return fileInfo
            //Example
            //["-rwxrwxrwx@", "1", "danildubov", "staff", "6136", "Nov", "4", "15:12", "/Users/danildubov/Swift/BackUpOOP/BackUpOOP/Files/SwiftFunc.rtf"]
        }
    }
    
    func cleanPoints(cleaner: PointCleaner)throws{
        self.points = try cleaner.clearPoins(points: self.points)
    }
    
    private func getTotalSizeOfBAckUp() -> Double{
        var totalSize = 0.0
        for point in self.points{
            totalSize += point.size
        }
        return totalSize
    }
    
    func printBackUp(){
        print("\n\tTotal size of \(self.backupName): \(self.getTotalSizeOfBAckUp())")
        for point in points{
            print("-----------------------------------------------")
            if point is FullRestorePoint
            {
                print("Type of Point: Full Point")
            }
            else if point is IncrementalRestorePoint{
                print("Type of Point: Incremental Point")
            }
            
            print("Type of Point: \(point.typeOfStorage)\nPoint size: \(point.size)\nPoint date: \(point.date)\nFiles in Point: ")
            for file in point.filesInPoint{
                print("\tName: \(file.fileName) | Size: \(file.fileSize) byte")
            }
            
        }
        print("-----------------------------------------------")
        print()
    }
}
