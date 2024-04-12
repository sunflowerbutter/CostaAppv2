import SwiftUI

struct ProfileView: View {
    @ObservedObject var uservm = UserViewModel()
    @ObservedObject var vm = ScheduleViewModel()
    
    @State private var profileImage: Image?
    @State private var isImagePickerPresented = false
    @State private var inputImage: UIImage?
    @State private var userName: String = "Example Name"
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 15) {
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
            
            //Spacer(minLength: 5)
            // Adjust as necessary
                
            /*
            // Bell Schedule Display
            VStack(spacing: 10) {
                Text(vm.scheduleTitle)
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
            */
            List(vm.currentSchedule){ period in
                ScheduleRow(vm: vm, period: period)
            }
                .onAppear(){
                    vm.fetchData()
                }
            
        }
        
    }
    
    func currentPeriodDescription() -> String {
        // TODO: Implement the logic for the current period's description.
        // For now, return a placeholder.
        return "Placeholder"
    }

    
    func scheduleRow(period: Period) -> some View {
        HStack {
            Text(period.id)
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
            if vm.checkTimeLeft(period:period).contains("Time Left"){
                Text(vm.checkTimeLeft(period:period))
                        .foregroundColor(.red)
                        .lineLimit(1)
                        .frame(minWidth: 100, alignment: .trailing)
                        .font(.system(size: 12))
                }
                else{
                    Text(vm.checkTimeLeft(period:period))
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
    func loadImage() {
        if let inputImage = inputImage {
            profileImage = Image(uiImage: inputImage)
        }
    }
     
    
}


struct ScheduleRow: View{
    @State var vm: ScheduleViewModel
    @State var period: Period
    
    var body: some View{
        HStack{
            Text(period.id)
            Text(period.startTime)
            Text(period.endTime)
            Text(vm.checkTimeLeft(period:period))
        }
        /* UI that for some reason doesn't work
        HStack {
            Text(period.id)
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
            
            if vm.checkTimeLeft(period:period).contains("Time Left"){
                Text(vm.checkTimeLeft(period:period))
                        .foregroundColor(.red)
                        .lineLimit(1)
                        .frame(minWidth: 100, alignment: .trailing)
                        .font(.system(size: 12))
                }
                else{
                    Text(vm.checkTimeLeft(period:period))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .frame(width: 90, alignment: .trailing)
                        .font(.system(size: 12))
                        .minimumScaleFactor(0.5)
                }
            }
                .padding(.horizontal, 10)
                //.background(isTimeNow(in: schedule) ? Color.yellow.opacity(0.3) : Color.clear) // Highlight logic*/
    }
}
#Preview {
    ProfileView()
}
