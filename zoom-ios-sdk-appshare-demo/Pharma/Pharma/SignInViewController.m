//
//  SignInViewController.m
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import "SignInViewController.h"
#import "MBProgressHUD.h"

@interface SignInViewController ()<UITextFieldDelegate, MBProgressHUDDelegate>

@end

@implementation SignInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.emailField.delegate = self;
    self.emailField.layer.cornerRadius = 2.0f;
    self.emailField.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.emailField.layer.borderWidth = 1.0f;
    
    self.passField.delegate = self;
    self.passField.layer.cornerRadius = 2.0f;
    self.passField.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.passField.layer.borderWidth = 1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)onSignIn:(id)sender
{
    if ([self.emailField isFirstResponder]){
        [self.emailField resignFirstResponder];
    }
    if ([self.passField isFirstResponder]) {
        [self.passField resignFirstResponder];
    }
    NSString *email = self.emailField.text;
    NSString *pass = self.passField.text;
    if (email.length == 0 || pass.length == 0)
        return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.delegate = self;
    [hud hide:NO afterDelay:3.f];
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self performSelector:@selector(onSignIn:) withObject:nil afterDelay:0.];
    
    return YES;
}

#pragma mark - MBProgressHUD Delegate

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    static NSString *kEmail = @"zoom";
    
    if (![self.emailField.text isEqualToString:kEmail])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Sign In" message:@"Your email or password is invalid!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *vcName = @"DetailsViewController";
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Keyboard Notification

- (void)keyboardWillChangeFrame:(NSNotification*)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect kbFrame = [self.view convertRect:kbRect fromView:[UIApplication sharedApplication].keyWindow];
    
    CGRect signRect = self.signInButton.frame;
    
    CGRect newFrame = self.view.bounds;
    CGFloat offsetY = kbFrame.origin.y - (signRect.origin.y + signRect.size.height) - 10;
    if (offsetY < 0)
    {
        newFrame.origin.y = offsetY;
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.bgView.frame = newFrame;
    }];
}

@end
