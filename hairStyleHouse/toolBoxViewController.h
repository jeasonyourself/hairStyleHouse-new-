//
//  toolBoxViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-30.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "toolBoxSingleCellViewController.h"
#import "dresserToolBoxSingleCellViewController.h"
@interface toolBoxViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    toolBoxSingleCellViewController * backView;
    dresserToolBoxSingleCellViewController * backView1;
}
@property(nonatomic,retain) NSString * _hidden;
-(void)pushToViewController:(id)_sen;
@end
