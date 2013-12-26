//
//  myShowCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-9.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "myShowCell.h"
#import "myShowViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@implementation myShowCell
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        firstImage = [[UIImageView alloc ] init];
        
        secondImage = [[UIImageView alloc ] init];
        
        
        introduceView = [[UIView alloc] init];
        introduceView.backgroundColor = [UIColor blackColor];
        introduceView.alpha = 0.5;
        contentLable = [[UILabel alloc] init];
        likeBackground = [[UIView alloc] init];
        likeBackground.backgroundColor = [UIColor yellowColor];
        likeImage = [[UIImageView alloc] init];
        [likeImage setImage:[UIImage imageNamed:@"like1.png"]];
        likeAmount = [[UILabel alloc] init];
        commentLable = [[UILabel alloc] init];
        
        introduceView2 = [[UIView alloc] init];
        introduceView2.backgroundColor = [UIColor blackColor];
        introduceView2.alpha = 0.5;
        contentLable2 = [[UILabel alloc] init];
        likeBackground2 = [[UIView alloc] init];
        likeBackground2.backgroundColor = [UIColor yellowColor];
        likeImage2 = [[UIImageView alloc] init];
        [likeImage2 setImage:[UIImage imageNamed:@"like1.png"]];
        likeAmount2 = [[UILabel alloc] init];
        commentLable2 = [[UILabel alloc] init];
        
        [self addSubview:firstImage];
        [self addSubview:secondImage];
        [firstImage addSubview:introduceView];
        [introduceView addSubview:contentLable];
        [introduceView addSubview:likeBackground];
        [likeBackground addSubview:likeImage];
        [likeBackground addSubview:likeAmount];
        [introduceView addSubview:commentLable];
        
        
        [secondImage addSubview:introduceView2];
        [introduceView2 addSubview:contentLable2];
        [introduceView2 addSubview:likeBackground2];
        [likeBackground2 addSubview:likeImage2];
        [likeBackground2 addSubview:likeAmount2];
        [introduceView2 addSubview:commentLable2];
        
        // Initialization code
    }
    return self;
}

-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
   
    
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    
    if (index%2==0)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        NSString * contentStr = [dic objectForKey:@"content"];
        NSString * likeStr = [dic objectForKey:@"collect_num"];
        NSString * commentStr = [dic objectForKey:@"comment_num"];
        
        NSLog(@"%@",contentStr);
        NSLog(@"%@",contentStr);
        NSLog(@"%@",contentStr);

        NSLog(@"headStr11111:%@",headStr);
        
        // 下载图片
        [firstImage setImageURLStr:headStr placeholder:placeholder];
        
        // 事件监听
        firstImage.tag = index;
        firstImage.userInteractionEnabled = YES;
        [firstImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        firstImage.clipsToBounds = YES;
        firstImage.contentMode = UIViewContentModeScaleAspectFill;
        firstImage.frame =CGRectMake(20, 5, 130, 170);
        
        UIFont *font = [UIFont systemFontOfSize:10.0];
        //设置一个行高上限
        CGSize size = CGSizeMake(120,200);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        introduceView.frame = CGRectMake(0, firstImage.frame.size.height-20-labelsize.height, 130, labelsize.height+20);
        contentLable.text = contentStr;
        contentLable.numberOfLines = 0;
        contentLable.font = [UIFont systemFontOfSize:10];
        contentLable.textColor = [UIColor whiteColor];
        contentLable.frame = CGRectMake(2, 3, labelsize.width, labelsize.height);
        
        likeBackground.frame = CGRectMake(0, 5+contentLable.frame.size.height, 60,introduceView.frame.size.height -contentLable.frame.size.height);
        likeImage.frame = CGRectMake(15, 2, 10, 10);
        likeAmount.frame =CGRectMake(30, 2, 20, 10);
        likeAmount.font = [UIFont systemFontOfSize:10];
        likeAmount.text = [NSString stringWithFormat:@"%@",likeStr];
        
        commentLable.frame = CGRectMake(70,3+contentLable.frame.size.height, 60, introduceView.frame.size.height -contentLable.frame.size.height);
        commentLable.font = [UIFont systemFontOfSize:10];
        commentLable.text = [NSString stringWithFormat:@"评论数(%@)",commentStr];
        commentLable.textColor = [UIColor whiteColor];
        secondImage.frame =CGRectMake(0, 0, 0, 0);
    }
    else if (index%2==1)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        NSString * contentStr = [dic objectForKey:@"content"];
        NSString * likeStr = [dic objectForKey:@"collect_num"];
        NSString * commentStr = [dic objectForKey:@"comment_num"];
        NSLog(@"headStr22222:%@",headStr);
        // 下载图片
        [secondImage setImageURLStr:headStr placeholder:placeholder];
        
        // 事件监听
        secondImage.tag = index;
        secondImage.userInteractionEnabled = YES;
        [secondImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        secondImage.clipsToBounds = YES;
        secondImage.contentMode = UIViewContentModeScaleAspectFill;
        secondImage.frame =CGRectMake(170, 5, 130, 170);
        
        UIFont *font = [UIFont systemFontOfSize:10.0];
        //设置一个行高上限
        CGSize size = CGSizeMake(120,200);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        introduceView2.frame = CGRectMake(0, secondImage.frame.size.height-20-labelsize.height, 130, labelsize.height+20);
        contentLable2.text = contentStr;
        contentLable2.numberOfLines = 0;
        contentLable2.font = [UIFont systemFontOfSize:10];
        contentLable2.textColor = [UIColor whiteColor];
        contentLable2.frame = CGRectMake(2, 3, labelsize.width, labelsize.height);
        
        likeBackground2.frame = CGRectMake(0, 5+contentLable2.frame.size.height, 60,introduceView2.frame.size.height -contentLable2.frame.size.height);
        likeImage2.frame = CGRectMake(15, 2, 10, 10);
        likeAmount2.frame =CGRectMake(30, 2, 20, 10);
        likeAmount2.font = [UIFont systemFontOfSize:10];
        likeAmount2.text = [NSString stringWithFormat:@"%@",likeStr];
        
        commentLable2.frame = CGRectMake(70,3+contentLable2.frame.size.height, 60, introduceView2.frame.size.height -contentLable2.frame.size.height);
        commentLable2.font = [UIFont systemFontOfSize:10];
        commentLable2.text = [NSString stringWithFormat:@"评论数(%@)",commentStr];
        commentLable2.textColor = [UIColor whiteColor];
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

@end
