//
//  questionDetailCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionDetailCell : UITableViewCell
{
    UIImageView * picImage;
    UIView * headBack;
    UIImageView * headImage;
    UIButton * headButton;
    UILabel * nameLable;
    UILabel * contentLable;
    UILabel* howMuchLable;
    UILabel * timeLable;
}
-(void)setFirstCell:(NSDictionary * )_dic andArr:(NSMutableArray *)_arr;
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index;
@end
