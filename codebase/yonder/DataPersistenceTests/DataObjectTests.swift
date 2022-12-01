//
//  DataObjectTests.swift
//  DataPersistenceTests
//
//  Created by Andre Pham on 6/11/2022.
//

import XCTest
@testable import yonder

class DataObjectTests: XCTestCase {
    
    let student = Student(firstName: "Andre", lastName: "Pham", age: 21, depressionLevel: 50)
    
    override func setUp() async throws {
        self.student.addHomework(Homework(answers: "2x + 5", grade: nil))
        self.student.addHomework(Homework(answers: "Something smart", grade: 99))
    }
    
    func testSerialisation() throws {
        // 1. Convert to raw string
        let studentDataObject = self.student.toDataObject()
        let studentSerialised = studentDataObject.toRawString()
        // 2. Convert raw string back into student
        let reinstantiatedStudent = DataObject(rawString: studentSerialised).restore(Student.self)
        // 3. Convert new student back into a string again
        let reinstantiatedStudentSerialised = reinstantiatedStudent.toDataObject().toRawString()
        
        // View raw strings (note attributes are unordered because dictionaries are unordered)
        print("============================== INITIAL SERIALISATION ==============================")
        print(studentSerialised)
        print("============================== RE-SERIALISATION ===================================")
        print(reinstantiatedStudentSerialised)
        print("============================== END ================================================")
        
        // Make sure all data is saved and restored
        XCTAssertEqual(self.student.firstName, reinstantiatedStudent.firstName)
        XCTAssertEqual(self.student.lastName, reinstantiatedStudent.lastName)
        XCTAssertEqual(self.student.depressionLevel, reinstantiatedStudent.depressionLevel)
        XCTAssertEqual(self.student.age, reinstantiatedStudent.age)
        XCTAssertEqual(self.student.teacher.firstName, reinstantiatedStudent.teacher.firstName)
        XCTAssertEqual(self.student.teacher.lastName, reinstantiatedStudent.teacher.lastName)
        XCTAssertEqual(self.student.teacher.age, reinstantiatedStudent.teacher.age)
        XCTAssertEqual(self.student.teacher.salary, reinstantiatedStudent.teacher.salary)
        XCTAssertEqual(self.student.homework.count, reinstantiatedStudent.homework.count)
        XCTAssertEqual(self.student.homework.first?.answers, reinstantiatedStudent.homework.first?.answers)
        XCTAssertEqual(self.student.homework.last?.answers, reinstantiatedStudent.homework.last?.answers)
        XCTAssertEqual(self.student.homework.first?.grade, reinstantiatedStudent.homework.first?.grade)
        XCTAssertEqual(self.student.homework.last?.grade, reinstantiatedStudent.homework.last?.grade)
    }

}
