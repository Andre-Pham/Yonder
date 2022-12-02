//
//  DummyClasses.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

/// This file serves two purposes.
/// 1. This provides documentation on how the `Storable` protocol should be implemented within classes.
/// 2. It provides classes to run DataObject unit tests on.
///
/// Execution example:
/// ``` // 1. Convert to raw string
///     let studentDataObject = self.student.toDataObject()
///     let studentSerialised = studentDataObject.toRawString()
///     // 2. Convert raw string back into student
///     let reinstantiatedStudent = DataObject(rawString: studentSerialised).restore(Student.self)
/// ```

class Person: Storable {
    
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var age: Int
    public let id = UUID()
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    required init(dataObject: DataObject) {
        self.firstName = dataObject.get("firstName")
        self.lastName = dataObject.get("lastName")
        self.age = dataObject.get("age")
    }
    
    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: "firstName", value: self.firstName)
            .add(key: "lastName", value: self.lastName)
            .add(key: "age", value: self.age)
    }
    
}

class Student: Person {
    
    private(set) var homework = [Homework]()
    private(set) var depressionLevel: Int
    private(set) var teacher: Teacher
    private(set) var favouriteColours: [String]
    
    init(firstName: String, lastName: String, age: Int, depressionLevel: Int, favouriteColours: [String]) {
        self.depressionLevel = depressionLevel
        self.teacher = Teacher(firstName: "Mr", lastName: "Math", age: 500)
        self.favouriteColours = favouriteColours
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    
    func addHomework(_ homework: Homework) {
        self.homework.append(homework)
    }
    
    required init(dataObject: DataObject) {
        self.depressionLevel = dataObject.get("depressionLevel")
        self.homework = dataObject.getObjectArray("homework", type: Homework.self)
        self.teacher = dataObject.getObject("teacher", type: Teacher.self)
        self.favouriteColours = dataObject.get("favouriteColours")
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: "depressionLevel", value: self.depressionLevel)
            .add(key: "homework", value: self.homework)
            .add(key: "teacher", value: self.teacher)
            .add(key: "favouriteColours", value: self.favouriteColours)
    }
    
}

class Teacher: Person {
    
    private(set) var salary = 10000
    
    override init(firstName: String, lastName: String, age: Int) {
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    
    required init(dataObject: DataObject) {
        self.salary = dataObject.get("salary")
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: "salary", value: self.salary)
    }
    
}

class Homework: Storable {
    
    public let answers: String
    public var grade: Int?
    
    init(answers: String, grade: Int?) {
        self.answers = answers
        self.grade = grade
    }
    
    required init(dataObject: DataObject) {
        self.answers = dataObject.get("answers")
        self.grade = dataObject.get("grade")
    }
    
    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: "answers", value: self.answers)
            .add(key: "grade", value: self.grade)
    }
    
}
