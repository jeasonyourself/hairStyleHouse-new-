//
//  beaspeakCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface beaspeakCell : UITableViewCell
{
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * mobileLable;
    UILabel * typeLable;
    UILabel *timeLable;
    UILabel * statusLable;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;//

@end
