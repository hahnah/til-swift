import RealmSwift

class Person: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // ID を increment して返す
    static func newID(realm: Realm) -> Int {
        if let person = realm.objects(Person.self).sorted(byKeyPath: "id").last {
            return person.id + 1
        } else {
            return 1
        }
    }
    
    // increment された ID を持つ新規 Person オブジェクトを返す
    /*
    static func create(realm: Realm) -> Person {
        let person: Person = Person()
        person.id = newID(realm: realm)
        return person
    }
    */
    
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
