//
//  ContentViewController.m
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import "ContentViewController.h"
#import <MobileRTC/MobileRTC.h>
#import "SplashViewController.h"

#define kSDKUserID      @""
#define kSDKUserName    @""
#define kSDKUserToken   @""
#define kSDKMeetNumber  @""


#define kTitleShare         @"Share"
#define kTitlePause         @"Pause"

#define kTitleJoinMeeting         @"Talk to Your Agent"
#define kTitleLeaveMeeting        @"Stop Share"


@interface ContentViewController ()<UIScrollViewDelegate, MobileRTCMeetingServiceDelegate>
{
    BOOL _pausedShare;
    
    SplashViewController *_splashVC;
}

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize = CGSizeMake(1024*7, 768);
    self.scrollView.delegate = self;
    _splashVC = [SplashViewController new];
    _splashVC.view.frame = self.view.bounds;
    [self.view insertSubview:_splashVC.view belowSubview:self.shareView];
    
    [self.shareButton setHidden:YES];
    [self.showWeb setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Step:5 hide meeting options
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Custom initialization
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
}


//step 7 pause sharing
- (IBAction)onShare:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms)
        return;
    
    _pausedShare = !_pausedShare;
    
    UIView *sv = _pausedShare ? _splashVC.view : self.shareView;
    [ms appShareWithView:sv];
    
    NSString *title = _pausedShare ? kTitleShare : kTitlePause;
    [self.shareButton setTitle:title forState:UIControlStateNormal];
}

- (IBAction)onWeb:(id)sender
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSString *urlString = @"http://google.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webview loadRequest:urlRequest];
    [self.view addSubview:webview];
    
    
    [webview addSubview:_hideWeb];
    
}

- (IBAction)onHideWeb:(id)sender
{

}
- (IBAction)onLeave:(id)sender
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (!ms)
        return;

    if ([ms getMeetingState] != MobileRTCMeetingState_Idle)
    {
        ms.delegate = nil;
        [ms leaveMeetingWithCmd:LeaveMeetingCmd_End];
        NSArray *array = self.navigationController.viewControllers;
        NSArray *vcArray = @[array[0], array[1]];
        [self.navigationController setViewControllers:vcArray animated:YES];
    }
    else
    {
        ms.delegate = self;
        //For Join a meeting with password
        //For API User, the user type should be ZoomSDKUserType_APIUser.
        NSDictionary *paramDict = @{kMeetingParam_UserID:kSDKUserID,
                                    kMeetingParam_UserToken:kSDKUserToken,
                                    kMeetingParam_UserType:@(MobileRTCUserType_APIUser),
                                    kMeetingParam_Username:kSDKUserName,
                                    kMeetingParam_MeetingNumber:kSDKMeetNumber,
                                    kMeetingParam_IsAppShare:@(YES),
                                    //kMeetingParam_ParticipantID:kParticipantID,
                                    //kMeetingParam_NoAudio:@(YES),
                                    //kMeetingParam_NoVideo:@(YES),
                                    };
//step4: start meeting service
        MobileRTCMeetError ret = [ms startMeetingWithDictionary:paramDict];
   
        
        NSLog(@"Sending request.");
        
        // Common constants
        NSString *kTwilioSID = @"";
        NSString *kTwilioSecret =@"";
        NSString *kFromNumber =@"%";
        NSString *kToNumber = @"%";
        NSString *kMessage = @"Hi ";
        
        // Build request
        NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", kTwilioSID, kTwilioSecret, kTwilioSID];
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        // Set up the body
        NSString *bodyString = [NSString stringWithFormat:@"From=%@&To=%@&Body=%@", kFromNumber, kToNumber, kMessage];
        NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSError *error;
        NSURLResponse *response;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        // Handle the received data
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSString *receivedString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
            NSLog(@"Request sent. %@", receivedString);
        }     

        NSLog(@"onMeetNow ret:%d", ret);
    }
}

#pragma mark - Meeting Service Delegate

- (void)onMeetingReturn:(MobileRTCMeetError)error internalError:(NSInteger)internalError
{
    NSLog(@"onMeetingReturn:%d, internalError:%zd", error, internalError);
}

- (void)onMeetingStateChange:(MobileRTCMeetingState)state
{
    NSLog(@"onMeetingStateChange:%d", state);
    
    BOOL inMeeting = (state == MobileRTCMeetingState_InMeeting);
    [self.shareButton setHidden:!inMeeting];
    
    BOOL inIdle = (state == MobileRTCMeetingState_Idle);
    NSString *title = inIdle ? kTitleJoinMeeting : kTitleLeaveMeeting;
    [self.leaveButton setTitle:title forState:UIControlStateNormal];

    if(state == MobileRTCMeetingState_Connecting)
    {
        NSLog(@"meeting state is 1");
    }
    
}

- (void)onMeetingReady
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if ([ms isDirectAppShareMeeting])
    {
        if ([ms isStartingShare] || [ms isViewingShare])
        {
            NSLog(@"There exist an ongoing share");
            [ms showMobileRTCMeeting:nil];
            return;
        }
        
        BOOL ret = [ms startAppShare];
        NSLog(@"Start App Share... ret:%zd", ret);
    }
}


//step6: pass share view to meeting service
- (void)onAppShareSplash
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
        [ms appShareWithView:self.shareView];
        _pausedShare = NO;
        [self.shareButton setTitle:kTitlePause forState:UIControlStateNormal];
    }
}

@end
