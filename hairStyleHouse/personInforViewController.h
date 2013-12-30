//
//  personInforViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_IMAGEDATA_LEN 200.0
@interface personInforViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
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
//    UIImageView * headImage;
    
    BOOL ifchangeHeadImage;
}
@property(nonatomic,strong)NSString* _hidden;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UIButton *maleButton;
@property (strong, nonatomic) IBOutlet UIButton *femaleButton;
@property (strong, nonatomic) IBOutlet UITextField *QQfield;

@property (strong, nonatomic) IBOutlet UITextView *personSignText;

@property (strong, nonatomic) IBOutlet UILabel *mobileLable;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;

@property (strong, nonatomic) IBOutlet UITextField *mobileField;
@property (strong, nonatomic) IBOutlet UITextField *checkField;
@property (strong, nonatomic) IBOutlet UILabel *checkSignLable;

@property (strong, nonatomic) IBOutlet UIButton *getCheckButton;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)headButtonClick:(id)sender;
- (IBAction)maleButtonClick:(id)sender;
- (IBAction)femaleButtonClick:(id)sender;
- (IBAction)checkButtonClick:(id)sender;
- (IBAction)getCheckButtonClick:(id)sender;
- (IBAction)sureButtonClick:(id)sender;
- (IBAction)cancelButtonClick:(id)sender;

-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;

@end
