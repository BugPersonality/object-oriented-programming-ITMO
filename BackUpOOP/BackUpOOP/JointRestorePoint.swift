import Foundation

class JointRestorePoint : RestorePoint{
    private(set) var filesInPoint: [FileResoreCopyInfo] = []
    private(set) var size: Double = 0.0
    private(set) var type: TypeOfPoint
    private(set) var date: String
    private(set) var filesInArchive: [FileResoreCopyInfo] = []
    
    init(files: [FileInfo], typeOfPoint: TypeOfPoint) {
        self.type = typeOfPoint
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
