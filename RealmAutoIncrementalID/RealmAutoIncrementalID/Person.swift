import RealmSwift

class Person: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // returns incremented ID
    static func newID(realm: Realm) -> Int {
        if let person = realm.objects(Person.self).sorted(byKeyPath: "id").last {
            return person.id + 1
        } else {
            return 1
        }
    }
    
    // returns a new dummy object
    // or returns an existing object to be updated as a non-dummy object
    static func create(realm: Realm, asDummy: Bool = false) -> Person {
        if asDummy {
            let newDummyPerson: Person = Person()
            newDummyPerson.id = Person.newID(realm: realm)
            return newDummyPerson
        } else {
            let lastID: Int = (realm.objects(Person.self).sorted(byKeyPath: "id").last?.id)!
            let dummyPerson: Person = realm.object(ofType: Person.self, forPrimaryKey: lastID)!
            let newDummyPerson: Person = Person.create(realm: realm, asDummy: true)
            try! realm.write {
                realm.add(newDummyPerson)
            }
            return dummyPerson
        }
    }
    
}
