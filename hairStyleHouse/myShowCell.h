//
//  myShowCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-9.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myShowViewController;
@interface myShowCell : UITableViewCell
{
    
    UIImageView * firstImage;
    UIImageView * secondImage;
    UIView * introduceView;
    UILabel * contentLable;
    UILabel * commentLable;
    UIView * likeBackground;
    UIImageView * likeImage;
    UILabel * likeAmount;
    
    UIView * introduceView2;
    UILabel * contentLable2;
    UILabel * commentLable2;
    UIView * likeBackground2;
    UIImageView * likeImage2;
    UILabel * likeAmount2;
    myShowViewController * fatherView;
}
@property(nonatomic,strong) myShowViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
