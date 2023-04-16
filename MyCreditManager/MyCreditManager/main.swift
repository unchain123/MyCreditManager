//
//  main.swift
//  MyCreditManager
//
//  Created by unchain on 2023/04/16.
//

import Foundation

final class MyCreditManager {

    private var studentList: [String] = []
    private var studentSubjectGrade: [String: [String : String]] = [:]
    private var gradeList: [Double] = []

    func startCreditManager() {
        chooseTheMenuMessage()
        while let input = readLine(), input != "X" {
            switch  input {
            case "1":
                addStudent()
                chooseTheMenuMessage()
            case "2":
                deleteStudent()
                chooseTheMenuMessage()
            case "3":
                addOrChangeGrade()
                chooseTheMenuMessage()
            case "4":
                deleteGrade()
                chooseTheMenuMessage()
            case "5":
                seeAverageGrade()
                chooseTheMenuMessage()
            default:
                print("입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            }
        }
        print("프로그램을 종료합니다...")
    }

    private func chooseTheMenuMessage() {
        print("""
원하는 기능을 입력하세요
1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
""")
    }

    private func addStudent() {
        print("추가할 학생의 이름을 입력해주세요")
        guard let studentName = readLine(), !studentName.isEmpty else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }

        guard !studentList.contains(studentName) else {
            print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            return
        }
        studentList.append(studentName)
        print("\(studentName) 학생을 추가했습니다.")
    }

    private func deleteStudent() {
        print("삭제할 학생의 이름을 입력해주세요")
        guard let studentName = readLine() else { return }

        guard studentList.contains(studentName) else {
            print("\(studentName) 학생을 찾지 못했습니다.")
            return
        }

        if let index = studentList.firstIndex(of: studentName) {
            studentList.remove(at: index)
            print("\(studentName) 학생을 삭제하였습니다.")
        }
    }

    private func addOrChangeGrade() {
        print(
    """
    성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
    입력예) Mickey Swift A+
    만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
    """
        )
        guard let studentGrade = readLine()?.split(separator: " "),
              studentGrade.count == 3,
              !studentGrade.isEmpty
        else {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            return
        }

        let name = String(studentGrade[0])
        let subject = String(studentGrade[1])
        let grade = String(studentGrade[2])

        guard studentList.contains(name) else {
            print("\(name)학생은 명단에 없습니다. 학생추가를 먼저 진행해주세요")
            return
        }

        guard (GradeTable(rawValue: grade) != nil) else {
            print("성적입력을 잘못했습니다. 다시 확인해 주세요")
            return
        }


        guard var student = studentSubjectGrade[name] else {
            studentSubjectGrade[name] = [subject : grade]
            print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
            return
        }

        student[subject] = grade
        studentSubjectGrade[name] = student
        print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
    }

    private func deleteGrade() {
        print(
            """
              성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
                입력예) Mickey Swift
            """
        )
        guard let deletedGrade = readLine()?.split(separator: " "),
              deletedGrade.count == 2,
              !deletedGrade.isEmpty else
        {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }

        let name = String(deletedGrade[0])
        let subject = String(deletedGrade[1])

        guard studentList.contains(name) else {
            print("\(name) 학생을 찾지 못했습니다.")
            return
        }

        guard var student = studentSubjectGrade[name] else { return }
        student[subject] = nil
        print("\(name) 학생의 \(subject) 과목의 성적이 삭제 되었습니다.")
    }

    private func seeAverageGrade() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        guard let studentName = readLine(),
              !studentName.isEmpty
        else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }

        guard studentList.contains(studentName) else {
            print("\(studentName) 학생을 찾지 못했습니다.")
            return
        }

        guard let grade = studentSubjectGrade[studentName] else {
            print("이름 못찾음 오류")
            return
        }

        grade.forEach { subject, grade in
            gradeList.append(GradeTable(rawValue: grade)!.point)
            print("\(subject): \(grade)")
        }
        let avaGrade = gradeList.reduce(0, +) / Double(grade.count)
        print("평점 : \(avaGrade)")
    }
}

let manager = MyCreditManager()
manager.startCreditManager()
