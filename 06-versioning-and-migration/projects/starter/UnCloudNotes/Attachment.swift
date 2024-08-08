import Foundation
import UIKit
import CoreData

class Attachment: NSManagedObject {
  @NSManaged var dateCreated: Date
  @NSManaged var image: UIImage?
  @NSManaged var note: Note?
}
