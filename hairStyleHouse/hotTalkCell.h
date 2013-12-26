//
//  hotTalkCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class hotTalkViewController;

@interface hotTalkCell : UITableViewCell
{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel *timeLable;
     UIButton * cellButton;
hotTalkViewController * fatherView;
}
@property(nonatomic,strong) hotTalkViewController * fatherView;
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
