//
//  completeViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_IMAGEDATA_LEN 200.0
@class  mustCompleteViewController;
@interface completeViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    BOOL ifchangeHeadImage;
    NSString * headString;

    NSString * type;
    NSString * whictButton;
    mustCompleteViewController * fatherView;
   
}
@property (strong, nonatomic)mustCompleteViewController * fatherView;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;

@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UIButton *secondButton;

- (IBAction)headButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLable;
@property (strong, nonatomic) IBOutlet UITextField *storeNameField;

@property (strong, nonatomic) IBOutlet UILabel *mobileLable;
@property (strong, nonatomic) IBOutlet UITextField *mobileField;

@property (strong, nonatomic) IBOutlet UILabel *addressLable;

@property (strong, nonatomic) IBOutlet UITextField *addressField;

@property (strong, nonatomic) IBOutlet UILabel *cityLable;

@property (strong, nonatomic) IBOutlet UITextField *cityField;

@property (strong, nonatomic) IBOutlet UILabel *selfmobileLable;
@property (strong, nonatomic) IBOutlet UITextField *selfmobileField;
@property (strong, nonatomic) IBOutlet UILabel *qqLable;
@property (strong, nonatomic) IBOutlet UITextField *qqField;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton2;


- (IBAction)firstButtonClick:(id)sender;
- (IBAction)secondButtonClick:(id)sender;


- (IBAction)saveButtonClick:(id)sender;

-(IBAction)textFiledReturnEditing:(id)sender;

- (IBAction)touchDown:(id)sender;

@end
