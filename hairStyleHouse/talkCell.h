//
//  talkCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface talkCell : UITableViewCell
{
    UIImageView * backImage;

    UIImageView * headImage;

    UILabel * contentLable;
    UIImageView * picImage;
    UILabel * timeLable;

}
- (void)bindMessage:(NSDictionary *)_dic and: (NSDictionary *)lastDic;

@end
