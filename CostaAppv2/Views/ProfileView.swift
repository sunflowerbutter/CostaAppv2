import SwiftUI

struct ProfileView: View {
    @State private var currentDate = Date()
    @State private var isImagePickerPresented = false
    @State private var profileImage: Image?
    @State private var inputImage: UIImage?
    @State private var userName: String = "Example Name"
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var currentDayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // Day name format
        return dateFormatter.string(from: currentDate).lowercased()
    }
    
    var currentSchedule: BellSchedule {
        let allSchedules = getSchedules()
        if currentDayOfWeek == "tuesday" || currentDayOfWeek == "thursday" {
            return allSchedules["Office Hours"]!
        } else {
            return allSchedules["Regular"]!
        }
    }
    
    var currentScheduleTitle: String {
        if currentDayOfWeek == "tuesday" || currentDayOfWeek == "thursday" {
            return "Office Hours Schedule (Tuesday/Thursday with Homeroom)"
        } else {
            return "Regular Schedule (Monday/Wednesday/Friday)"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Profile Section
                ZStack {
                    // Display the gray placeholder only if no image is set.
                    if profileImage == nil {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                    }
                    
                    profileImage?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    // Only display the "+" button if no image is set.
                    if profileImage == nil {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.5))
                            .padding(10)
                    }
                }
                .background(Circle().fill(Color.black.opacity(0.3)))
                .clipShape(Circle())
                .onTapGesture {
                    self.isImagePickerPresented.toggle()
                }
                
                Text("Example Name")
                    .font(.largeTitle)
                    .bold()
                
                // Additional details
                Text("Student ID: 123456")
                Text("Grade: 11")
                Text("Email: example@email.com")
                
                //Spacer(minLength: 350) // Adjust as necessary
                
                // Bell Schedule Display
                VStack(spacing: 15) {
                    Text(currentScheduleTitle)
                        .font(.headline)
                        .padding(.vertical)
                    
                    ForEach(currentSchedule.getArray()) { period in
                        scheduleRow(period: period)
                    }
                }
                .padding(.top, 20)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
            }
            .padding()
        }
        .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    
    
    func loadImage() {
        if let inputImage = inputImage {
            profileImage = Image(uiImage: inputImage)
        }
    }
    
    func currentPeriodDescription() -> String {
        // TODO: Implement the logic for the current period's description.
        // For now, return a placeholder.
        return "Placeholder"
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
            checkTimeLeft(period: period)
            
        }
        .padding(.horizontal, 5)
        //.background(isTimeNow(in: schedule) ? Color.yellow.opacity(0.3) : Color.clear) // Highlight logic
    }
    
    func checkTimeLeft(period: Period) -> Text{
        let startTime = period.startTimeDate
        let endTime = period.endTimeDate
        let currentComponents = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
        let endComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
        let currentMinutes = currentComponents.minute! + (currentComponents.hour!*60)
        let startMinutes = startComponents.minute! + (startComponents.hour!*60)
        let endMinutes = endComponents.minute! + (endComponents.hour!*60)
        
        if currentMinutes>endMinutes{
            return Text("Ended")
                .foregroundColor(.gray)
                .lineLimit(1)
                .frame(width: 90, alignment: .trailing)
                .font(.system(size: 12))
                .minimumScaleFactor(0.5) as! Text
        }
        else if currentMinutes>startMinutes && currentMinutes<endMinutes{
            return Text("Time Left: \(endMinutes-currentMinutes)m")
                .foregroundColor(.red)
                .lineLimit(1)
                .frame(minWidth: 100, alignment: .trailing)
                .font(.system(size: 12)) as! Text
        }
        else{
            return Text("Upcoming")
                .foregroundColor(.gray)
                .lineLimit(1)
                .frame(width: 90, alignment: .trailing)
                .font(.system(size: 12))
                .minimumScaleFactor(0.5) as! Text
        }
    }
     
    
}
#Preview {
    ProfileView()
}
