//
//  AppDelegate.m
//  TabbedTest
//
//  Created by Niall Quinn on 04/02/2016.
//  Copyright © 2016 Popdeem. All rights reserved.
//

#import "AppDelegate.h"
#import "PopdeemSDK.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "PDUISocialLoginHandler.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Bolts/Bolts.h>
#import "PDUserAPIService.h"
#import "PDConstants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
  [[FBSDKApplicationDelegate sharedInstance] application:application
                           didFinishLaunchingWithOptions:launchOptions];
  [application setStatusBarStyle:UIStatusBarStyleLightContent];
  [PopdeemSDK withAPIKey:@"643a7b1a-4d0f-416c-8fc5-b2066f13089b"];
  [PopdeemSDK enableSocialLoginWithNumberOfPrompts:300];
  [PopdeemSDK registerForPushNotificationsApplication:application];
  [PopdeemSDK setUpThemeFile:@"theme"];
	[PopdeemSDK setDebug:YES];
  [PopdeemSDK setThirdPartyUserToken:@"101950-BLz3npqGQndsopP5R3hje7tHXCnbKeGhveTgYnv5QBXCpN38dT4oYHoWfMYyuB"];
  
  return YES;
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [PopdeemSDK application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  [PopdeemSDK application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
  if ([[userInfo objectForKey:@"sender"] isEqualToString:@"popdeem"]) {
    [PopdeemSDK handleRemoteNotification:userInfo];
    return;
  }
}

- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
	
	BOOL wasHandled = [[FBSDKApplicationDelegate sharedInstance] application:app
																																	 openURL:url
																												 sourceApplication:options[@"UIApplicationOpenURLOptionsSourceApplicationKey"]
																																annotation:nil];
	
	if (wasHandled) return wasHandled;
	
	if ([PopdeemSDK canOpenUrl:url sourceApplication:options[@"UIApplicationOpenURLOptionsSourceApplicationKey"] annotation:nil]) {
		return [PopdeemSDK application:app
													 openURL:url
								 sourceApplication:options[@"UIApplicationOpenURLOptionsSourceApplicationKey"]
												annotation:nil];
	}
	
	return NO;
	
}

- (BOOL) application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation {
  
  BOOL wasHandled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                   openURL:url
                                                         sourceApplication:sourceApplication
                                                                annotation:annotation];
  
  if (wasHandled) return wasHandled;
  
  if ([PopdeemSDK canOpenUrl:url sourceApplication:sourceApplication annotation:annotation]) {
    return [PopdeemSDK application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
  }
  
  return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
