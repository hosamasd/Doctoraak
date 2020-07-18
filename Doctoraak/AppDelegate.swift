//
//  AppDelegate.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MOLH
import GoogleMaps
import GooglePlaces

let googleAPIKEY = "AIzaSyD4ow5PXyqH-gJwe2rzihxG71prgt4NRFQ"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
    
    var window: UIWindow?
    
    
    fileprivate func setDefaults() {
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.set(false, forKey: UserDefaultsConstants.isCachedDriopLists)

        userDefaults.set(true, forKey: UserDefaultsConstants.isLABNotificationChanged)
        userDefaults.set(true, forKey: UserDefaultsConstants.isRADNotificationChanged)
        userDefaults.set(true, forKey: UserDefaultsConstants.isPHYNotificationChanged)
        userDefaults.set(true, forKey: UserDefaultsConstants.isDoctorNotificationChanged)
        userDefaults.set(true, forKey: UserDefaultsConstants.isMedicalCenterNotificationChanged)
        userDefaults.set(false, forKey: UserDefaultsConstants.chhosedCachesWorkingHours)

//        userDefaults.set(false, forKey: UserDefaultsConstants.waitForSMSCodeForSpecific)
//        userDefaults.set(false, forKey: UserDefaultsConstants.isdoctorWaitForAddClinic)
        
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
        
        userDefaults.synchronize()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization aft/Users/hosam/Documents/xcode projects/syphinx/Doctoraak/Doctoraak.xcodeprojer application launch.
               GMSServices.provideAPIKey(googleAPIKEY)
        GMSPlacesClient.provideAPIKey(googleAPIKEY)
        keyboardChanges()
        setDefaults()
        
        
        
        MOLH.shared.activate(true)
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = BaseSlidingVC()//UINavigationController(rootViewController: ChooseLocationVC(isFromUpdate: false))//BaseSlidingVC()//UINavigationController(rootViewController: MainLoginsVC(indexx: 2))//BaseSlidingVC()//HomeLeftMenuVC(index: 3)//WelcomeVC()//BaseSlidingVC()//UINavigationController(rootViewController: TestVCS())//MainLoginsVC(indexx: 3))//DoctorRegisterVC(indexx: 1))//MainClinicWorkingHoursNotDoctorVC(index: 2, isFromUpdateProfile: true, isFromRegister: true))//DoctorClinicDataVC(indexx: 0, api_token: "", doctor_id: 2, isFromProfile: false))//DoctorRegisterVC(indexx: 0) )//BaseSlidingVC()
        return true
    }
    
    func reset() {
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
        userDefaults.set(false, forKey: UserDefaultsConstants.isSpecifiedIndexClincChoosed)

//        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
//        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
//        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
//        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)

        userDefaults.synchronize()
        window?.rootViewController = BaseSlidingVC()
    }
    
    fileprivate func keyboardChanges() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.set(false, forKey: UserDefaultsConstants.isCachedDriopLists)
        userDefaults.set(false, forKey: UserDefaultsConstants.chhosedCachesWorkingHours)
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)

        
        userDefaults.synchronize()
    }
    
    
}

