//
//  enterPubWayViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-3-28.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_IMAGEDATA_LEN 2000000.0

@class TPKeyboardAvoidingScrollView;

@interface enterPubWayViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    TPKeyboardAvoidingScrollView *scrollView;
    BOOL ifChangeImage;
    BOOL ifChangeImage2;BOOL ifChangeImage3;BOOL ifChangeImage4;
    NSString * whichImage;
    NSString * howMuchImage;
    
    UIImageView * firstImage;
    UIImageView * secondImage;
    UIImageView * thirdImage;
    UIImageView * forthImage;
    
    NSString * imageString1;
    NSString * imageString2;
    NSString * imageString3;
    NSString * imageString4;
    
    UIActivityIndicatorView *_activityIndicatorView;
    
}
@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *titlfield;

@property (strong, nonatomic) IBOutlet UITextView *firstTextView;

@property (strong, nonatomic) IBOutlet UITextView *secondTextView;
@property (strong, nonatomic) IBOutlet UITextView *thirdTextView;
@property (strong, nonatomic) IBOutlet UITextView *forthTextView;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UIButton *secondButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdButton;
@property (strong, nonatomic) IBOutlet UIButton *forthButton;

@property(nonatomic,strong)NSString* style;
@property(nonatomic,strong)NSString * _hidden;


- (IBAction)picButtonClick:(id)sender;

- (IBAction)addButtonClick:(id)sender;

- (IBAction)sendButtonClick:(id)sender;


@end
