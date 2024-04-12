//
//  BellSchedule.swift
//  Costa App
//
//  Created by HCD Student on 1/9/24.
//

import Foundation

struct Period: Identifiable {
    var id: String
    var startTime: String
    var endTime: String
    var length: String
    
    var startTimeDate: Date { //used to be Date?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: startTime)
        return date! //note i am force unwrapping (so change all constants to guard let if i change back)
    }
    
    var endTimeDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: endTime)
        return date!
    }
}

class BellSchedule: Identifiable {
    var id: String
    var periods: [Period] = []
    
    init(id: String, periods: [Period]){
        self.id = id
        self.periods = periods
    }
    
    init(){
        self.id = "default"
        self.periods = [Period(id: "Period 0", startTime: "7:30 AM", endTime: "8:25 AM", length: "55 min")]
    }
    
    func getArray()->[Period]{
        return periods
    }
}

//dict with all schedules for 2023 - 2024
func getSchedules()->[String: BellSchedule]{
    var schedules = [String: BellSchedule]()
    schedules["Regular"] = BellSchedule(id:"Regular", periods:
                                        [Period(id: "Period 0", startTime: "7:30 AM", endTime: "8:25 AM", length: "55 min"),
                                         Period(id: "Period 1", startTime: "8:30 AM", endTime: "9:25 AM", length: "55 min"),
                                         Period(id: "Period 2", startTime: "9:31 AM", endTime: "10:32 AM", length: "61 min"),
                                         Period(id: "Break", startTime: "10:32 AM", endTime: "10:45 AM", length: "13 min"),
                                         Period(id: "Period 3", startTime: "10:51 AM", endTime: "11:46 AM", length: "55 min"),
                                         Period(id: "Period 4", startTime: "11:52 AM", endTime: "12:47 PM", length: "55 min"),
                                         Period(id: "Lunch", startTime: "12:47 PM", endTime: "1:17 PM", length: "30 min"),
                                         Period(id: "Period 5", startTime: "1:23 PM", endTime: "2:18 PM", length: "55 min"),
                                         Period(id: "Period 6", startTime: "2:24 PM", endTime: "3:19 PM", length: "55 min")])
    //tuesdays, thursdays
    schedules["Office Hours"] = BellSchedule(id: "OfficeHours", periods:
                                             [Period(id: "Period 0", startTime: "7:30 AM", endTime: "8:25 AM", length: "55 min"),
                                              Period(id: "Period 1", startTime: "8:30 AM", endTime: "9:18 AM", length: "48 min"),
                                              Period(id: "Period 2 HR", startTime: "9:24 AM", endTime: "10:23 AM", length: "48 min"),
                                              Period(id: "Office Hours", startTime: "10:23 AM", endTime: "11:13 AM", length: "50 min"),
                                              Period(id: "Period 3", startTime: "11:19 AM", endTime: "12:07 PM", length: "48 min"),
                                              Period(id: "Period 4", startTime: "12:13 PM", endTime: "1:01 PM", length: "40 min"),
                                              Period(id: "Lunch", startTime: "1:02 PM", endTime: "1:31 PM", length: "30 min"),
                                              Period(id: "Period 5", startTime: "1:37 PM", endTime: "2:25 PM", length: "48 min"),
                                              Period(id: "Period 6", startTime: "2:31 PM", endTime: "3:19 PM", length: "48 min")])
    /*
     September 1
     December 19
     June 10
     */
    schedules["Minimum Day"] = BellSchedule(id: "Minimum Day", periods:
                                            [Period(id: "Period 0", startTime: "7:30 AM", endTime: "8:25 AM", length: "55 min"),
                                             Period(id: "Period 1", startTime: "8:30 AM", endTime: "9:06 AM", length: "36 min"),
                                             Period(id: "Period 2", startTime: "9:12 AM", endTime: "9:50 AM", length: "38 min"),
                                             Period(id: "Period 3", startTime: "9:56 AM", endTime: "10:32 AM", length: "36 min"),
                                             Period(id: "Break", startTime: "10:32 AM", endTime: "10:45 AM", length: "13 min"),
                                             Period(id: "Period 4", startTime: "10:51 AM", endTime: "11:27 AM", length: "36 min"),
                                             Period(id: "Period 5", startTime: "11:33 AM", endTime: "12:09 PM", length: "36 min"),
                                             Period(id: "Period 6", startTime: "12:15 PM", endTime: "12:51 PM", length: "36 min")])
    /*
     9/07, 10/03, 11/16, 12/12, 1/18, 2/13, 3/07, 4/09, 5/09
     *Period 0 does not meet
     */
    schedules["Late Start"] = BellSchedule(id: "Late Start", periods:
                                            [Period(id: "Period 1", startTime: "9:47 AM", endTime: "10:27 AM", length: "40 min"),
                                             Period(id: "Period 2", startTime: "10:33 AM", endTime: "11:13 AM", length: "40 min"),
                                             Period(id: "Office Hours", startTime: "11:13 AM", endTime: "11:43 AM", length: "30 min"),
                                             Period(id: "Period 3", startTime: "11:49 AM", endTime: "12:29 AM", length: "40 min"),
                                             Period(id: "Lunch", startTime: "12:29 AM", endTime: "12:59 PM", length: "30 min"),
                                             Period(id: "Period 4", startTime: "1:05 PM", endTime: "1:45 PM", length: "40 min"),
                                             Period(id: "Period 5", startTime: "1:51 PM", endTime: "2:31 PM", length: "40 min"),
                                             Period(id: "Period 6", startTime: "2:37 PM", endTime: "3:17 PM", length: "40 min")])
    /*
     October 24 Homecoming
     February 01 Winter
     March 21 Spring
     */
    schedules["Pep Rally"] = BellSchedule(id: "Pep Rally", periods:
                                        [Period(id: "Period 0", startTime: "7:30 AM", endTime: "8:25 AM", length: "55 min"),
                                         Period(id: "Period 1", startTime: "8:30 AM", endTime: "9:15 AM", length: "45 min"),
                                         Period(id: "Period 2", startTime: "9:21 AM", endTime: "10:06 AM", length: "45 min"),
                                         Period(id: "Rally", startTime: "10:12 AM", endTime: "10:42 AM", length: "30 min"),
                                         Period(id: "Office Hours", startTime: "10:42 AM", endTime: "11:25 AM", length: "43 min"),
                                         Period(id: "Period 3", startTime: "11:31 AM", endTime: "12:16 PM", length: "45 min"),
                                         Period(id: "Period 4", startTime: "12:22 PM", endTime: "1:07 PM", length: "45 min"),
                                         Period(id: "Lunch", startTime: "1:07 PM", endTime: "1:37 PM", length: "30 min"),
                                         Period(id: "Period 5", startTime: "1:43 PM", endTime: "2:28 PM", length: "45 min"),
                                         Period(id: "Period 6", startTime: "2:34 PM", endTime: "3:19 PM", length: "45 min")])
    /*
    December 20-22
    June 11-13
     */
    schedules["Finals"] = BellSchedule(id: "Finals", periods:
                                        [Period(id: "First Exam", startTime: "8:30 AM", endTime: "10:32 AM", length: "122 min"),
                                         Period(id: "Break", startTime: "10:32 AM", endTime: "10:44 AM", length: "12 min"),
                                         Period(id: "Second Exam", startTime: "10:50 AM", endTime: "12:52 AM", length: "122 min"),
                                         ])
    return schedules
}

