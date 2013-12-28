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
    id interface;
    SEL sucfun;
    SEL errfun;
}
@property(nonatomic , strong)NSString * _hidden;
-(void)pushToViewController:(id)_sen;
-(void)popToController;
-(void)getBack:(id)inter andSuc:(SEL)suc andErr:(SEL)err;

@end
