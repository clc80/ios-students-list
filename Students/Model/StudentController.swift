//
//  StudentController.swift
//  Students
//
//  Created by Ben Gohlke on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class StudentController {
    
    // MARK: - Private Properties
    private var students: [Student] = []
    
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "students", ofType: "json") else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    //MARK: - Public Functions
    func loadFromPersistentStore(completion: @escaping ([Student]?, Error?) -> Void) {
        let bgQueue = DispatchQueue(label: "studentQueue",attributes: .concurrent)
        
        //How to put a job on this thread
        bgQueue.async {
            guard let url = self.persistentFileURL else { return }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.students = try decoder.decode([Student].self, from: data)
                completion(self.students, nil)
            } catch {
                print("Error loading student data: \(error)")
                completion(nil, error)
            }
            
        }
    } // end of func loadFromPersistentStore
    
}
