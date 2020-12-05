import Foundation
 
class IncrementalRestorePoint: RestorePoint{
    private(set) var filesInArchive: [FileResoreCopyInfo] = []
    private(set) var filesInPoint: [FileResoreCopyInfo] = []
    private(set) var size: Double = 0
    private(set) var typeOfStorage: TypeOfStorage
    private(set) var date: String = ""
    
    init(typeOfStorage: TypeOfStorage) {
        self.typeOfStorage = typeOfStorage
    }
    
    func collectPoint(filesForBeckup: [FileInfo], points: [RestorePoint])throws{
        let files = findFilesForIncrementalPoint(filesForBeckUp: filesForBeckup, points: points)
        
        if !files.isEmpty{
            if self.typeOfStorage == .separateStorage{
                self.date = DateNow().getDate()
                for file in files {
                    self.filesInPoint.append(FileResoreCopyInfo(name: file.fileName,
                                                                date: DateNow().getDate(),
                                                                size: file.fileSize))
                }
                size = self.getTotalSizeOfPoint(files: files)
            }
            else{
                self.date = DateNow().getDate()
                size = self.getTotalSizeOfPoint(files: files) * 0.6
                
                filesInPoint.append(FileResoreCopyInfo(name: "JointFile.allFormat",
                                                       date: DateNow().getDate(),
                                                       size: size))
                for file in files {
                            self.filesInArchive.append(FileResoreCopyInfo(name: file.fileName,
                                                                          date: DateNow().getDate(),
                                                                          size: file.fileSize))
                        }
            }
        }
        else{
            throw BackupError.NothingHasChangedInFiles
        }
    }
    
    func findFilesForIncrementalPoint(filesForBeckUp: [FileInfo], points: [RestorePoint]) -> [FileInfo]{
        var filesForIncrementalPoint: [FileInfo] = []
        var index: Int = -10
        
        for i in (0..<points.count).reversed(){
            if points[i] is FullRestorePoint{
                index = i
                break
            }
        }
        
        if index != -10{
        if points[index].typeOfStorage == .separateStorage{
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
        else if points[index].typeOfStorage == .jointStorage{
            
            for file in filesForBeckUp{
                var existence = false
                
                for pointFile in points[index].filesInArchive{
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
}
