//
//  Employee.h
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Employee : NSObject <NSCoding>

@property(atomic,strong) NSString * pin;
@property(atomic,strong) NSString * firstName;
@property(atomic,strong) NSString * lastName;
@property(atomic,strong) NSString * email;
@property(atomic,strong) NSDate * startDate;

/**
 Generate new employee object
 @note will assign a startDate of Today
 */
-(id)initWithPIN:(NSString *)pin firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email;

/**
 Modify an employee's start date from the default
 */
-(void)assignNewStartDate:(NSDate *)date;

/**
 Retrieve startDate as a formatted string: dd-MM-yyyy
 */
-(NSString *)formattedStartDateString;

/** 
 Conform to NSCoding so we can save/load objects from NSUserDefaults
 */
-(void)encodeWithCoder:(NSCoder *)coder;
-(id)initWithCoder:(NSCoder *)coder;
    
@end


