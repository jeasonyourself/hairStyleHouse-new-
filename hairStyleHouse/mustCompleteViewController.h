//
//  mustCompleteViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "completeViewController.h"
@interface mustCompleteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UITableView *myTableView;
    completeViewController * backView;
    
}
-(void)pushToViewController:(id)_sen;

@end
