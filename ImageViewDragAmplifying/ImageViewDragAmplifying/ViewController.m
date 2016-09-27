//
//  ViewController.m
//  ImageViewDragAmplifying
//
//  Created by 柳耀斌 on 2016/9/27.
//  Copyright © 2016年 柳耀斌. All rights reserved.
//

#import "ViewController.h"

#define  WIDTH [UIScreen mainScreen].bounds.size.width

#define  HEIGHT [UIScreen mainScreen].bounds.size.height

#define  headHeight 300

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *tb11;
    
    UIImageView *iv11;
    
    CGRect ivFrame;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tb11=[[UITableView alloc]initWithFrame:CGRectMake(0, headHeight, WIDTH, HEIGHT-headHeight) style:UITableViewStylePlain];
    tb11.delegate=self;
    tb11.dataSource=self;
    tb11.showsVerticalScrollIndicator=NO;
    tb11.showsHorizontalScrollIndicator=NO;
    //    tb11.tableHeaderView=iv11;
    [self.view addSubview:tb11];
    
    iv11=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, headHeight)];
    iv11.backgroundColor=[UIColor redColor];
    iv11.image=[UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview:iv11];
    
    ivFrame =iv11.frame;
    
}
#pragma mark -
#pragma mark UITableView dataSourse and delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 18;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=[NSString stringWithFormat:@"++++++%ld",indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //通过滑动的便宜距离重新给图片设置大小
    CGFloat yOffset = scrollView.contentOffset.y;
    NSLog(@"yOffset=%f",yOffset);
    if(yOffset<0)
    {
        
        CGRect frame= iv11.frame;
        frame.origin.y= yOffset/2;
        frame.origin.x= yOffset/2;
        frame.size.height = -yOffset+ivFrame.size.height;
        frame.size.width = -yOffset+ivFrame.size.width;
        iv11.frame = frame;
        
    }
    else if (yOffset>0 && yOffset<headHeight )
    {
        CGRect frame1=iv11.frame;
        frame1.origin.y=-yOffset;
        
        iv11.frame=frame1;
        
        //tableView
        CGRect frame2=CGRectMake(0, CGRectGetMaxY(iv11.frame), WIDTH, HEIGHT);
        frame1.origin.y=yOffset;
        tb11.frame=frame2;
        
    }
    else if (yOffset>headHeight)
    {
        tb11.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
