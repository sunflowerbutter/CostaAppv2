import SwiftUI

struct ProfileView: View {
    var bellSchedules: [BellSchedule] = [
        BellSchedule(description: "Period 0", startTime: "7:30 AM", endTime: "8:25 AM", length: "55 min"),
        BellSchedule(description: "Period 1", startTime: "8:30 AM", endTime: "9:25 AM", length: "55 min"),
        BellSchedule(description: "Period 2", startTime: "9:31 AM", endTime: "10:32 AM", length: "61 min"),
        BellSchedule(description: "Break", startTime: "10:32 AM", endTime: "10:45 AM", length: "13 min"),
        BellSchedule(description: "Period 3", startTime: "10:51 AM", endTime: "11:46 AM", length: "55 min"),
        BellSchedule(description: "Period 4", startTime: "11:52 AM", endTime: "12:47 PM", length: "55 min"),
        BellSchedule(description: "Lunch", startTime: "12:47 PM", endTime: "1:17 PM", length: "30 min"),
        BellSchedule(description: "Period 5", startTime: "1:23 PM", endTime: "2:18 PM", length: "55 min"),
        BellSchedule(description: "Period 6", startTime: "2:24 PM", endTime: "3:19 PM", length: "55 min")
    ]
    var officeHoursSchedules: [BellSchedule] = [
        BellSchedule(description: "Period 0", startTime: "7:30 AM", endTime: "8:25 AM", length: "55 min"),
        BellSchedule(description: "Period 1", startTime: "8:30 AM", endTime: "9:18 AM", length: "48 min"),
        BellSchedule(description: "Period 2 HR", startTime: "9:24 AM", endTime: "10:23 AM", length: "48 min"),
        BellSchedule(description: "Office Hours", startTime: "10:23 AM", endTime: "11:13 AM", length: "50 min"),
        BellSchedule(description: "Period 3", startTime: "11:19 AM", endTime: "12:07 PM", length: "48 min"),
        BellSchedule(description: "Period 4", startTime: "12:13 PM", endTime: "1:01 PM", length: "48 min"),
        BellSchedule(description: "Lunch", startTime: "1:02 PM", endTime: "1:31 PM", length: "30 min"),
        BellSchedule(description: "Period 5", startTime: "1:37 PM", endTime: "2:25 PM", length: "48 min"),
        BellSchedule(description: "Period 6", startTime: "2:31 PM", endTime: "3:19 PM", length: "48 min")
    ]
    
    
    // katy perry
    
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
    
    var currentSchedule: [BellSchedule] {
        if currentDayOfWeek == "tuesday" || currentDayOfWeek == "thursday" {
            return officeHoursSchedules
        } else {
            return bellSchedules
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
                
                Spacer(minLength: 350) // Adjust as necessary
                
                // Bell Schedule Display
                VStack(spacing: 15) {
                    Text(currentScheduleTitle)
                        .font(.headline)
                        .padding(.vertical)
                    
                    ForEach(currentSchedule) { schedule in
                        scheduleRow(schedule: schedule)
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


    
            
            func scheduleRow(schedule: BellSchedule) -> some View {
                HStack {
                    Text(schedule.description)
                        .lineLimit(1)
                        .frame(width: 80, alignment: .leading)
                        .font(.system(size: 12))
                    
                    HStack {
                        Text(schedule.startTime)
                            .lineLimit(1)
                            .frame(width: 60, alignment: .trailing)
                            .font(.system(size: 12))
                        Text("-")
                            .lineLimit(1)
                            .frame(width: 10, alignment: .center)
                            .font(.system(size: 12))
                        Text(schedule.endTime)
                            .lineLimit(1)
                            .frame(width: 60, alignment: .leading)
                            .font(.system(size: 12))
                    }
                    
                    if isTimeNow(in: schedule) {
                        Text("Time Left: \(timeLeft(for: schedule))")
                            .foregroundColor(.red)
                            .lineLimit(1)
                            .frame(minWidth: 100, alignment: .trailing)
                            .font(.system(size: 12))
                    } else {
                        Text("Time Left: N/A")
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .frame(width: 90, alignment: .trailing)
                            .font(.system(size: 12))
                            .minimumScaleFactor(0.5)

                    }
                }
                .padding(.horizontal, 5)
                .background(isTimeNow(in: schedule) ? Color.yellow.opacity(0.3) : Color.clear) // Highlight logic
            }
            
            
            
    func isTimeNow(in schedule: BellSchedule) -> Bool {
        guard let startTime = schedule.startTimeDate,
              let endTime = schedule.endTimeDate else {
            return false
        }
        
        let currentComponents = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
        let endComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
        
        if let currentHour = currentComponents.hour, let currentMinute = currentComponents.minute,
           let startHour = startComponents.hour, let startMinute = startComponents.minute,
           let endHour = endComponents.hour, let endMinute = endComponents.minute {
            if currentHour == startHour {
                return currentMinute >= startMinute
            } else if currentHour == endHour {
                return currentMinute <= endMinute
            } else {
                return currentHour > startHour && currentHour < endHour
            }
        }
        
        return false
    }


    func timeLeft(for schedule: BellSchedule) -> String {
        guard let endTime = schedule.endTimeDate else {
            return "N/A"
        }
        
        if currentDate > endTime {
            return "Ended"
        } else if currentDate < schedule.startTimeDate! {
            return "Upcoming"
        } else {
            let components = Calendar.current.dateComponents([.minute], from: currentDate, to: endTime)
            return "\(components.minute ?? 0)m"
        }
    }




    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        @Environment(\.presentationMode) var presentationMode

        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            var parent: ImagePicker

            init(_ parent: ImagePicker) {
                self.parent = parent
            }

            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }
                parent.presentationMode.wrappedValue.dismiss()
            }
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }

        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        }
    }


    
        
        
        
        
        struct BellSchedule: Identifiable {
            var id = UUID()
            var description: String
            var startTime: String
            var endTime: String
            var length: String
            
            var startTimeDate: Date? {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let date = dateFormatter.date(from: startTime)
                return date
            }
            
            var endTimeDate: Date? {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let date = dateFormatter.date(from: endTime)
                return date
            }
            
            
           
            }
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
        }
}
