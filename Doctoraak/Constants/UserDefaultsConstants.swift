//
//  UserDefaultsConstants.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class UserDefaultsConstants {
    
    static let isWelcomeVCAppear="isWelcomeVCAppear"
    static let isCachedDriopLists = "isCachedDriopLists"
    static let isWaitForMainNewPassVC="isWaitForMainNewPassVC"
    static let isWaitForMainNewPassVCMobile="isWaitForMainNewPassVCMobile"
    
    static let mainCurrentUserApiToken="mainCurrentUserApiToken"
    static let MainLoginINDEX="MainLoginINDEX"
    //welcome
    static let isCityCached="isCityCached"
    static let isAreaCached="isAreaCached"
    static let isInsuranceCached="isInsuranceCached"
    static let isDegreesCached="isDegreesCached"
    static let isSpecificationsCached="isSpecificationsCached"

    
    
    //login or reigster done states
    static let DoctorPerformLogin="DoctorPerformLogin"
    static let medicalCenterPerformLogin="medicalCenterPerformLogin"
    static let pharamacyPerformLogin="pharamacyPerformLogin"
    static let labPerformLogin="labPerformLogin"
    static let radiologyPerformLogin="radiologyPerformLogin"
    
    
    
    //doctor register
    static let doctorRegisterImage = "doctorRegisterImage"
    static let doctorRegisterName="doctorRegisterName"
    static let doctorRegisterEmail="doctorRegisterEmail"
    static let doctorRegisterMobile="doctorRegisterMobile"
    static let doctorRegisterPassword="doctorRegisterPassword"
    static let doctorRegisterMale="doctorRegisterMale"
    static let doctorRegisterIndee="doctorRegisterIndee"
    static let isDoctorSecondRegister="isDoctorSecondRegister"
    
    //doctor second register
    static let doctorRegisterSecondIsFromForgetPassw="doctorRegisterSecondIsFromForgetPassw"
    static let doctorSecondRegisterSMSCode="doctorSecondRegisterSMSCode"
    //doctor login
    static let doctorCurrentApiToken="doctorCurrentApiToken"
    static let doctorCurrentNAME="doctorCurrentNAME"
    static let doctorCurrentUSERID="doctorCurrentUSERID"

    //doctro verifcation
    static let DoctorVerificationAPITOKEN="DoctorVerificationAPITOKEN"
    static let DoctorVerificationDoctorId="DoctorVerificationDoctorId"
    
    static let labVerificationAPITOKEN="labVerificationAPITOKEN"
       static let labVerificationLabId="labVerificationLabId"
    
    static let RadiologyVerificationAPITOKEN="RadiologyVerificationAPITOKEN"
       static let RadiologyVerificationRadiologyId="RadiologyVerificationRadiologyId"
    
    static let PharamacyVerificationAPITOKEN="PharamacyVerificationAPITOKEN"
       static let PharamacyVerificationPharamacyId="PharamacyVerificationPharamacyId"
    
    //doctor clinic create
    static let DocotrClinicCreateCLINICID="DocotrClinicCreateCLINICID"
    static let DoctorPerformLoginWithMainIndex="DoctorPerformLoginWithMainIndex"
    
    //register
    static let userMobileNumber="userMobileNumber"
    static let doctorSecondRegisterUser_id = "doctorRegisterUser_id"
    static let isUserRegisterAndWaitForClinicData="isUserRegisterAndWaitForClinicData"
    static let isUserRegisterAndWaitForClinicDataIndex="isUserRegisterAndWaitForClinicDataIndex"
    
    //register all
    static let radiologyRegisterUser_id = "radiologyRegisterUser_id"
    static let labRegisterUser_id = "labRegisterUser_id"
    static let pharamcyRegisterUser_id = "pharamcyRegisterUser_id"
    static let pharamcyRegisterSMSCode="pharamcyRegisterSMSCode"
    static let radiologyRegisterSMSCode="radiologyRegisterSMSCode"
    static let labRRegisterSMSCode="labRRegisterSMSCode"
    static let pharamcyRegisterMobile="pharamcyRegisterMobile"
    static let labRegisterMobile="labRegisterMobile"
    static let radiologyRegisterMobile="radiologyRegisterMobile"

    
    //lab login
       static let labCurrentApiToken="labCurrentApiToken"
       static let labCurrentNAME="labCurrentNAME"
       static let labCurrentUSERID="labCurrentUSERID"

    
    //radiology login
       static let radiologyCurrentApiToken="radiologyCurrentApiToken"
       static let radiologyCurrentNAME="radiologyCurrentNAME"
       static let radiologyCurrentUSERID="radiologyCurrentUSERID"

    //pharamacy login
       static let pharamacyCurrentApiToken="pharamacyCurrentApiToken"
       static let pharamacyCurrentNAME="pharamacyCurrentNAME"
       static let pharamacyCurrentUSERID="pharamacyCurrentUSERID"

    

    
    //for english
    static let areaNameArray = "areaNameArray"
    static let specificationNameArray = "specificationNameArray"
    static let cityNameArray = "cityNameArray"
    static let degreeNameArray = "degreeNameArray"
    static let insuranceNameArray = "insuranceNameArray"
    
    
    //for arabic
    static let areaNameARArray = "areaNameARArray"
    static let specificationNameARArray = "specificationNameARArray"
    static let cityNameARArray = "cityNameARArray"
    static let degreeNameARArray = "degreeNameARArray"
    static let insuranceNameARArray = "insuranceNameARArray"
    
    //for French
    static let areaNameFRArray = "areaNameFRArray"
    static let specificationNameFRArray = "specificationNameFRArray"
    static let cityNameFRArray = "cityNameFRArray"
    static let degreeNameFRArray = "degreeNameFRArray"
    static let insuranceNameFRArray = "insuranceNameFRArray"
    
    static let cityIdArray = "cityIdArray"
    static let areaIdArray = "areaIdArray"
    static let areaCityIdsArrays = "areaCityIdsArrays"
    static let specificationIdArray = "specificationIdArray"
    static let insuranceIdArray = "insuranceIdArray"
    static let degreeIdArray = "degreeIdArray"
    static let radiologyIdArray="radiologyIdArray"
    
    
    static let isUserRegisterAndWaitForSMScODE = "isUserRegisterAndWaitForSMScODE"
    static let isUserRegisterAndWaitForSMScODEIndex = "isUserRegisterAndWaitForSMScODEIndex"
    
    //for clinic working hours
    static let first1 = "first1"        ;  static let first211 = "first211"     ; static let first1pm = "first1pm" ;  static let first211pm = "first211pm"
    static let first11 = "first11"      ;  static let first2111 = "first2111"   ; static let first11pm = "first11pm" ; static let first2111pm = "first2111pm"
    static let first2 = "first2"        ;  static let first22 = "first22"       ; static let first2pm = "first2pm" ; static let first22pm = "first22pm"
    static let first21 = "first21"      ;  static let first221 = "first221"     ; static let first21pm = "first21pm" ;  static let first221pm = "first221pm"
    static let first3 = "first3"        ;  static let first23 = "first23"       ; static let first3pm = "first3pm" ;  static let first23pm = "first23pm"
    static let first31 = "first31"      ;  static let first231 = "first231"     ; static let first31pm = "first31pm" ;  static let first231pm = "first231pm"
    static let first4 = "first4"        ;  static let first24 = "first24"       ; static let first4pm = "first4pm" ;  static let first24pm = "first24pm"
    static let first41 = "first41"      ;  static let first241 = "first241"     ; static let first41pm = "first41pm" ;  static let first241pm = "first241pm"
    static let first5 = "first5"        ;  static let first25 = "first25"       ; static let first5pm = "first5pm" ;  static let first25pm = "first25pm"
    static let first51 = "first51"      ;  static let first251 = "first251"     ; static let first51pm = "first51pm" ; static let first251pm = "first251pm"
    static let first6 = "first6"        ;  static let first26 = "first26"       ; static let first6pm = "first6pm" ;  static let first26pm = "first26pm"
    static let first61 = "first61"      ;  static let first261 = "first261"     ; static let first61pm = "first61pm" ; static let first261pm = "first261pm"
    static let first7 = "first7"        ;  static let first27 = "first27"       ; static let first7pm = "first7pm" ;  static let first27pm = "first27pm"
    static let first71 = "first71"      ;  static let first271 = "first271"     ; static let first71pm = "first71pm" ;  static let first271pm = "first271pm"
    
    static let day1 = "day1"            ; static let day2 = "day2"      ; static let day3 = "day3" ;  static let day4 = "day4"
    static let day5 = "day5"            ; static let day6 = "day6"      ; static let day7 = "day7"
    static let isClinicWorkingHoursSaved = "isClinicWorkingHoursSaved"
    
    //for  working hours
    static let mainfirst1 = "mainfirst1"
    static let mainfirst11 = "mainfirst11"
    static let mainfirst2 = "mainfirst2"
    static let mainfirst21 = "mainfirst21"
    static let mainfirst3 = "mainfirst3"
    static let mainfirst31 = "mainfirst31"
    static let mainfirst4 = "mainfirst4"
    static let mainfirst41 = "mainfirst41"
    static let mainfirst5 = "mainmainfirst5"
    static let mainfirst51 = "mainfirst51"
    static let mainfirst6 = "mainfirst6"
    static let mainfirst61 = "mainfirst61"
    static let mainfirst7 = "mainfirst7"
    static let mainfirst71 = "mainfirst71"
    
    static let mainday1 = "mainday1"            ; static let mainday2 = "day2"      ; static let mainday3 = "mainday3" ;  static let mainday4 = "mainday4"
    static let mainday5 = "mainday5"            ; static let mainday6 = "day6"      ; static let mainday7 = "mainday7"
    static let isWorkingHoursSaved = "isWorkingHoursSaved"


    
    static let isDataFound = "isDataFound"
    static let isRegisterDoneAfterBooking="isRegisterDoneAfterBooking"
    static let patientPhotoUrl="patientPhotoUrl"
    static let patientName="patientName"
    
    //welcome
    static let isLabCached="isLabCached"
    static let isRadiologyCached="isRadiologyCached"
    static let isMedicineNameCached="isMedicineNameCached"
    static let isMedicineTypeCached="isMedicineTypeCached"
    static let isPaymentDetailsInfo = "isPaymentDetailsInfo"
    static let isPharamacyCached = "isPharamacyCached"
    static let isLabAnanysisDetailsInfo = "isLabAnanysisDetailsInfo"
      static let isRadAnanlysisCached = "isRadAnanlysisCached"
    
    //register
    static let patientID="patientID"
    
    static let patienMobileNumber="patienMobileNumber"
    
    
    //verification
    static let patientUserID="patientUserID"
    static let patientAPITOKEN="patientAPITOKEN"
    static let isPatientLogin="isPatientLogin"
    
    
    //for english
    static let labNameArray = "labNameArray"
    static let radiologyNameArray = "radiologyNameArray"
    
    static let medicineNameArray = "medicineNameArray"
    static let medicineTypeArray = "medicineTypeArray"
    static let pharamacyNameArray = "pharamacyNameArray"
    static let labAnalysisNameArray = "labAnalysisNameArray"
    static let radAnalysisNameArray = "radAnalysisNameArray"
    
    
    //for arabic
    static let labNameARArray = "labNameARArray"
    static let medicineNameARArray = "medicineNameARArray"
    static let medicineTypeARArray = "medicineTypeARArray"
    static let radiologyNameARArray = "radiologyNameARArray"
    static let pharamacyNameARArray = "pharamacyNameARArray"
    static let labAnalysisNameARArray = "labAnalysisNameARArray"
    static let radAnalysisNameARArray = "radAnalysisNameARArray"
    
    //for French
    static let labNameFRArray = "labNameFRArray"
    static let medicineNameFTArray = "medicineNameFTArray"
    static let medicineTypeFRArray = "medicineTypeFRArray"
    static let radiologyNameFRArray = "radiologyNameFRArray"
    static let pharamacyNameFRArray = "pharamacyNameFRArray"
    static let labAnalysisNameFRArray = "labAnalysisNameFRArray"
    static let radAnalysisNameFRArray = "radAnalysisNameFRArray"
    
    //ids
    static let labIdArray = "labIdArray"
    static let medicineNameIDSArray = "medicineNameIDSArray"
    static let medicineTypeIDSArray = "medicineTypeIDSArray"
    static let pharamacyIdrray = "pharamacyIdrray"
    static let labAnalysisIdArray = "labAnalysisIdArray"
    static let radAnalysisIdArray = "radAnalysisIdArray"
    
    static let paymentDetailsInfo = "paymentDetailsInfo"
    
    
    
}

