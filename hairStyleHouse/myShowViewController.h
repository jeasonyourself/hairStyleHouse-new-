//
//  myShowViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-9.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myShowCell.h"
#import "MJPhotoBrowser.h"
#import "loginViewController.h"
#import "pubImageViewController.h"

@class AllAroundPullView;

@interface myShowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * topImage;
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    
    NSString* style;
    
    MJPhotoBrowser *browser;
    
    loginViewController* loginView;
    pubImageViewController * pubImage;
}
@property(nonatomic,strong)        NSString* style;
-(void)selectImage:(NSInteger)_index;


@end
