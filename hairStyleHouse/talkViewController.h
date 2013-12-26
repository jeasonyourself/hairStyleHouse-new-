//
//  talkViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "talkCell.h"
@interface talkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString * uid;
    
    UITableView *myTableView;
    NSMutableArray * dresserArray;
    NSMutableArray * oldArray;
    NSDictionary * headImageDiction;
    
    UIView * lastView;
    UITextView * contentView;
    BOOL ifchangeHeadImage;
    UIImageView * sendImage;
    NSString * imageString;
    UIButton * imageButton;
    UIButton * sendButton;
    
    NSTimer* timer;
    
}
@property(strong,nonatomic)    NSString * uid;

@end
