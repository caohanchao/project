//
//  ViewController.m
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#define CONTENT_WIDTH_FLOAT 300

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NoticeModel *noticeModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIButton *but1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
//    [but1 setTitle:@"Fetch Data!" forState:UIControlStateNormal];
//    [but1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [but1 addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview: but1];
    NSLog(@"12344");
    NSLog(@"23333");
    
    [self.view addSubview:self.tableView];
    
    [self setNavigationBar];
    
    [self readFromFile:@"notice"];
    
}


// MARK: Set navigation bar
-(void)setNavigationBar{
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"服务通知";
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"chevron.left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarPressed)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor systemGrayColor];
    
}

-(void)leftBarPressed{
    NSLog(@"Left bar buttom pressed!");
}


// MARK: Lazy load for properties
-(UITableView *)tableView{
    if(!_tableView){
        CGFloat statusHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;

        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - statusHeight - navHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor systemGray6Color];
        _tableView.separatorStyle = UITableViewStylePlain;
        
        [_tableView registerClass:[NotificationCell class] forCellReuseIdentifier:NSStringFromClass([NotificationCell class])];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

// MARK: Methods for UITableView delegate and UITableView dataSourcs
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
    return self.noticeModel == nil ? 10 : self.noticeModel.noticeList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 300;
    if(self.noticeModel == nil){
        return 300;
    }
    NSNumber *num = [self.noticeModel.heightsList objectAtIndex:indexPath.row];
  
    return num.floatValue + 190;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotificationCell class])];
    if(self.noticeModel != nil){
        NSLog(@"诶嘿");
        [cell setCellWithNoticeModel:[self.noticeModel.noticeList objectAtIndex:indexPath.row]];
    }
    return cell;
}

// MARK: Local storage related
-(void)readFromFile:(NSString *)fileName{
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"%@", homeDir);
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *file = [NSString stringWithFormat:@"%@/%@.json", documentsPath, fileName];

    NSData *data = [[NSData alloc] initWithContentsOfFile:file];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"%@", dic);

    NoticeModel *noticeModel = [[NoticeModel alloc] initWithDictionary:dic error:nil];
    [noticeModel calculateLinesForEachNoticeWithWidth:CONTENT_WIDTH_FLOAT andFont:15];
    NSLog(@"linesArr: %@", noticeModel.heightsList);
    
    self.noticeModel = noticeModel;
}

// MARK: Networking Related
- (void)fetchData{
    
    NSLog(@"我要开始抓数据啦！");
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *URLString = @"http://118.31.222.92/notice/service-notice-list";
    NSDictionary *parameters = @{@"userID":@80830, @"userKey":@"HFY5W2XodQeegNlgCKjDKlh2g6lzqoeu", @"tailID":@80830};
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    
    NSURLSessionTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error occurs: %@", error);
            return;
        }
        else{
            NSLog(@"Received response: %@", response);
            NSLog(@"Received object: %@", responseObject);
        }
    }];
    
    [dataTask resume];
}

@end
