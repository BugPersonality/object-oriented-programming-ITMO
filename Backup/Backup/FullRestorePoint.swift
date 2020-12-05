import Foundation

class FullRestorePoint: RestorePoint{
    
    private(set) var filesInArchive: [FileResoreCopyInfo] = []
    private(set) var filesInPoint: [FileResoreCopyInfo] = []
    private(set) var size: Double = 0
    private(set) var typeOfStorage: TypeOfStorage
    private(set) var date: String
    
    init(files: [FileInfo], typeOfStorage: TypeOfStorage) {
        self.typeOfStorage = typeOfStorage
        
        if typeOfStorage == .separateStorage{
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
    
}
