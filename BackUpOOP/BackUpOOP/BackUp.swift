import Foundation

class BackUp{
    private let backupName: String
    private var backupId: Int
    private var backUpStatus: Bool = true
    private var directoryPath: String
    
    private var filesForBeckUp: [FileInfo] = []
    private var points: [RestorePoint] = []
    
    init(dirPath: String, id: Int, name: String) {
        self.backupName = name
        self.directoryPath = dirPath
        self.backupId = id
    }
    
    func createBackup(filesNames: [String]) throws{
        if backUpStatus == true{
            
            for fileName in filesNames{
                
                let fileInfo = try getInfoAboutFile(fileName: fileName)
                    
                let fileDate = fileInfo[5] + " " + fileInfo[6] + " " + fileInfo[7]
                
                filesForBeckUp.append(FileInfo(name: fileName, date: fileDate, size: Double(fileInfo[4]) ?? 0))
                
            }
            
            self.backUpStatus = false
        }
        else{
            throw BackupError.BackupAlreadyCreated
        }
    }
    
    private func createResorePointByTypes (typeOfpoint: TypeOfPoint, typeOfSaving: TypeOfStorage)throws {
        
        try updateInfoAboutFiles()
        
        switch typeOfpoint {
        
        case .full:
            switch  typeOfSaving{
            
            case .jointStorage:
                points.append(JointRestorePoint(files: filesForBeckUp, typeOfPoint: .full))
                //print("full joint")
                
            case .separateStorage:
                points.append(SeparateRestorePoint(files: filesForBeckUp, typeOfPoint: .full))
                //print("full separate")
            }
        case .incremental:
            switch typeOfSaving {
            
            case .jointStorage:
                let tempFiles = try findFilesForIncrementalRestorePoint()
                if !tempFiles.isEmpty{
                    points.append(JointRestorePoint(files: tempFiles, typeOfPoint: .incremental))
                }
                else{
                    throw BackupError.NothingHasChangedInFiles
                }
                //print("inctremental joint")
                
            case .separateStorage:
                let tempFiles = try findFilesForIncrementalRestorePoint()
                if !tempFiles.isEmpty{
                    points.append(SeparateRestorePoint(files: tempFiles, typeOfPoint: .incremental))
                }
                else{
                    throw BackupError.NothingHasChangedInFiles
                }
                //print("incremental separate")
            }
        }
        sleep(1)
    }
    
    func createRestorePoint(typeOfpoint: TypeOfPoint, typeOfSaving: TypeOfStorage, filesNames: [String]?) throws{
        
        if filesForBeckUp.isEmpty{
            throw BackupError.ArrayEmptyError("No such files for backup")
        }
        
        if filesNames == nil{
            try createResorePointByTypes(typeOfpoint: typeOfpoint, typeOfSaving: typeOfSaving)
        }
        else{
            var tempFileNameList: [FileInfo] = []
            //var existFile: String = ""
            
            for fileName in filesNames!{
                
                var flag = true
                
                for existFileName in filesForBeckUp{
                    if fileName == existFileName.fileName{
                        flag = false
                        //existFile = fileName
                    }
                }
                
                if flag{
                    let fileInfo = try getInfoAboutFile(fileName: fileName)
                    
                    let fileDate = fileInfo[5] + " " + fileInfo[6] + fileInfo[7]
                    
                    tempFileNameList.append(FileInfo(name: fileName, date: fileDate, size: Double(fileInfo[4]) ?? 0))
                }
                else{
                    continue
                    //throw BackupError.AddingAnExistingFileError("\(existFile) file exist")
                }
            }
            
            for fileName in tempFileNameList{
                filesForBeckUp.append(fileName)
            }
            
            try createResorePointByTypes(typeOfpoint: typeOfpoint, typeOfSaving: typeOfSaving)
        }
    }
    
    private func findFilesForIncrementalRestorePoint()throws -> [FileInfo]{
        var index: Int = -10
        
        for i in (0..<points.count).reversed(){
            if points[i].type == .full{
                index = i
                break
            }
        }
        
        if index != -10{
            var filesForIncrementalPoint: [FileInfo] = []
            
            if points[index] is SeparateRestorePoint{
                for file in filesForBeckUp{
                    var existence = false
                    
                    for pointFile in points[index].filesInPoint{
                        if (file.fileName == pointFile.fileName){
                            existence = true
                        }
                        if (file.fileName == pointFile.fileName) && (file.fileSize != pointFile.fileSize){
                            filesForIncrementalPoint.append(file)
                        }
                    }
                    if !existence{
                        filesForIncrementalPoint.append(file)
                    }
                }
                
                return filesForIncrementalPoint
            }
            else if points[index] is JointRestorePoint{
                let jointPoint = points[index] as! JointRestorePoint
                
                for file in filesForBeckUp{
                    var existence = false
                    
                    for pointFile in jointPoint.filesInArchive{
                        if (file.fileName == pointFile.fileName){
                            existence = true
                        }
                        if (file.fileName == pointFile.fileName) && (file.fileSize != pointFile.fileSize){
                            filesForIncrementalPoint.append(file)
                        }
                    }
                    if !existence{
                        filesForIncrementalPoint.append(file)
                    }
                }
                
                return filesForIncrementalPoint
            }
            else{
                return filesForIncrementalPoint
            }
        }
        else{
            return filesForBeckUp
        }
    }
    
    private func updateInfoAboutFiles() throws{
        var newFilesForBAckupArray: [FileInfo] = []
        
        for file in self.filesForBeckUp{
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
            self.filesForBeckUp.removeAll()
            self.filesForBeckUp = newFilesForBAckupArray
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
            if point is JointRestorePoint
            {
                print("Type of Storage: Joint Point")
            }
            else if point is SeparateRestorePoint{
                print("Type of Storage: Separate Point")
            }
            
            print("Type of Point: \(point.type)\nPoint size: \(point.size)\nPoint date: \(point.date)\nFiles in Point: ")
            for file in point.filesInPoint{
                print("\tName: \(file.fileName) | Size: \(file.fileSize) byte")
            }
            
        }
        print("-----------------------------------------------")
        print()
    }
}
