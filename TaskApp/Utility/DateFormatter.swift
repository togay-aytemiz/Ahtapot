//
//  Constant.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.04.2021.
//

import SwiftUI
import Foundation

// MARK: FORMATTER

let dateAndTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()


let ShortDateAndTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .short
    return formatter
}()


let LongDateFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    return formatter
}()


let shortDateFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

let miniDateAndTimeFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE | dd MMM"
    return formatter
}()

let miniDateFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE | dd MMM"
    return formatter
}()


let justDay: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return formatter
}()



/*
 
 Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
 09/12/2018                        --> MM/dd/yyyy
 09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
 Sep 12, 2:11 PM                   --> MMM d, h:mm a
 September 2018                    --> MMMM yyyy
 Sep 12, 2018                      --> MMM d, yyyy
 Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
 2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
 12.09.18                          --> dd.MM.yy
 10:41:02.112                      --> HH:mm:ss.SSS
 
 
 */



// MARK: OTHER

// costom tab switcher'da, tab genişliğin bulabilmek için kullanıldı.
extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}



