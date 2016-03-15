//
//  MainViewController.m
//  历史上的今天
//
//  Created by kai on 16/3/15.
//  Copyright © 2016年 K.K Studio. All rights reserved.
//

#import "MainViewController.h"
#import "TohTableViewCell.h"

#define URL @"http://api.juheapi.com/japi/toh?key= 4b19c2de376f5f945100aea3e2dfd9ed&v=1.0&month=2&day=29"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (nonatomic,strong) NSDictionary *rootDict;
@property (nonatomic,strong) NSArray *rootArray;

@end

@implementation MainViewController


- (NSDictionary *)rootDict
{
    if (!_rootDict) {
        // 通过字符串创建URL
        NSURL *url = [NSURL URLWithString:@"http://api.juheapi.com/japi/toh?key=%204b19c2de376f5f945100aea3e2dfd9ed&v=1.0&month=2&day=29"];
        // 通过URL创建网络请求
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        // 通过网络请求获取NSData数据包 使用get
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        // 解析数据
        _rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _rootArray = [_rootDict valueForKeyPath:@"result"];
    }
    return _rootDict;
}

- (NSArray *)rootArray
{
    if (!_rootArray) {
        _rootArray = [self.rootDict valueForKeyPath:@"result"];
    }
    return _rootArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellId = @"456";
    TohTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellId];
    if (!cell) {
        cell = [[TohTableViewCell alloc]init];
    }
    
    
//    cell.textLabel.text = @"消费王者";
//    cell.textLabel.text = [self.rootArray[indexPath.row] valueForKeyPath:@"des"];
    NSString *imageString = [self.rootArray[indexPath.row] valueForKeyPath:@"pic"];
    NSString *nilString = @"";
    
    if (!(imageString == nilString)) {
        cell.headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
    }
    else
    {
        cell.headImageView.image = [UIImage imageNamed:@"logo"];
    }
    
    cell.desLabel.text = [self.rootArray[indexPath.row] valueForKeyPath:@"des"];
    
    cell.idLabel.text = [self.rootArray[indexPath.row]valueForKeyPath:@"_id"];
    
    
    
//    cell.detailTextLabel.text = @"今天315";
//    cell.imageView.image = [UIImage imageNamed:@"logo"];
    return cell;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self rootArray];
    
    self.title = @"历史上的今天";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
