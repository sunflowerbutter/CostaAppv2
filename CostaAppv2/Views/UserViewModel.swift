//
//  UserViewModel.swift
//  CostaAppv2
//
//  Created by HCD Student on 4/8/24.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var profileImage: Image?
    @Published var userName: String = "Example Name"

    private var db = Firestore.firestore()
    
    func loadImage(inputImage : UIImage?) {
        if let inputImage = inputImage {
            profileImage = Image(uiImage: inputImage)
        }
    }
}

class ScheduleViewModel: ObservableObject {
    @Published var schedules = [BellSchedule]()
    @Published var currentSchedule = [Period]()
    @Published var scheduleTitle: String = ""
    @Published var currentDate = Date()
    
    private var db = Firestore.firestore()
    
    
    func fetchData(){
        var currentDayOfWeek: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // Day name format
            return dateFormatter.string(from: currentDate).lowercased()
        }
        if currentDayOfWeek == "tuesday" || currentDayOfWeek == "thursday" {
            let schedules = db.collection("Schedules")
            schedules.whereField("title", isEqualTo: "Office Hours").getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        let title = document.documentID
                        let periodmap = data["Periods"] as? [[String:String]] ?? [["":""]]
                        var periods = [Period]()
                        for period in periodmap{
                            let description = period["Description"] ?? ""
                            let startTime = period["Start Time"] ?? ""
                            let endTime = period["End Time"] ?? ""
                            let length = period["Length"] ?? ""

                            let period = Period(id: description, startTime: startTime, endTime: endTime, length: length)
                            periods.append(period)
                        }
                        let schedule = BellSchedule(id: title, periods: periods)
                        self.currentSchedule = schedule.getArray()
                    }
                }
            }
        }
        else{
            let schedules = db.collection("Schedules")
            schedules.whereField("title", isEqualTo: "Regular").getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        let title = document.documentID
                        let periodmap = data["Periods"] as? [[String:String]] ?? [["":""]]
                        var periods = [Period]()
                        for period in periodmap{
                            let description = period["Description"] ?? ""
                            let startTime = period["Start Time"] ?? ""
                            let endTime = period["End Time"] ?? ""
                            let length = period["Length"] ?? ""

                            let period = Period(id: description, startTime: startTime, endTime: endTime, length: length)
                            periods.append(period)
                        }
                        let schedule = BellSchedule(id: title, periods: periods)
                        self.currentSchedule = schedule.getArray()
                    }
                }
            }
        }
    }
    /*
    func fetchData(){
        db.collection("Schedules").getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let title = document.documentID
                    let periodmap = data["Periods"] as? [[String:String]] ?? [["":""]]
                    var periods = [Period]()
                    for period in periodmap{
                        let description = period["Description"] ?? ""
                        let startTime = period["Start Time"] ?? ""
                        let endTime = period["End Time"] ?? ""
                        let length = period["Length"] ?? ""

                        let period = Period(id: description, startTime: startTime, endTime: endTime, length: length)
                        periods.append(period)
                    }
                    
                    let schedule = BellSchedule(title: title, periods: periods)
                    self.schedules.append(schedule)
                }
            }
        }
    }
    */
    /*
    func getCurrentSchedule(){
        /*var currentDayOfWeek: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // Day name format
            return dateFormatter.string(from: currentDate).lowercased()
        }
        if currentDayOfWeek == "tuesday" || currentDayOfWeek == "thursday" {
            for schedule in schedules{
                if schedule.title == "Office Hours"{
                    currentSchedule = schedule
                    scheduleTitle = "Office Hours Schedule\n(Tuesday/Thursday with Homeroom)"
                }
            }
        }
        else{
            for schedule in schedules{
                if schedule.title == "Regular"{
                    currentSchedule = schedule
                    scheduleTitle = "Regular Schedule (Monday/Wednesday/Friday)"
                }
            }
        }*/
        currentSchedule = schedules[0].getArray()
    }*/
    
    func checkTimeLeft(period: Period) -> String{
        let startTime = period.startTimeDate
        let endTime = period.endTimeDate
        let currentComponents = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
        let endComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
        let currentMinutes = currentComponents.minute! + (currentComponents.hour!*60)
        let startMinutes = startComponents.minute! + (startComponents.hour!*60)
        let endMinutes = endComponents.minute! + (endComponents.hour!*60)
        
        if currentMinutes>endMinutes{
            return "Ended"
        }
        else if currentMinutes>startMinutes && currentMinutes<endMinutes{
            return "Time Left: \(endMinutes-currentMinutes)m"
        }
        else{
            return "Upcoming"
        }
    }
    
    func currentPeriodDescription() -> String {
        // TODO: Implement the logic for the current period's description.
        // For now, return a placeholder.
        return "Placeholder"
    }


}

/*
struct ProfileView: View {
    @ObservedObject var uservm = UserViewModel()
    @ObservedObject var vm = ScheduleViewModel()
    
    @State private var isImagePickerPresented = false
    @State private var inputImage: UIImage?
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Profile Section
                ZStack {
                    // Display the gray placeholder only if no image is set.
                    if uservm.profileImage == nil {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                    }
                    
                    uservm.profileImage?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    // Only display the "+" button if no image is set.
                    if uservm.profileImage == nil {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.5))
                            .padding(10)
                    }
                }
                .background(Circle().fill(Color.black.opacity(0.3)))
                .clipShape(Circle())
                .padding(.top, 20)
                .onTapGesture {
                    self.isImagePickerPresented.toggle()
                }
                
                Text("Example Name")
                    .font(.title)
                    .bold()
                
                // Additional details
                Text("Student ID: 123456")
                Text("Grade: 11")
                //Text("Email: example@email.com")
                
                Spacer(minLength: 5) // Adjust as necessary
                
                // Bell Schedule Display
                VStack(spacing: 10) {
                    Text(vm.currentScheduleTitle)
                        .font(.title2)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    ForEach(vm.currentSchedule.getArray()) { period in
                        scheduleRow(period: period)
                    }
                }
                .padding()
                .background(Color.white)
                //.cornerRadius(10)
                //.shadow(radius: 5)
                
            }
            
        }
        //figure out
        .sheet(isPresented: $isImagePickerPresented, onDismiss: $uservm.loadImage(inputImage)) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func scheduleRow(period: Period) -> some View {
        HStack {
            Text(period.description)
                .lineLimit(1)
                .frame(width: 80, alignment: .leading)
                .font(.system(size: 12))
                        
            HStack {
                Text(period.startTime)
                    .lineLimit(1)
                    .frame(width: 60, alignment: .trailing)
                    .font(.system(size: 12))
                Text("-")
                    .lineLimit(1)
                    .frame(width: 10, alignment: .center)
                    .font(.system(size: 12))
                Text(period.endTime)
                    .lineLimit(1)
                    .frame(width: 60, alignment: .leading)
                    .font(.system(size: 12))
                }
                if checkTimeLeft(period:period).contains("Time Left"){
                    Text(checkTimeLeft(period:period))
                        .foregroundColor(.red)
                        .lineLimit(1)
                        .frame(minWidth: 100, alignment: .trailing)
                        .font(.system(size: 12))
                }
                else{
                    Text(checkTimeLeft(period:period))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .frame(width: 90, alignment: .trailing)
                        .font(.system(size: 12))
                        .minimumScaleFactor(0.5)
                }
            }
                .padding(.horizontal, 10)
                //.background(isTimeNow(in: schedule) ? Color.yellow.opacity(0.3) : Color.clear) // Highlight logic
    }
    
    func checkTimeLeft(period: Period) -> String{
        let startTime = period.startTimeDate
        let endTime = period.endTimeDate
        let currentComponents = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
        let endComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
        let currentMinutes = currentComponents.minute! + (currentComponents.hour!*60)
        let startMinutes = startComponents.minute! + (startComponents.hour!*60)
        let endMinutes = endComponents.minute! + (endComponents.hour!*60)
        
        if currentMinutes>endMinutes{
            return "Ended"
        }
        else if currentMinutes>startMinutes && currentMinutes<endMinutes{
            return "Time Left: \(endMinutes-currentMinutes)m"
        }
        else{
            return "Upcoming"
        }
    }
     
    
}*/
/*
#Preview {
    ProfileView()
}
*/
