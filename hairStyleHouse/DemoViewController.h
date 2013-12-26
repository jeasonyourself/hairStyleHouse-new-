//
//  DemoViewController.h
//  SlideImageView
//
//  Created by rd on 12-12-17.
//  Copyright (c) 2012年 LXJ_成都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideImageView.h"
#import "commentViewController.h"
@interface DemoViewController : UIViewController<SlideImageViewDelegate>
{
    SlideImageView* slideImageView;
    UILabel* indexLabel;
    UILabel* clickLabel;
    
    NSMutableArray * imageArr;
    NSString * getindex;
    
    NSDictionary * dic;
    NSDictionary* diction;

    
    UIView * lineBack;
    UIView * headBack;
    UIImageView * headImage;
    UIButton * headButton;
    UILabel  * nameLable;
    UILabel * cityLable;
    UIImageView * messageImage;
    UIButton * messageButton;
    UIImageView * commentImage;
    UIButton * commentButton;
    UIImageView * likeImage;
    UIButton * likeButton;
    UIImageView * shareImage;
    UIButton * shareButton;
    
    commentViewController * commentController;

}
@property (strong,nonatomic)NSMutableArray * imageArr;
@property (strong,nonatomic)    NSString * getindex;

@end
