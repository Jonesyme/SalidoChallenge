//
//  ResponseStatus.h
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Wine.com - Response Status Code/Message JSON Mapping (included in all API responses)
 */
@interface ResponseStatus : NSObject
    @property(nonatomic,strong) NSArray * Messages;
    @property(nonatomic,strong) NSNumber * ReturnCode;
@end

