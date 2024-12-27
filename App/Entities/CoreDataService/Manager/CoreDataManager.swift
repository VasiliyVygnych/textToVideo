

import CoreData
import UIKit

protocol CoreManagerProtocol {
    var context: NSManagedObjectContext { get set }
    var delegat: AppDelegate { get set }

    func removaAll()
    func getAppData() -> [AppData]
    func addSubscride(mode: SubscriptionMode)
    func setMainModel(mode: SubscriptionMode)
    func editFree(_ bool: Bool,
                  freeAccess: Bool)
    func editPlus(_ bool: Bool)
    func editUltra(_ bool: Bool)
    func activationFreeAccess()
    func activationPlusAccess()
    func activationUltraAccess()
    func updateFreeAITime()
    func updatePlusAITime()
    
    func editFreeAITime(time: Double)
    func editPlusAITime(time: Double)
    
    func removeIncompleteData(id: Int)
    func getIncompleteData(_ sort: Bool) -> [IncompleteData]
    func setIncompleteBase(selector: SelectorEnums,
                           model: BaseData?)
    
    
    func getSavedVideos(_ sort: Bool) -> [SavedVideos]
    func removeSavedVideos(id: Int)
    func saveVideo(genType: String?,
                   title: String?,
                   duration: String?,
                   url: String?,
                   previewImage: UIImage?)
    func searchByType(type: String) -> [SavedVideos] 
    
    func addNewAlbun(name: String?)
    func getAlbumsData(_ sort: Bool) -> [AlbumsData]
    func removeAlbumsData(id: Int)
    
    func removeAlbumContents(id: Int)
    func removeAlbumContents(index: Int)
    func removeAlbumContents(nameID: String?)
    func getAlbumContents(nameID id: String) -> [AlbumContents]
    func addContentInAlbum(album: AlbumsData,
                           content: VideoContent)
    func removeItemsinAlbum(idNameAlbum: String)
    
    func setIncompleteTextToVideo(selector: SelectorEnums,
                                  model: TextToVideoData?)
    func setIncompleteVideoToVideo(selector: SelectorEnums,
                                   model: VideoToVideoData?)
    
    func addExampData(model: ExampModel?,
                      url: String?)
    func getExampData(_ sort: Bool) -> [ExampData]
    func removeExampData()
}

final class CoreManager: CoreManagerProtocol {
    
    var delegat: AppDelegate
    var context: NSManagedObjectContext
    
    init() {
        delegat = UIApplication.shared.delegate as! AppDelegate
        context = delegat.persistentContainer.viewContext
    }
    
    func removaAll() {
        removeAppData()
        removeIncompleteData()
        removeSavedVideos()
        removeAlbumsData()
        removeExampData()
    }
   
//MARK: - UserData
    
    func removeAppData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
            let data = try? context.fetch(fetchRequest) as? [AppData]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func getAppData() -> [AppData] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
            return try context.fetch(fetchRequest) as! [AppData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func setMainModel(mode: SubscriptionMode) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "AppData",
                                                         in: context) else { return }
        let data = AppData(entity: nameEntity,
                           insertInto: context)
        data.id = 0
        data.isLogin = true
        data.freeIsActive = true
        data.plusIsActive = true
        data.ultraIsActive = true
        switch mode {
        case .free:
            data.freeAccess = true
            data.isSubscripe = false
            data.freeIsActive = false
            data.subscripeID = "Free"
            data.subscripeType = SubscriptionType.free
            data.freeUpdateDate = Date()
            data.freeGenerationTime = 10
        case .monthlyPlus:
            data.subscripeID = "monthlyPlus"
            data.subscripeType = SubscriptionType.plus
            data.plusIsActive = false
            data.freeAccess = false
            data.isSubscripe = true
            data.plusUpdateDate = Date()
            data.dateOfSubscripe = Date()
            data.plusGenerationTime = 50
            data.albumLimitPlus = 5
        case .monthlyUltra:
            data.subscripeID = "monthlyUltra"
            data.subscripeType = SubscriptionType.Ultra
            data.ultraIsActive = false
            data.freeAccess = false
            data.isSubscripe = true
            data.ultraUpdateDate = Date()
            data.dateOfSubscripe = Date()
            data.albumLimitUltra = 15
        case .yearlyPlus:
            data.subscripeID = "yearlyPlus"
            data.subscripeType = SubscriptionType.plus
            data.plusIsActive = false
            data.freeAccess = false
            data.isSubscripe = true
            data.plusUpdateDate = Date()
            data.dateOfSubscripe = Date()
            data.plusGenerationTime = 50
            data.albumLimitPlus = 5
        case .yearlyUltra:
            data.subscripeID = "yearlyUltra"
            data.subscripeType = SubscriptionType.Ultra
            data.ultraIsActive = false
            data.freeAccess = false
            data.isSubscripe = true
            data.ultraUpdateDate = Date()
            data.dateOfSubscripe = Date()
            data.albumLimitUltra = 15
        case .none:
            data.subscripeID = "none"
            data.subscripeType = SubscriptionType.none
            data.freeAccess = false
            data.isSubscripe = false
        }
        delegat.saveContext()
    }
    func addSubscride(mode: SubscriptionMode) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.dateOfSubscripe = Date()
            switch mode {
            case .free:
                attribute.freeAccess = true
                attribute.isSubscripe = false
                attribute.subscripeID = "Free"
                attribute.freeIsActive = false
                attribute.freeUpdateDate = Date()
                attribute.subscripeType = SubscriptionType.free
                attribute.freeGenerationTime = 10
            case .monthlyPlus:
                attribute.subscripeID = "monthlyPlus"
                attribute.subscripeType = SubscriptionType.plus
                attribute.freeAccess = false
                attribute.isSubscripe = true
                attribute.plusIsActive = false
                attribute.plusUpdateDate = Date()
                attribute.plusGenerationTime = 50
                attribute.albumLimitPlus = 5
            case .monthlyUltra:
                attribute.subscripeID = "monthlyUltra"
                attribute.subscripeType = SubscriptionType.Ultra
                attribute.freeAccess = false
                attribute.isSubscripe = true
                attribute.ultraIsActive = false
                attribute.ultraUpdateDate = Date()
                attribute.albumLimitUltra = 15
            case .yearlyPlus:
                attribute.subscripeID = "yearlyPlus"
                attribute.subscripeType = SubscriptionType.plus
                attribute.freeAccess = false
                attribute.isSubscripe = true
                attribute.plusIsActive = false
                attribute.plusUpdateDate = Date()
                attribute.plusGenerationTime = 50
                attribute.albumLimitPlus = 5
            case .yearlyUltra:
                attribute.subscripeID = "yearlyUltra"
                attribute.subscripeType = SubscriptionType.Ultra
                attribute.freeAccess = false
                attribute.isSubscripe = true
                attribute.ultraIsActive = false
                attribute.ultraUpdateDate = Date()
                attribute.albumLimitUltra = 15
            case .none:
                attribute.subscripeID = "none"
                attribute.subscripeType = SubscriptionType.none
                attribute.freeAccess = false
                attribute.isSubscripe = false
            }
        }
        delegat.saveContext()
    }
    func activationFreeAccess() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.freeIsActive = true
            attribute.freeUpdateDate = Date()
        }
        delegat.saveContext()
    }
    func activationPlusAccess() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.plusIsActive = true
            attribute.freeUpdateDate = Date()
        }
        delegat.saveContext()
    }
    func activationUltraAccess() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.ultraIsActive = true
            attribute.freeUpdateDate = Date()
        }
        delegat.saveContext()
    }
    func updateFreeAITime() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.freeGenerationTime = 10
        }
        delegat.saveContext()
    }
    func updatePlusAITime() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.freeGenerationTime = 50
        }
        delegat.saveContext()
    }

    func editFree(_ bool: Bool,
                  freeAccess: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.freeAccess = freeAccess
            attribute.freeIsActive = bool
            attribute.freeUpdateDate = Date()
            attribute.restoreFreeMode = bool ? false : true
        }
        delegat.saveContext()
    }
    func editPlus(_ bool: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.plusIsActive = bool
            attribute.plusUpdateDate = Date()
            attribute.restorePlusMode = bool ? false : true
        }
        delegat.saveContext()
    }
    func editUltra(_ bool: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.ultraIsActive = bool
            attribute.freeUpdateDate = Date()
            attribute.restoreUltimaMode = bool ? false : true
        }
        delegat.saveContext()
    }
    
    
    
    func editFreeAITime(time: Double) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.freeGenerationTime -= time
        }
        delegat.saveContext()
    }
    
    func editPlusAITime(time: Double) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AppData],
                 let attribute = data.first(where: { $0.id == 0 }) else { return }
            attribute.plusGenerationTime -= time
        }
        delegat.saveContext()
    }
}

//MARK: - IncompleteData

extension CoreManager {
    
    func removeIncompleteData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IncompleteData")
        do {
            let data = try? context.fetch(fetchRequest) as? [IncompleteData]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func removeIncompleteData(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IncompleteData")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [IncompleteData],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    func getIncompleteData(_ sort: Bool) -> [IncompleteData] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IncompleteData")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [IncompleteData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func setIncompleteBase(selector: SelectorEnums,
                           model: BaseData?) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "IncompleteData",
                                                         in: context) else { return }
        let data = IncompleteData(entity: nameEntity,
                                  insertInto: context)
        let id = getIncompleteData(true)
        data.id = Int16(id.count - 1)
        data.pluginMode = model?.mode.value
        data.descriptions = model?.description
        data.descriptionsAI = model?.descriptionAI
        data.musicName = model?.music
        data.duration = model?.duration
        data.ratio = model?.ratio
        data.done = false
        data.dateOfCreate = Date()
        data.sreateSelector = selector.value
        delegat.saveContext()
    }
    
    func setIncompleteTextToVideo(selector: SelectorEnums,
                                  model: TextToVideoData?) {
        guard let nameEntity = NSEntityDescription.entity(forEntityName: "IncompleteData",
                                                          in: context) else { return }
        let data = IncompleteData(entity: nameEntity,
                                  insertInto: context)
        let id = getIncompleteData(true)
        data.id = Int16(id.count - 1)
        data.sreateSelector = selector.value
        data.descriptions = model?.description
        data.duration = model?.duration
        data.ratio = model?.ratio.value
        data.selectImage = model?.image?.pngData() ?? Data()
        data.strUrl = model?.strUrl
        data.styleMode = model?.models
        delegat.saveContext()
    }
    func setIncompleteVideoToVideo(selector: SelectorEnums,
                                   model: VideoToVideoData?) {
        guard let nameEntity = NSEntityDescription.entity(forEntityName: "IncompleteData",
                                                          in: context) else { return }
        let data = IncompleteData(entity: nameEntity,
                                  insertInto: context)
        let id = getIncompleteData(true)
        data.id = Int16(id.count - 1)
        data.sreateSelector = selector.value
        data.selectImage = model?.setyleImage?.pngData() ?? Data()
        data.strUrl = model?.urlString
        data.styleMode = model?.styleMode
        delegat.saveContext()
    }

}

//MARK: - SavedVideos

extension CoreManager {
    
    func removeSavedVideos() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVideos")
        do {
            let data = try? context.fetch(fetchRequest) as? [SavedVideos]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func removeSavedVideos(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVideos")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [SavedVideos],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)   
        }
        delegat.saveContext()
    }
    func getSavedVideos(_ sort: Bool) -> [SavedVideos] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVideos")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [SavedVideos]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func saveVideo(genType: String?,
                   title: String?,
                   duration: String?,
                   url: String?,
                   previewImage: UIImage?) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "SavedVideos",
                                                         in: context) else { return }
        let data = SavedVideos(entity: nameEntity,
                               insertInto: context)
        let id = getSavedVideos(true)
        data.id = Int16(id.count - 1)
        data.genType = genType
        data.title = title
        data.videoURL = url
        data.duration = duration
        data.dateOfCreate = Date()
        data.previewImage = previewImage?.pngData() ?? Data()
        delegat.saveContext()
    }
    func searchByType(type: String) -> [SavedVideos] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVideos")
        fetchRequest.predicate = NSPredicate(format: "genType CONTAINS[cd] %@", type)
        do {
            return try context.fetch(fetchRequest) as! [SavedVideos]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}


//MARK: - AlbumsData

extension CoreManager {
    
    func removeAlbumsData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumsData")
        do {
            let data = try? context.fetch(fetchRequest) as? [AlbumsData]
            data?.forEach({ context.delete($0) })
            removeAlbumContents(index: Int(data?.last?.addIndex ?? 0))
        }
        delegat.saveContext()
    }
    func removeAlbumsData(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumsData")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [AlbumsData],
                  let mark = data.first(where: { $0.id == id }) else { return }
            removeAlbumContents(nameID: mark.nameAlbum)
            context.delete(mark)
        }
        delegat.saveContext()
    }
    
    func getAlbumsData(_ sort: Bool) -> [AlbumsData] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumsData")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [AlbumsData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func addNewAlbun(name: String?) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "AlbumsData",
                                                         in: context) else { return }
        let data = AlbumsData(entity: nameEntity,
                                  insertInto: context)
        let id = getAlbumsData(true)
        data.id = Int16(id.count - 1)
        data.nameAlbum = name
        let nameId = String(format: "%d%@",
                            id.count - 1,
                            name ?? "")
        data.nameId = nameId
        data.dateOfCreate = Date()
        data.addIndex = Int16(id.count)
        delegat.saveContext()
    }
}

//MARK: - AlbumContents

extension CoreManager {
    func removeAlbumContents() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumContents")
        do {
            let data = try? context.fetch(fetchRequest) as? [AlbumContents]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func removeAlbumContents(index: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumContents")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [AlbumContents],
                  let mark = data.first(where: { $0.addIndex == index }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    func removeAlbumContents(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumContents")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [AlbumContents],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    
    
    
    
    
    func removeItemsinAlbum(idNameAlbum: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumContents")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [AlbumContents],
                  let mark = data.first(where: { $0.idNameAlbum == idNameAlbum }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    
    
    
    
    func removeAlbumContents(nameID: String?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumContents")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [AlbumContents],
                  let mark = data.first(where: { $0.idNameAlbum == nameID }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    func getAlbumContents(nameID id: String) -> [AlbumContents] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumContents")
        fetchRequest.predicate = NSPredicate(format: "idNameAlbum CONTAINS[cd] %@", id)
        do {
            return try context.fetch(fetchRequest) as! [AlbumContents]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func addContentInAlbum(album: AlbumsData,
                           content: VideoContent) {
        guard let nameEntity = NSEntityDescription.entity(forEntityName: "AlbumContents",
                                                          in: context) else { return }
        let data = AlbumContents(entity: nameEntity,
                                 insertInto: context)
        data.id = content.id ?? 0
        data.idNameAlbum = album.nameId
        data.addIndex = album.addIndex
        data.duration = content.duration
        data.title = content.title
        data.videoURL = content.videoURL
        data.previewImage = content.previewImage?.pngData() ?? Data()
        delegat.saveContext()
    }
}

//MARK: - ExampData

extension CoreManager {
    func removeExampData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExampData")
        do {
            let data = try? context.fetch(fetchRequest) as? [ExampData]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func getExampData(_ sort: Bool) -> [ExampData] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExampData")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [ExampData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func addExampData(model: ExampModel?,
                      url: String?) {
        guard let nameEntity = NSEntityDescription.entity(forEntityName: "ExampData",
                                                          in: context) else { return }
        let data = ExampData(entity: nameEntity,
                             insertInto: context)
        data.id = Int16(model?.id ?? 0)
        data.title = model?.prompt
        data.videoURL = url
//        delegat.saveContext()
    }
}
