//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Yoel Lev on 7/3/17.
//  Copyright © 2017 YoelL. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
	
	
	var attendances: [Attendance] = []
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.create()
		
		self.retriveAll()
		
		//self.retrive(by: "studentId")
		
		//self.delete(attendanceAtIndex: 0)
		
		//self.update(atIndex: 1)
		
		self.displayRetrivedAttendances()
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func attendanceStamp() -> (studentId:String,date:Date,location:String,enter:Bool,exit:Bool) {
		
		let studentId = "123456789"
		let currentDate = Date()
		let location = "7303"
		let enterRgion = true
		let exitRegion = false
		
		print("Attendence created succesfuly")
		return (studentId,currentDate,location,enterRgion,exitRegion)
		
	}
	
	func create(){
		
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let stamp = self.attendanceStamp()
		
		let managedContext = appDelegate.persistentContainer.viewContext
		
		let attendance = Attendance(entity: Attendance.entity(), insertInto: managedContext)
		
		
		attendance.studentId = stamp.studentId
		attendance.date = stamp.date as NSDate
		attendance.location = stamp.location
		attendance.enter = stamp.enter
		attendance.exit = stamp.exit
		
		
		do {
			try managedContext.save()
			
			attendances.append(attendance)
		} catch let error as NSError {
			print("Error while trying to save attendance",error)
		}
		
	}
	
	
	
	func retrive(by descriptor:String){
		
		// fetches all attendences from CoreData DB and populates the attendances Array.
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Attendance")
		
		
		// Add Sort Descriptor
		let sortDescriptor = NSSortDescriptor(key: descriptor, ascending: true)
			 fetchRequest.sortDescriptors = [sortDescriptor]
		
		
		do {
			attendances = try managedContext.fetch(fetchRequest) as! [Attendance]
			
			print(attendances.count)
			
		} catch let error as NSError {
			print(error)
		}
		
	}
	
	func update(atIndex:Int){
		
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext
		
		let attendance = attendances[atIndex] as Attendance
		
		attendance.studentId = "123456"
		attendance.date = Date() as NSDate
		attendance.location = "Office"
		attendance.enter = false
		attendance.exit = true
		
		do {
			try managedContext.save()
			
			attendances.append(attendance)
		} catch let error as NSError {
			print("Error while trying to save attendance",error)
		}
		
	}
	
	func delete(attendanceAtIndex:Int){
		
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext
		
		let attendance = attendances[attendanceAtIndex] as Attendance
		
			managedContext.delete(attendance)
		
		do {
			try managedContext.save()
			self.retriveAll()
			
		} catch {
			let saveError = error as NSError
			print(saveError)
		}
		
	}
	
	func retriveAll(){
		
		print("fetching attendences")
		// fetches all attendences from CoreData DB and populates the attendances Array.
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext
		
		do {
			attendances = try managedContext.fetch(Attendance.fetchRequest())
		} catch let error as NSError {
			print(error)
		}
		
	}
	
	func displayRetrivedAttendances(){
		
		for attendence in attendances {
			print("#  Attendence  #")
			print(attendence.value(forKey: "studentId") as! String)
			print(attendence.value(forKey: "date") as! Date)
			print(attendence.value(forKey: "location")as! String)
			print(attendence.value(forKey: "enter") as! Bool)
			print(attendence.value(forKey: "exit") as! Bool)
			print(" ")
		}
		
	}
	


}

