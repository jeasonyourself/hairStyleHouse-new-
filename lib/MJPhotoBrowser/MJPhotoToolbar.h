//
//  MJPhotoToolbar.h
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "rigViewController.h"
#import "talkViewController.h"

@class MJPhotoBrowser;
@interface MJPhotoToolbar : UIView<UIActionSheetDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate,UIAlertViewDelegate>
{
    rigViewController * rigView;
    NSString * sign ;
    talkViewController * talkView;
    
}
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@property (nonatomic, strong) MJPhotoBrowser * fatherView;
-(void)getData;
@end
