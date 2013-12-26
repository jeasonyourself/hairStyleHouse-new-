//
//  hairStyleIconCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-24.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "hairStyleIconCell.h"
#import "findStyleViewController.h"

@implementation hairStyleIconCell
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        firstImage = [[UIImageView alloc ] init];
        
        secondImage = [[UIImageView alloc ] init];
        
        thirdImage = [[UIImageView alloc ] init];
        
        firstLable = [[UILabel alloc] init];
        firstLable.textAlignment = NSTextAlignmentCenter;
        firstLable.font = [UIFont systemFontOfSize:14.0];
        firstLable.textColor = [UIColor colorWithRed:111.0/256.0 green:111.0/256.0 blue:111.0/256.0 alpha:1.0];
        
        secondLable = [[UILabel alloc] init];
        secondLable.textAlignment = NSTextAlignmentCenter;
        secondLable.font = [UIFont systemFontOfSize:14.0];
        secondLable.textColor = [UIColor colorWithRed:111.0/256.0 green:111.0/256.0 blue:111.0/256.0 alpha:1.0];
        
        thirdLable = [[UILabel alloc] init];
        thirdLable.textAlignment = NSTextAlignmentCenter;
        thirdLable.font = [UIFont systemFontOfSize:14.0];
        thirdLable.textColor = [UIColor colorWithRed:111.0/256.0 green:111.0/256.0 blue:111.0/256.0 alpha:1.0];


        [self addSubview:firstImage];
        [self addSubview:secondImage];
        [self addSubview:thirdImage];
        
        [self addSubview:firstLable];
        [self addSubview:secondLable];
        [self addSubview:thirdLable];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    if (index%3==0)
    {
        
        // 下载图片
        UIImageView * _ima= [dic objectForKey:@"imageArr"];
        firstImage.image=_ima.image;
        firstLable.text = [dic objectForKey:@"nameArr"];
        
        // 事件监听
        firstImage.tag = index;
        firstImage.userInteractionEnabled = YES;
        [firstImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        firstImage.clipsToBounds = YES;
        firstImage.contentMode = UIViewContentModeScaleAspectFill;
        firstImage.frame =CGRectMake(5, 20, 70, 90);
        secondImage.frame =CGRectMake(0, 0, 0, 0);
        thirdImage.frame =CGRectMake(0, 0, 0, 0);
        
        firstLable.frame =CGRectMake(6, 112,70, 20);
        secondLable.frame =CGRectMake(0, 0, 0, 0);
        thirdLable.frame =CGRectMake(0, 0, 0, 0);
    }
    else if (index%3==1)
    {
        
        // 下载图片
        UIImageView * _ima= [dic objectForKey:@"imageArr"];
        secondImage.image=_ima.image;
        
        secondLable.text = [dic objectForKey:@"nameArr"];

        
        // 事件监听
        secondImage.tag = index;
        secondImage.userInteractionEnabled = YES;
        [secondImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        secondImage.clipsToBounds = YES;
        secondImage.contentMode = UIViewContentModeScaleAspectFill;
        secondImage.frame =CGRectMake(81, 20, 70, 90);
        thirdImage.frame =CGRectMake(0, 0, 0, 0);
        
        secondLable.frame =CGRectMake(82, 112, 70, 20);
        thirdLable.frame =CGRectMake(0, 0, 0, 0);
    }
    else if (index%3==2)
    {
    
        
        UIImageView * _ima= [dic objectForKey:@"imageArr"];
        thirdImage.image=_ima.image;
        
        thirdLable.text = [dic objectForKey:@"nameArr"];

        // 事件监听
        thirdImage.tag = index;
        thirdImage.userInteractionEnabled = YES;
        [thirdImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        thirdImage.clipsToBounds = YES;
        thirdImage.contentMode = UIViewContentModeScaleAspectFill;
        thirdImage.frame =CGRectMake(158, 20, 70, 90);
        
        thirdLable.frame =CGRectMake(160, 112,70, 20);
    }
    
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [fatherView selectImage:tap.view.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end;