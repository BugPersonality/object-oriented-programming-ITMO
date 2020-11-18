import Foundation

class SeparateRestorePoint: RestorePoint {
    private(set) var filesInPoint: [FileResoreCopyInfo] = []
    private(set) var size: Double = 0.0
    private(set) var type: TypeOfPoint
    private(set) var date: String
    
    init(files: [FileInfo], typeOfPoint: TypeOfPoint) {
        self.type = typeOfPoint
        self.date = DateNow().getDate()
        for file in files {
            self.filesInPoint.append(FileResoreCopyInfo(name: file.fileName,
                                                        date: DateNow().getDate(),
                                                        size: file.fileSize))
        }
        size = self.getTotalSizeOfPoint(files: files)
    }
}
