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
        
        firstBack = [[UIView alloc ] init];
        
        secondBack = [[UIView alloc ] init];
        
        firstImage = [[UIImageView alloc ] init];
        
        secondImage = [[UIImageView alloc ] init];
        
        
        introduceView = [[UIView alloc] init];
        introduceView.backgroundColor = [UIColor clearColor];
        introduceView.alpha = 0.5;
        contentLable = [[UILabel alloc] init];
        likeBackground = [[UIView alloc] init];
        likeBackground.backgroundColor = [UIColor yellowColor];
        likeImage = [[UIImageView alloc] init];
        [likeImage setImage:[UIImage imageNamed:@"like1.png"]];
        likeAmount = [[UILabel alloc] init];
        voteLable = [[UILabel alloc] init];
        voteLable.text = @"票数:";

        
        firstButton = [[UIButton alloc] init];
        [firstButton setBackgroundColor:[UIColor colorWithRed:240.0/256.0 green:26.0/256.0 blue:98.0/256.0 alpha:1.0]];
        [firstButton setTitle:@"投票" forState:UIControlStateNormal];
        firstButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
        firstButton.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        firstButton.layer.masksToBounds = YES;//设为NO去试试
        commentLable = [[UILabel alloc] init];
        
        introduceView2 = [[UIView alloc] init];
        introduceView2.backgroundColor = [UIColor clearColor];
        introduceView2.alpha = 0.5;
        contentLable2 = [[UILabel alloc] init];
        likeBackground2 = [[UIView alloc] init];
        likeBackground2.backgroundColor = [UIColor yellowColor];
        likeImage2 = [[UIImageView alloc] init];
        [likeImage2 setImage:[UIImage imageNamed:@"like1.png"]];
        likeAmount2 = [[UILabel alloc] init];
        voteLable2 = [[UILabel alloc] init];
        voteLable2.text = @"票数:";


        
        secondButton = [[UIButton alloc] init];
        [secondButton setBackgroundColor:[UIColor colorWithRed:240.0/256.0 green:26.0/256.0 blue:98.0/256.0 alpha:1.0]];
        [secondButton setTitle:@"投票" forState:UIControlStateNormal];
        secondButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
        secondButton.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        secondButton.layer.masksToBounds = YES;//设为NO去试试
        commentLable2 = [[UILabel alloc] init];
        
        
        [self addSubview:firstBack];
        [self addSubview:secondBack];
        [firstBack addSubview:firstImage];
        [firstBack addSubview:introduceView];

//        [introduceView addSubview:likeBackground];
        [introduceView addSubview:firstButton];
        [introduceView addSubview:voteLable];

        [introduceView addSubview:commentLable];
        
        [introduceView addSubview:contentLable];
        
//        [likeBackground addSubview:likeImage];
        [introduceView addSubview:likeAmount];
        
        
        
        [secondBack addSubview:secondImage];
        [secondBack addSubview:introduceView2];
//        [introduceView2 addSubview:likeBackground2];
//        [likeBackground2 addSubview:likeImage2];
        [introduceView2 addSubview:likeAmount2];
        
        [introduceView2 addSubview: secondButton];
        [introduceView2 addSubview:voteLable2];
        [introduceView2 addSubview:commentLable2];
        [introduceView2 addSubview:contentLable2];

        
        textV = [[UITextView alloc] init];
        textV.returnKeyType=UIReturnKeyDone;
        textV.userInteractionEnabled=NO;
        textV.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:textV];
        // Initialization code
    }
    return self;
}

-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
   
    
//    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    
    if (index%2==0)
    {
        
        UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];

        NSString * headStr= [dic objectForKey:@"work_image"];
//        NSString * contentStr = [dic objectForKey:@"content"];
        NSString * likeStr = [dic objectForKey:@"votes"];
        NSString * commentStr = [dic objectForKey:@"rank"];
        
       

        NSLog(@"headStr11111:%@",headStr);
        
        firstBack.frame =CGRectMake(5, 5, 152, 230);

        firstBack.backgroundColor = [UIColor colorWithRed:243.0/256.0 green:242.0/256.0 blue:241.0/256.0 alpha:1.0];
        
        // 下载图片
        [firstImage setImageURLStr:headStr placeholder:placeholder];
//        firstImage.image=[dic objectForKey:@"image"];
        
        // 事件监听
        firstImage.tag = index;
        firstImage.userInteractionEnabled = YES;
        [firstImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        firstImage.clipsToBounds = YES;
        firstImage.contentMode = UIViewContentModeScaleAspectFill;
        firstImage.frame =CGRectMake(5, 5, 142, 165);
        
//        UIFont *font = [UIFont systemFontOfSize:10.0];
//        //设置一个行高上限
//        CGSize size = CGSizeMake(120,200);
        //计算实际frame大小，并将label的frame变成实际大小
//        CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
//        introduceView.frame = CGRectMake(0, firstImage.frame.size.height, 142, firstBack.frame.size.height-5-firstImage.frame.size.height);
//        contentLable.text = contentStr;
//        contentLable.numberOfLines = 0;
//        contentLable.font = [UIFont systemFontOfSize:10];
//        contentLable.textColor = [UIColor whiteColor];
//        contentLable.frame = CGRectMake(2, 3, labelsize.width, labelsize.height);
        
        introduceView.frame = CGRectMake(0, firstImage.frame.size.height+firstImage.frame.origin.y, 142,firstBack.frame.size.height-firstImage.frame.size.height-firstImage.frame.origin.y);
//        likeImage.frame = CGRectMake(15, 2, 10, 10);
        likeAmount.frame =CGRectMake(115, 5, 40, 25);
        likeAmount.font = [UIFont systemFontOfSize:14];
        likeAmount.text = [NSString stringWithFormat:@"%@",likeStr];
        likeAmount.textColor = [UIColor colorWithRed:240.0/256.0 green:26.0/256.0 blue:98.0/256.0 alpha:1.0];

        
        firstButton.frame = CGRectMake(5, 5, 60, 25);
        firstButton.tag = index;
        firstButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [firstButton addTarget:self action:@selector(give:) forControlEvents:UIControlEventTouchUpInside];
        
        voteLable.frame = CGRectMake(15+firstButton.frame.size.width,5, 70, 25);
        voteLable.font = [UIFont systemFontOfSize:14];
        voteLable.textColor = [UIColor blackColor];
        
        commentLable.frame = CGRectMake(5,firstButton.frame.origin.y+firstButton.frame.size.height, 132, 30);
        commentLable.font = [UIFont systemFontOfSize:12];
        commentLable.text = [NSString stringWithFormat:@"发型榜第一季   排名:"];
        commentLable.textColor = [UIColor blackColor];
        
        contentLable.frame = CGRectMake(115,firstButton.frame.origin.y+firstButton.frame.size.height, 50, 30);
        contentLable.font = [UIFont systemFontOfSize:12];
        contentLable.text = [NSString stringWithFormat:@"%@",commentStr];
        contentLable.textColor = [UIColor colorWithRed:240.0/256.0 green:26.0/256.0 blue:98.0/256.0 alpha:1.0];
        
        secondBack.frame =CGRectMake(0, 0, 0, 0);
        secondImage.frame =CGRectMake(0, 0, 0, 0);
        introduceView2.frame=CGRectMake(0, 0, 0, 0);
        likeAmount2.frame =CGRectMake(0, 0, 0, 0);
        secondButton.frame = CGRectMake(0, 0, 0, 0);
        voteLable2.frame = CGRectMake(0, 0, 0, 0);
        contentLable2.frame = CGRectMake(0, 0, 0, 0);
        textV.frame=CGRectMake(0, 0, 0, 0);
    }
    else if (index%2==1)
    {
        
        UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
        NSString * headStr= [dic objectForKey:@"work_image"];
//        NSString * contentStr = [dic objectForKey:@"content"];
        NSString * likeStr = [dic objectForKey:@"votes"];
        NSString * commentStr = [dic objectForKey:@"rank"];
        NSLog(@"headStr22222:%@",headStr);
        
        secondBack.frame =CGRectMake(163, 5, 152, 230);
        secondBack.backgroundColor = [UIColor colorWithRed:243.0/256.0 green:242.0/256.0 blue:241.0/256.0 alpha:1.0];
        // 下载图片
        [secondImage setImageURLStr:headStr placeholder:placeholder];

//        secondImage.image=[dic objectForKey:@"image"];
        
        // 事件监听
        secondImage.tag = index;
        secondImage.userInteractionEnabled = YES;
        [secondImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        secondImage.clipsToBounds = YES;
        secondImage.contentMode = UIViewContentModeScaleAspectFill;
        secondImage.frame =CGRectMake(5, 5, 142, 165);
        
//        UIFont *font = [UIFont systemFontOfSize:10.0];
//        //设置一个行高上限
//        CGSize size = CGSizeMake(120,200);
//        //计算实际frame大小，并将label的frame变成实际大小
//        CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
//        introduceView2.frame = CGRectMake(0, secondImage.frame.size.height, 130, secondBack.frame.size.height-5-secondImage.frame.size.height);
//        contentLable2.text = contentStr;
//        contentLable2.numberOfLines = 0;
//        contentLable2.font = [UIFont systemFontOfSize:10];
//        contentLable2.textColor = [UIColor whiteColor];
//        contentLable2.frame = CGRectMake(2, 3, labelsize.width, labelsize.height);
        
        introduceView2.frame = CGRectMake(0,secondImage.frame.size.height+secondImage.frame.origin.y, 142,secondBack.frame.size.height-secondImage.frame.size.height-secondImage.frame.origin.y);
//        likeImage2.frame = CGRectMake(15, 2, 10, 10);
        likeAmount2.frame =CGRectMake(115, 5, 40, 25);
        likeAmount2.font = [UIFont systemFontOfSize:14];
        likeAmount2.text = [NSString stringWithFormat:@"%@",likeStr];
        likeAmount2.textColor = [UIColor colorWithRed:240.0/256.0 green:26.0/256.0 blue:98.0/256.0 alpha:1.0];
        
        secondButton.frame = CGRectMake(5, 5, 60, 25);
        secondButton.tag = index;
        secondButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [secondButton addTarget:self action:@selector(give:) forControlEvents:UIControlEventTouchUpInside];
        
        voteLable2.frame = CGRectMake(15+secondButton.frame.size.width,5, 70, 25);
        voteLable2.font = [UIFont systemFontOfSize:14];
        voteLable2.textColor = [UIColor blackColor];
        
        commentLable2.frame = CGRectMake(5,secondButton.frame.origin.y+secondButton.frame.size.height, 132, 30);
        commentLable2.font = [UIFont systemFontOfSize:12];
        commentLable2.text = [NSString stringWithFormat:@"发型榜第一季 排名:"];
        commentLable2.textColor = [UIColor blackColor];
        
        contentLable2.frame = CGRectMake(115,secondButton.frame.origin.y+secondButton.frame.size.height, 50, 30);
        contentLable2.font = [UIFont systemFontOfSize:12];
        contentLable2.text = [NSString stringWithFormat:@"%@",commentStr];
        contentLable2.textColor = [UIColor colorWithRed:240.0/256.0 green:26.0/256.0 blue:98.0/256.0 alpha:1.0];
        
        textV.frame=CGRectMake(0, 0, 0, 0);
    }
  
    
    
    
    

}

-(void)setSingleCell
{
    firstBack.frame=CGRectMake(0, 0, 0, 0);
    secondBack.frame=CGRectMake(0, 0, 0, 0);
     firstImage.frame=CGRectMake(0, 0, 0, 0);
     secondImage.frame=CGRectMake(0, 0, 0, 0);
    introduceView.frame=CGRectMake(0, 0, 0, 0);
    firstButton.frame=CGRectMake(0, 0, 0, 0);
    contentLable.frame=CGRectMake(0, 0, 0, 0);
    commentLable.frame=CGRectMake(0, 0, 0, 0);
      likeBackground.frame=CGRectMake(0, 0, 0, 0);
      likeImage.frame=CGRectMake(0, 0, 0, 0);
     voteLable.frame=CGRectMake(0, 0, 0, 0);
      likeAmount.frame=CGRectMake(0, 0, 0, 0);
    
      introduceView2.frame=CGRectMake(0, 0, 0, 0);
      secondButton.frame=CGRectMake(0, 0, 0, 0);
      contentLable2.frame=CGRectMake(0, 0, 0, 0);
     commentLable2.frame=CGRectMake(0, 0, 0, 0);
      likeBackground2.frame=CGRectMake(0, 0, 0, 0);
      likeImage2.frame=CGRectMake(0, 0, 0, 0);
    voteLable2.frame=CGRectMake(0, 0, 0, 0);
    
    likeAmount2.frame=CGRectMake(0, 0, 0, 0);
    
    
    textV.text=[NSString stringWithFormat:@"   活动简介：发型屋超级发型榜自诞生之日就带着时尚，众多发型师和发型达人，在此汇集比拼，好看发型脱颖而出，此评选横跨移动互联两个网络平台，评选过程完全以用户投票为主多少为标准，谁能够成为前三甲，就从你点击的这一刻开始。\n\n   活动时间：一月一季，即2014年4月1日-2014年4月30日为第一季，2014年5月1日-2014年4月31日为第2季，以此类推。\n\n   参与方式：手机发型屋应用、发型屋网站，上传发型照片即可参与秀发型大赛，发型屋应用投票方式，'我型我秀'页面点击投票按钮即可；发型屋网站投票方式，“秀发型”面点击投票按钮即可。\n\n   参与要求：不得上传非照片本人授权的发型图片；个人资料中填写真实信息，以免官方无法与之联系；参与者上传图片必须清晰且是正面。\n\n   活动奖品：超级发型榜每季前三甲，由发型屋官方提供奖品，每季奖品以每季实际奖品为准，详细查看，www.faxingwu.com"];
 
    textV.frame=CGRectMake(0, 0, 320, 460);
    
}
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [fatherView selectImage:tap.view.tag];
}

-(void)give:(UIButton * )_btn
{
  [fatherView selectVote:_btn.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
