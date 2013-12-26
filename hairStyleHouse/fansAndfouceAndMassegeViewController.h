//
//  fansAndFouceAndmassegeViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fansAndfoceAndMassegeCell.h"
#import "dresserInforViewController.h"
#import "userInforViewController.h"
#import "talkViewController.h"

@interface fansAndFouceAndmassegeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UIImageView * topImage;
    UITableView *myTableView;
    NSMutableArray * dresserArray;
    BOOL dresserOrperson;//yes是发型师。no是个人用户
    
    
    NSString * fansOrFouceOrMessage;
    NSString * fansOrFouce;
    
    dresserInforViewController * dreserView;
    userInforViewController * userView;
}
@property (strong,nonatomic)    NSString * fansOrFouceOrMessage;
@property (strong,nonatomic)    NSString * fansOrFouce;
@end

