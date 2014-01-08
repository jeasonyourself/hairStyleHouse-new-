//
//  scanImageViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scanCell.h"
#import "DemoViewController.h"
#import "MJPhotoBrowser.h"
#import "FMDatabase.h"
@class AllAroundPullView;
@interface scanImageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
UITableView *myTableView;
    UIActivityIndicatorView * _activityIndicatorView ;

    NSMutableArray * localDresserArray;
    NSMutableArray * localcleanDresserArray;
    
//NSMutableArray * dresserArray;
//    NSMutableArray * cleandresserArray;

     NSString * pageCount;
    NSString * page;
    
    MJPhotoBrowser * browser;
    AllAroundPullView *bottomRefreshView;

    
    DemoViewController * demoView;
    
//    NSString * worksOrsaveorCan;
    NSString* uid;
    
    BOOL localData;
    FMDatabase *db;

}
@property(nonatomic,strong)NSString * worksOrsaveorCan;
//@property(nonatomic,strong)NSString * selfOrOther;

@property(nonatomic,strong)NSString* uid;
@property(nonatomic,strong)NSString* _hidden;
-(void)selectImage:(NSInteger)_index;

@end
