//
//  InviteViewController.m
//  ZoomSDKSample
//
//  Created by Robust Hu on 7/30/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import "InviteViewController.h"

@interface InviteViewController ()

@property (retain, nonatomic) UILabel *meetingURLLabel;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(onCancel:)];
    [self.navigationItem setLeftBarButtonItem:cancelItem];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Pause/Resume" style:UIBarButtonItemStyleBordered target:self action:@selector(onDone:)];
    [self.navigationItem setRightBarButtonItem:doneItem];
    
    NSString *meetingID = [ZoomSDKInviteHelper sharedInstance].meetingID;
    self.title = meetingID;
    
    [self.view addSubview:self.meetingURLLabel];
    NSString *meetingURL = [ZoomSDKInviteHelper sharedInstance].joinMeetingURL;
    self.meetingURLLabel.text = meetingURL;
    
    
    NSLog(@"meeting password: %@", [ZoomSDKInviteHelper sharedInstance].meetingPassword);
    NSLog(@"raw meeting password: %@", [ZoomSDKInviteHelper sharedInstance].rawMeetingPassword);
    NSLog(@"invite email subject: %@", [ZoomSDKInviteHelper sharedInstance].inviteEmailSubject);
    NSLog(@"invite email content: %@", [ZoomSDKInviteHelper sharedInstance].inviteEmailContent);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel*)meetingURLLabel
{
    if (!_meetingURLLabel)
    {
        _meetingURLLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _meetingURLLabel.numberOfLines = 0;
        _meetingURLLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _meetingURLLabel;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.meetingURLLabel.frame = self.view.bounds;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)onDone:(id)sender
{
    BOOL isNoAudio = [[[ZoomSDK sharedSDK] getMeetingService] isNoMeetingAudio];
    [[[ZoomSDK sharedSDK] getMeetingService] pauseMeetingAudio:!isNoAudio];
}

@end
