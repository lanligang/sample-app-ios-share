//
//  DocumentsViewController.m
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import "DocumentsViewController.h"

@interface DocumentsViewController ()

@end

@implementation DocumentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  /*
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSString *urlString = @"http://52.53.94.163/veeva/RPENv2_0010_Raxxira_EN-2.html";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
  */  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)onSelect:(id)sender
{
    NSString *vcName = @"ContentViewController";
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
