//
//  commentCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-2.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentCell : UITableViewCell<UIScrollViewDelegate>
{
    UIImageView * picImage;
    UIView * headBack;
    UIImageView * headImage;
    UIButton * headButton;
    UILabel * nameLable;
    UILabel * contentLable;
    UIScrollView * likeScroll;
    UILabel* howMuchLable;
    UILabel * timeLable;
}
-(void)setFirstCell:(NSDictionary * )_dic andArr:(NSMutableArray *)_arr;
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index;
@end
