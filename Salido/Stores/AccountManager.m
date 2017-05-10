//
//  AccountManager.m
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "AccountManager.h"
#import "Employee.h"

/**
 Stores Employee account records and serializes to NSUserDefaults inbetween app launches
 */

@interface AccountManager ()
@property (atomic, strong) NSMutableArray<Employee *> * employeeList;
-(void)loadInitialEmployeeRecords;
/**
 Storage implementation - Save/Load employee list from NSUserDefaults
 */
-(void)saveStore;
-(void)loadStore;
@end

@implementation AccountManager

// shared singleton
+(id)sharedInstance {
    static AccountManager * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if(self) {
        [self loadStore];
    }
    return self;
}

-(void)loadInitialEmployeeRecords{
    _employeeList = [[NSMutableArray alloc] init];
    [_employeeList addObject:[[Employee alloc] initWithPIN:@"1234" firstName:@"Mike" lastName:@"Jones" email:@"jones.t.michael@gmail.com"]];
    [self saveStore];
    [self loadStore];
}

-(Employee *)employeeWithPIN:(NSString *)pin {
    // loop through employee records to find matching PIN
    for (Employee * emp in _employeeList) {
        if([emp.pin isEqualToString:pin]) {
            return emp;
        }
    }
    return nil;
}

-(NSArray *)fetchEmployeeList {
    return _employeeList;
}

-(NSArray *)searchEmployeeList:(NSString *)searchStr {
    // if no searchStr present, return all employees
    if(searchStr==nil || searchStr.length==0)
        return [self fetchEmployeeList];
    
    // loop through employee records to find matches
    NSMutableArray * resultList = [[NSMutableArray alloc] init];
    for (Employee * emp in _employeeList) {
        NSString * fullName = [emp.firstName stringByAppendingFormat:@" %@", emp.lastName];
        if([fullName containsString:searchStr] || [emp.email containsString:searchStr]) {
            [resultList addObject:emp];
        }
    }
    return resultList;
}

-(NSString *)createNewEmployeeWithPIN:(NSString *)pin firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    // loop through existing accounts to verify no duplicate records exist
    for (Employee * emp in _employeeList) {
        NSString * duplicateFieldName = nil;
        if([emp.pin isEqualToString:pin]) {
            duplicateFieldName = @"PIN";
        } else if ([emp.lastName isEqualToString:lastName]) {
            duplicateFieldName = @"last name";
        } else if ([emp.email isEqualToString:email]) {
            duplicateFieldName = @"email address";
        }
        if(duplicateFieldName!=nil)
            return [NSString stringWithFormat:@"Employee with matching %@ already exists", duplicateFieldName];
    }
    if(pin.length < 4)
        return @"PIN must contain 4 digits";
    
    // if we're here, inputs are unique, create employee account record
    Employee * emp = [[Employee alloc] initWithPIN:pin firstName:firstName lastName:lastName email:email];
    [self addNewEmployee:emp];
    return nil;
}

-(void)addNewEmployee:(Employee *)employee {
    [_employeeList addObject:employee];
    [self saveStore];
}

-(BOOL)deleteEmployeeWithPIN:(NSString *)pin {
    int index = -1;
    // find matching record
    for (Employee * emp in _employeeList) {
        if([emp.pin isEqualToString:pin]) {
            index = (int)[_employeeList indexOfObject:emp];
        }
    }
    // delete record
    if(index >= 0) {
        [_employeeList removeObjectAtIndex:index];
        [self saveStore];
        return true;
    }
    return false; // failed to locate matching employee record
}


#
#pragma mark - Storage Implementation via NSUserDefaults
#
-(void)saveStore {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_employeeList] forKey:kAccountManagerStorageKey];
}
-(void)loadStore {
    NSUserDefaults * currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData * serializedStorageData = [currentDefaults objectForKey:kAccountManagerStorageKey];
    if(serializedStorageData == nil) {
        [self loadInitialEmployeeRecords];
        return;
    }
    NSArray * deserializedArray = [NSKeyedUnarchiver unarchiveObjectWithData:serializedStorageData];
    if(deserializedArray == nil) {
        [self loadInitialEmployeeRecords];
        return;
    }
    // load stored array
    _employeeList = [[NSMutableArray alloc] initWithArray:deserializedArray];
    if([_employeeList count]==0)
        [self loadInitialEmployeeRecords];
}

@end
