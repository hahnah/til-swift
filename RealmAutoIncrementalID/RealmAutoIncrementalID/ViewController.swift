import RealmSwift

class ViewController: UIViewController {
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm: Realm = try! Realm()
        
        // delete all
        try! realm.write {
            realm.deleteAll()
        }
        
        // dummy person
        let dummyPerson: Person = Person.create(realm: realm, asDummy: true)
        try! realm.write {
            realm.add(dummyPerson)
        }
        self.printPeople(realm: realm)
        
        // first person
        let firstPerson: Person = Person.create(realm: realm)
        try! realm.write {
            firstPerson.name = "Alice"
        }
        self.printPeople(realm: realm)
        
        // delete first person
        try! realm.write {
            realm.delete(firstPerson)
        }
        self.printPeople(realm: realm)
        
        // second person
        let secondPerson: Person = Person.create(realm: realm)
        try! realm.write {
            secondPerson.name = "Bob"
        }
        self.printPeople(realm: realm)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func printPeople(realm: Realm) {
        let people: Array<Person> = Array(realm.objects(Person.self).sorted(byKeyPath: "id"))
        people.forEach { (person: Person) in
            print(person.id, person.name)
        }
        print("---------------")
    }
    
}
