//
//  wayDetailCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wayDetailCell : UITableViewCell
{

    UIImageView * headImage;
    
    UILabel * nameLable;
    UILabel * contentLable;

}
-(void)setFirstCell:(NSDictionary * )_dic ;
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index;
@end
