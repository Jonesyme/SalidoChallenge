//
//  AccountManager.h
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kAccountManagerStorageKey @"accountManagerStorageKey"

@class Employee;

/**
 AccountManager class will facilitate the storage of employee records and their associated states 
 inbetween app sessions by serializing its employeeList member array to NSUserDefaults
 */
@interface AccountManager : NSObject

/**
 Singleton Initializer
 */
+(id)sharedInstance;

/**
 Find employee record with a matching PIN or return NIL if no match found
 @param pin is a numeric pin code in string form (string form allows for leading zeros)
 @return instance of Employee class or NIL if no employee with matching PIN found
 */
-(Employee *)employeeWithPIN:(NSString *)pin;

/**
 Fetch array of Employees
 */
-(NSArray *)fetchEmployeeList;

/**
 Search Employee list by FirstName, LastName and Email
 @param searchStr raw search string from UISearchBox
 */
-(NSArray *)searchEmployeeList:(NSString *)searchStr;

/**
 Attempt to create new employee record if one doesn't already exist
 @param pin self-explanatory
 @param firstName self-explanatory
 @param lastName self-explanatory
 @param email self-explanatory
 @return NIL if record creation succeeded, error message on failure
 */
-(NSString *)createNewEmployeeWithPIN:(NSString *)pin firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email;

/**
 Add employee record to store
 @param employee Employee class instance
 */
-(void)addNewEmployee:(Employee *)employee;

/**
 Delete a single employee record containing the specified PIN
 @param pin represents the PIN of the employee we wish to delete
 @return false if member failed to locate any record with a matching PIN
 */
-(BOOL)deleteEmployeeWithPIN:(NSString *)pin;


@end
