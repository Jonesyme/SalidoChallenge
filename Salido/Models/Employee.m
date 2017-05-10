//
//  Employee.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "Employee.h"

@implementation Employee

-(id)initWithPIN:(NSString *)pin firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    self = [super init];
    if(self) {
        self.pin = pin;
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
        self.startDate = [NSDate date]; // start date = today's date
    }
    return self;
}

-(void)assignNewStartDate:(NSDate *)date {
    _startDate = date;
}

-(NSString *)formattedStartDateString {
    if(_startDate==nil)
        return @"N/A";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    return [formatter stringFromDate:_startDate];
}

#
#pragma mark NSCoding Protocol
#
-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_pin forKey:@"pin"];
    [coder encodeObject:_firstName forKey:@"firstName"];
    [coder encodeObject:_lastName forKey:@"lastName"];
    [coder encodeObject:_email forKey:@"email"];
    [coder encodeObject:_startDate forKey:@"startDate"];
}
-(id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if(self != nil) {
        _pin = [coder decodeObjectForKey:@"pin"];
        _firstName = [coder decodeObjectForKey:@"firstName"];
        _lastName = [coder decodeObjectForKey:@"lastName"];
        _email = [coder decodeObjectForKey:@"email"];
        _startDate = [coder decodeObjectForKey:@"startDate"];
    }
    return self;
}
@end
