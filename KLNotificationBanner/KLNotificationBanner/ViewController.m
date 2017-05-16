//
//  ViewController.m
//  KLNotificationBanner
//
//  Created by leqiang222 on 2017/5/16.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#import "ViewController.h"
#import "KLNotificationBanner.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
/** <#Description#> */
@property (nonatomic, copy) NSArray <NSArray *>*listArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"KLBanner";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.listArray = @[@[@"only title", @"title + message"],
                       @[@"only leftView", @"only rightView", @"leftView + rightView"]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const kCellId = @"__cellId__";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1
    NSString *title = @"病人甲:";
    NSString *message = @"医生，我头痛好厉害!";
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor blueColor];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor redColor];
    
    // 2
    KLNotificationBanner *banner = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // only title
            banner = [[KLNotificationBanner alloc] initWithTitle:title subtitle:nil leftView:nil rightView:nil style:BannerStyleDanger];
            
        }else { // title + message
            banner = [[KLNotificationBanner alloc] initWithTitle:title subtitle:message leftView:nil rightView:nil style:BannerStyleInfo];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) { // only leftView
            banner = [[KLNotificationBanner alloc] initWithTitle:title subtitle:message leftView:leftView rightView:nil style:BannerStyleSuccess];
            
        }else if (indexPath.row == 1) {
            banner = [[KLNotificationBanner alloc] initWithTitle:title subtitle:message leftView:nil rightView:rightView style:BannerStyleSuccess];
            
        }else {
            banner = [[KLNotificationBanner alloc] initWithTitle:title subtitle:message leftView:leftView rightView:rightView style:BannerStyleWarning];
        }
    }
    
    if (banner == nil) {
        return;
    }
    
    banner.duration = 1; // 条幅消失的动画时间
    
    [banner show];
    //    [banner showPlaceOnQueue:YES queuePosition:QueuePositionBack];
    
    [banner setOnTap:^() {
        [[[UIAlertView alloc] initWithTitle:@"banner 被点击了" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }];
    
    [banner setOnSwipeUp:^() {
        NSLog(@"banner 被拖拽了");
    }];
}


@end
