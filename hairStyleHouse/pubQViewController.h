//
//  pubQViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_IMAGEDATA_LEN 2000000.0

@interface pubQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate>
{
    UITableView *myTableView;
    UIActivityIndicatorView * _activityIndicatorView ;
    
    UIView * backView;
    
    UIImageView * headImage;
    UIButton * headButton;
    UITextView * describeText;
    UIButton * sendButton;
    BOOL ifChangeImage;
}
@property(nonatomic,strong)NSString * _hidden;



@end
