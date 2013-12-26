//
//  inviteCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class inviteViewController;
@interface inviteCell : UITableViewCell
{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * contentLable;
    UILabel * addressLable;
    UILabel *timeLable;
    UIButton * cellButton;
    inviteViewController * fatherView;
}
@property(nonatomic,strong) inviteViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
