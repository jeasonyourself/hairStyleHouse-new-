//
//  fansAndfoceAndMassegeCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fansAndfoceAndMassegeCell : UITableViewCell
{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * cityLable;
    UILabel *timeLable;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;//查看粉丝或者我关注的人
-(void)setCell2:(NSDictionary *)dic andIndex:(NSInteger)index;//查看消息列表

@end
