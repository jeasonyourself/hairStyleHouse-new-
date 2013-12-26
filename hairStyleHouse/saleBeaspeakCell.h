//
//  saleBeaspeakCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface saleBeaspeakCell : UITableViewCell
{
    
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * cityLable;
    UILabel *timeLable;
    UILabel *addressLable;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index;

@end
