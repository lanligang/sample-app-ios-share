//
//  AppDelegate.m
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import "AppDelegate.h"
#import "SignInViewController.h"
#import <MobileRTC/MobileRTC.h>

#define kZoomSDKAppKey      @""
#define kZoomSDKAppSecret   @""
#define kZoomSDKDomain      @""

@interface AppDelegate ()<MobileRTCAuthDelegate, UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
        
    SignInViewController *signVC = [[SignInViewController alloc] init];
    UINavigationController *rootVC = [[UINavigationController alloc] initWithRootViewController:signVC];
    rootVC.navigationBarHidden = YES;
    self.window.rootViewController = rootVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
//step 1, set domain, call auth function

    //1. Set ZoomSDK Domain
    [[MobileRTC sharedRTC] setMobileRTCDomain:kZoomSDKDomain];
    //2. ZoomSDK Authorize
    [self sdkAuth];
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Auth Delegate

//step2: implement sdkAuth function, pass app key and secret

- (void)sdkAuth
{
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
    if (authService)
    {
        authService.delegate = self;
        
        authService.clientKey = kZoomSDKAppKey;
        authService.clientSecret = kZoomSDKAppSecret;
        
        [authService sdkAuth];
    }
}


//step3: check return value of auth

- (void)onMobileRTCAuthReturn:(MobileRTCAuthError)returnValue
{
    NSLog(@"onMobileRTCAuthReturn %d", returnValue);
    
    if (returnValue != MobileRTCAuthError_Success)
    {
        NSString *message = [NSString stringWithFormat:@"SDK authentication failed, errod code: %zd", returnValue ];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Retry", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self performSelector:@selector(sdkAuth) withObject:nil afterDelay:1.f];
    }
}

@end
