//
//  DetailsViewController.m
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)onAccount:(id)sender
{
}

- (IBAction)onSchedule:(id)sender
{
}

- (IBAction)onDocument:(id)sender
{
    NSString *vcName = @"DocumentsViewController";
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    nav.navigationBarHidden = YES;
//    [self presentViewController:nav animated:YES completion:NULL];
    
}

@end
