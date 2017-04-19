//
//  DocumentsViewController.h
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import <UIKit/UIKit.h>

@interface DocumentsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton     *selectButton;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

- (IBAction)onSelect:(id)sender;

@end
