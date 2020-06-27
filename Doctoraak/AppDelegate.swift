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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization aft/Users/hosam/Documents/xcode projects/syphinx/Doctoraak/Doctoraak.xcodeprojer application launch.
         keyboardChanges()
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)

               userDefaults.synchronize()
        MOLH.shared.activate(true)

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = BaseSlidingVC()//UINavigationController(rootViewController:MainLoginsVC(indexx: 0))//DoctorRegisterVC(indexx: 0) )//BaseSlidingVC()//UINavigationController(rootViewController: MainClinicWorkingHoursVCWithoutEditingVC())//BaseSlidingVC()//UINavigationController(rootViewController: SecondHomeLeftMenuCollcetionVC())//MainVerificationVC(indexx: 4, isFromForgetPassw: false, phone: "00000000951", user_id: 22))//BaseSlidingVC()//MainLoginsVC(indexx: 0)//BaseSlidingVC()//UINavigationController(rootViewController:MainLoginsVC(indexx: 0) )//DoctorHomeVC(inde: 0))//MainRegisterVC(indexx: 2))//MainClinicDataVC(indexx: 0, api_token: "VUsVb1nQlIHUfU6ZnTgpOldJcxnMdyoD7Ns3Vo6IUii48erAaGRtjwXiFycQ1qaUqtChFiaF", doctor_id: 4))//MainVerificationVC(indexx: 0, isFromForgetPassw: false, phone: "00000000010", user_id: 75))//DoctorRegisterVC(indexx: 0)))//MainClinicWorkingHoursNotDoctorVC())//MainClinicDataVC(indexx: 0, api_token: "", doctor_id: <#T##Int#>))//MainClinicDataVC(indexx: 0, api_token: "7vqKKNeUzsxA5cKJ943bhdbOpeIYGtx2gp3qo2ueaM", doctor_id: 33))//MainLoginsVC(indexx: 0))//MainVerificationVC(indexx: 1, isFromForgetPassw: false, phone: "00000000651", user_id: 33))//DoctorSecondRegisterVC(indexx: 0, male: "male", photo: #imageLiteral(resourceName: "Group 4142-6"), email: "a", name: "a", mobile: "", passowrd: ""))//MainRegisterVC(indexx: 2))//MainClinicDataVC(indexx: 0))//MainVerificationVC(indexx: 0, isFromForgetPassw: false, phone: "00000000010", user_id: 75))//DoctorRegisterVC(indexx: 0))//MainVerificationVC(indexx: 0, isFromForgetPassw: true, phone: ""))//)MainClinicDataVC(indexx: 0))//MainRegisterVC(indexx: 2))
//        window?.rootViewController = BaseSlidingVC(indexx: 0)
        return true
    }

    func reset() {
             userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)

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
        userDefaults.synchronize()
    }


}

