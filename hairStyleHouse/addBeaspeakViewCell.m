//
//  addBeaspeakViewCell.m
//  hairStyleHouse
//
//  Created by jeason on 14-4-15.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "addBeaspeakViewCell.h"

@implementation addBeaspeakViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        firstLable = [[UILabel alloc] init];
        firstLable.textAlignment=NSTextAlignmentCenter;
        firstLable.font=[UIFont systemFontOfSize:12.0];
        secondLable = [[UILabel alloc] init];
        secondLable.textAlignment=NSTextAlignmentCenter;
        secondLable.font=[UIFont systemFontOfSize:12.0];
        thirdLable = [[UILabel alloc] init];
        thirdLable.textAlignment=NSTextAlignmentCenter;
        thirdLable.font=[UIFont systemFontOfSize:12.0];
        forthLable = [[UILabel alloc] init];
        forthLable.textAlignment=NSTextAlignmentCenter;
        forthLable.font=[UIFont systemFontOfSize:12.0];
         firstLable.frame=CGRectMake(5, 10, 70, 40);secondLable.frame=CGRectMake(85, 10, 70, 40);thirdLable.frame=CGRectMake(165, 10, 70, 40);forthLable.frame=CGRectMake(240, 10, 70, 40);
        [self addSubview:firstLable];
        [self addSubview:secondLable];[self addSubview:thirdLable];[self addSubview:forthLable];
        // Initialization code
    }
    return self;
}
-(void)setFirstCell
{
    firstLable.text = @"服务项目";
    secondLable.text=@"平时价格";
    thirdLable.text=@"折扣";
    forthLable.text=@"优惠价格";
   
}
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index
{
    firstLable.text = [[_arr objectAtIndex:_index-1] objectForKey:@"goods_name"];
    secondLable.text=[NSString stringWithFormat:@"￥%@",[[_arr objectAtIndex:_index-1] objectForKey:@"price"]];
    thirdLable.text=[NSString stringWithFormat:@"%@折",[[_arr objectAtIndex:_index-1] objectForKey:@"rebate"]];
    forthLable.text=[NSString stringWithFormat:@"￥%@",[[_arr objectAtIndex:_index-1] objectForKey:@"reserve_price"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
