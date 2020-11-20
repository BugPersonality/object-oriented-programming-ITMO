import Foundation

class PointCleaner{
    let cleaningType: PoinCleaningType
    
    init(cleaningType: PoinCleaningType) {
        self.cleaningType = cleaningType
    }
    
    func clearPoins(points: [RestorePoint])throws -> [RestorePoint]{
        switch cleaningType {
        
        case .countOfPoints(maxCountOfPoints: let maxCountOfPoints):
            if maxCountOfPoints < 0{
                throw BackupError.IncorrectArgumentsInCleaner("Max count of points \(maxCountOfPoints) < 0")
            }
            if checkByCount(points: points, maxCount: maxCountOfPoints){
                return clearByCount(points: points, maxCount: maxCountOfPoints)
            }
            else{
                return points
            }
            
        case .dateOfPoints(dateUntilWhichDeleteAll: let dateUntilWhichDeleteAll):
            if checkDateOnCorrect(date: dateUntilWhichDeleteAll){
                if checkBydate(points: points, maxDate: dateUntilWhichDeleteAll){
                    return clearByDate(points: points, maxDate: dateUntilWhichDeleteAll)
                }
                else{
                    return points
                }
            }
            else{
                throw BackupError.IncorrectArgumentsInCleaner("\(dateUntilWhichDeleteAll) != format.(dd/MM/yyyy HH:mm:ss)")
            }
            
        case .sizeOfPoint(maxSizeOfAllPointInBytes: let maxSizeOfAllPointInBytes):
            if maxSizeOfAllPointInBytes < 0{
                throw BackupError.IncorrectArgumentsInCleaner("Max size of points: \(maxSizeOfAllPointInBytes) < 0")
            }
            if checkBySize(points: points, maxSize: maxSizeOfAllPointInBytes){
                return clearBySize(points: points, maxSize: maxSizeOfAllPointInBytes)
            }
            else{
                return points
            }
            
        case .gybrid(type: let type):
            var newPoints = points
            switch type{
            
            case .wentBeyondOne(maxCountOfPoints: let maxCountOfPoints,
                                dateUntilWhichDeleteAll: let dateUntilWhichDeleteAll,
                                maxSizeOfAllPointInBytes: let maxSizeOfAllPointInBytes):
                if (maxCountOfPoints != nil){
                    if checkByCount(points: newPoints, maxCount: maxCountOfPoints!){
                        newPoints = clearByCount(points: newPoints, maxCount: maxCountOfPoints!)
                    }
                }
                if (dateUntilWhichDeleteAll != nil && checkDateOnCorrect(date: dateUntilWhichDeleteAll!)){
                    if checkBydate(points: newPoints, maxDate: dateUntilWhichDeleteAll!){
                        newPoints = clearByDate(points: newPoints, maxDate: dateUntilWhichDeleteAll!)
                    }
                }
                if (maxSizeOfAllPointInBytes != nil){
                    if checkBySize(points: newPoints, maxSize: maxSizeOfAllPointInBytes!){
                        newPoints = clearBySize(points: newPoints, maxSize: maxSizeOfAllPointInBytes!)
                    }
                }
                
                return newPoints
                
            case .wentBeyondAll(maxCountOfPoints: let maxCountOfPoints,
                                dateUntilWhichDeleteAll: let dateUntilWhichDeleteAll,
                                maxSizeOfAllPointInBytes: let maxSizeOfAllPointInBytes):
                var statusDate = true
                var statusSize = true
                var statusCount = true
                
                if (dateUntilWhichDeleteAll != nil && checkDateOnCorrect(date: dateUntilWhichDeleteAll!)){
                    statusDate = checkBydate(points: points, maxDate: dateUntilWhichDeleteAll!)
                }
                if (maxSizeOfAllPointInBytes != nil){
                    statusSize = checkBySize(points: points, maxSize: maxSizeOfAllPointInBytes!)
                }
                if (maxCountOfPoints != nil){
                    statusCount = checkByCount(points: points, maxCount: maxCountOfPoints!)
                }
                if statusCount && statusSize && statusDate{
                    if (maxCountOfPoints != nil){
                        if checkByCount(points: newPoints, maxCount: maxCountOfPoints!){
                            newPoints = clearByCount(points: newPoints, maxCount: maxCountOfPoints!)
                        }
                    }
                    if (dateUntilWhichDeleteAll != nil){
                        if checkBydate(points: newPoints, maxDate: dateUntilWhichDeleteAll!){
                            newPoints = clearByDate(points: newPoints, maxDate: dateUntilWhichDeleteAll!)
                        }
                    }
                    if (maxSizeOfAllPointInBytes != nil){
                        if checkBySize(points: newPoints, maxSize: maxSizeOfAllPointInBytes!){
                            newPoints = clearBySize(points: newPoints, maxSize: maxSizeOfAllPointInBytes!)
                        }
                    }
                }
                return newPoints
            }
        }
    }
    
    func checkByCount(points: [RestorePoint], maxCount: Int) -> Bool{
        return points.count > maxCount
    }
    
    func checkBySize(points: [RestorePoint], maxSize: Double) -> Bool{
        var pointsSize: Double = 0.0
        if !points.isEmpty{
            for point in points{
                pointsSize += point.size
            }
            return pointsSize > maxSize
        }
        else{
            return false
        }
    }
    
    func checkBydate(points: [RestorePoint], maxDate: String) -> Bool{
        for point in points{
            if point.date < maxDate{
                return true
            }
        }
        return false
    }
    
    func clearByCount(points: [RestorePoint], maxCount: Int) -> [RestorePoint]{
        var newPoints = points
        var lastIdex: Int = points.count - maxCount
        
        if maxCount == 0{
            newPoints.removeAll()
            return newPoints
        }
        
        if lastIdex == 0 && newPoints[lastIdex + 1].type != .incremental{
            newPoints.removeFirst()
            return newPoints
        }
        
        if lastIdex == 0 && newPoints[lastIdex + 1].type == .incremental{
            return newPoints
        }
        
        if lastIdex == 1 && newPoints[lastIdex].type == .incremental{
            return newPoints
        }
        
        if newPoints[lastIdex].type == .full{
            for _ in 0..<lastIdex{
                newPoints.removeFirst()
            }
            return newPoints
        }
        else{
            while lastIdex > 1{
                lastIdex -= 1
                if newPoints[lastIdex].type == .full{
                    break
                }
            }
            if newPoints[lastIdex].type == .incremental{ // fiiiiiiiii...
                return newPoints
            }
            else{
                for _ in 0..<lastIdex{
                    newPoints.removeFirst()
                }
                return newPoints
            }
        }
//        var newPoints = points
//
//        while newPoints.count > maxCount{
//            newPoints.removeLast()
//        }
//        return newPoints
    }
    
    func clearBySize(points: [RestorePoint], maxSize: Double) -> [RestorePoint]{
        var newPoints = points
        var tempSize = maxSize
        var lastIdex: Int = newPoints.count - 1
        
        while tempSize > 0 {
            tempSize -= newPoints[lastIdex].size
            if tempSize < 0{
                lastIdex += 1
                break
            }
            else{
                lastIdex -= 1
            }
        }
        
        if newPoints[lastIdex].type != .incremental{
            for _ in 0..<lastIdex{
                newPoints.removeFirst()
            }
        }
        else{
            while lastIdex > 1{
                lastIdex -= 1
                if newPoints[lastIdex].type == .full{
                    break
                }
            }
            if newPoints[lastIdex].type == .incremental{ // fiiiiiiiii...
                return newPoints
            }
            else{
                for _ in 0..<lastIdex{
                    newPoints.removeFirst()
                }
                return newPoints
            }
        }
        
        return newPoints
//        var newPoints = points
//        var pointsSize: Double = 0.0
//
//        for point in points{
//            pointsSize += point.size
//        }
//
//        for i in (0..<newPoints.count).reversed(){
//            if (pointsSize > maxSize){
//                pointsSize -= newPoints[i].size
//                newPoints.removeLast()
//            }
//            else{
//                break
//            }
//        }
//
//        return newPoints
    }
    
    func clearByDate(points: [RestorePoint], maxDate: String) -> [RestorePoint]{
        var newPoints = points
        for i in (0..<newPoints.count).reversed(){
            if newPoints[i].date < maxDate{
                newPoints.remove(at: i)
            }
        }
        
        return newPoints
    }
    
    func checkDateOnCorrect(date: String) -> Bool{
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy HH:mm:ss"
        if formater.date(from: date) != nil{
            return true
        }else{
            return false
        }
    }
}
