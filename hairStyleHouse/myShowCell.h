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
    UIView * firstBack;
    UIView * secondBack;
    UIImageView * firstImage;
    UIImageView * secondImage;
    UIView * introduceView;
    UIButton * firstButton;
    UILabel * contentLable;
    UILabel * commentLable;
    UIView * likeBackground;
    UIImageView * likeImage;
    UILabel* voteLable;
    UILabel * likeAmount;
    
    UIView * introduceView2;
    UIButton * secondButton;
    UILabel * contentLable2;
    UILabel * commentLable2;
    UIView * likeBackground2;
    UIImageView * likeImage2;
    UILabel* voteLable2;

    UILabel * likeAmount2;
    
    UITextView * textV;
    myShowViewController * fatherView;
}
@property(nonatomic,strong) myShowViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
-(void)setSingleCell;
@end
