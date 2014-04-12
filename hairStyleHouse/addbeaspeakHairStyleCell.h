//
//  addbeaspeakHairStyleCell.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-11.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class addBeaspeakHairStyleViewController;@interface addbeaspeakHairStyleCell : UITableViewCell<UIScrollViewDelegate>
{
    UIView * picBackView;
    UIImageView * picImage;
    UIView * headBack;
    UIImageView * headImage;
    UIButton * headButton;
    UILabel * nameLable;
    UILabel * oldPriceLable;
    UILabel * nowPriceLable;
    UILabel * contentLable;
    UILabel * addressLable;
    UILabel * distanceLable;
    UIButton * beaspeakButton;
    UIButton * askButton;

    UIScrollView * likeScroll;
    UILabel* howMuchLable;
    UILabel * timeLable;
    
    
}
@property(nonatomic,strong)addBeaspeakHairStyleViewController *fatherController;
-(void)setFirstCell:(NSDictionary * )_dic andArr:(NSMutableArray *)_arr;
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index;

@end
