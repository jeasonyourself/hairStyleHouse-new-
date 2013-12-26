//
//  pubInviteInforViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pubInviteInforViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UITableView *myTableView;
    NSDictionary * inforDic;
    NSString * verifyString;
    NSString * mobileString;
    NSString * sexString;
    NSString * headString;
    NSTimer * timer;
    NSString * timeString;
    UIView * backView;

}
@property (strong, nonatomic) IBOutlet UITextField *numTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *mobileTextField;
@property (strong, nonatomic) IBOutlet UIButton *pubButton;

- (IBAction)pubButtonClick:(id)sender;

-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;
@end
