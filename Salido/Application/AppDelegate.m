//
//  AppDelegate.m
//  Salido
//
//  Created by Mike on 5/5/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "AppDelegate.h"
#import "WineWebService.h"

@interface AppDelegate () <UISplitViewControllerDelegate>
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // pre-fetch and cache category filters for later
    [[WineWebService sharedInstance] fetchAllCategories:nil];
    return YES;
}
@end
