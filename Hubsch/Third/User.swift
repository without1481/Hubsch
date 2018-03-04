import Foundation

struct User {
    static var userName:String = ""
    static var userEmail:String = ""
    static var userPassword:String = ""
    static var userBirthday:String = ""
    static var userGender:Int = 0
    static var userCountry:Int = 1
    static var userRegion:Int = 1
    static var userSurname:String = ""
    static var userID:String = ""
    
    func preventDefault() {
        User.userName = ""
        User.userEmail = ""
        User.userPassword = ""
        User.userBirthday = ""
        User.userGender = 0
        User.userCountry = 1
        User.userRegion = 1
        User.userSurname = ""
        User.userID = ""
    }
}
