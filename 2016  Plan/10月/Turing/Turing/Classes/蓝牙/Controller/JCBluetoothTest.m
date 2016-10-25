//
//  JCBluetothTest2.m
//  图灵机器人
//
//  Created by Guo.JC on 16/9/7.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//


/**
 *   创建蓝牙 中央设备
 */

#import "JCBluetoothTest.h"
#import "JCBluetoothManager.h"
#import "GameViewController.h"
#import "JCBlutoothInfoModel.h"
#import "JCBlutoothCell.h"

#define ScanTimeInterval 1.0


@interface JCBluetoothTest ()   <
//                                    CBPeripheralManagerDelegate,//外围设备
//                                    CBCentralManagerDelegate,//中央设备
                                    CBPeripheralDelegate,
                                    UITableViewDataSource,
                                    UITableViewDelegate,
                                    JCBluetoothManagerDelegate
                                >

@property (strong,nonatomic) CBCentralManager * MyCentralManager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UITextView *TV;

@end

@implementation JCBluetoothTest
{
//    NSMutableArray *_allPeripheral;
    NSMutableArray *_allBlutoothModel;
    JCBluetoothManager *_manager;
    NSTimer *_scanTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TF.text = @"123";
    
    _manager = [JCBluetoothManager shareCBCentralManager];
    _manager.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    _allPeripheral = [NSMutableArray array];
    _allBlutoothModel = [NSMutableArray array];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(foundPeripherial:) name:kFoundBluetoothPeripheral object:nil];//发现设备
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(connectToPeripheral:) name:kConnectBluetoothPeripheral object:nil];//连接设备
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(connectToPeripheralSeccuss:) name:kConnectSucceed object:nil];//连接成功
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(connectToPeripheralFail:) name:kConnectFailed object:nil];//连接失败
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(peripheralCanUse:) name:kBluetoothPeripheralCanUse object:nil];//外设已准备好，可以使用
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivePeripheralData:) name:kReceiveBluetoothPeripheralData object:nil];//收到数据
 
    [self.tableView registerNib:[UINib nibWithNibName:@"JCBlutoothCell" bundle:nil] forCellReuseIdentifier:@"JCBlutoothCell"];
    
    [self startScanPeripherals];
}
#pragma mark - ScanTimer
- (void)startScanPeripherals
{
    if (!_scanTimer) {
        _scanTimer = [NSTimer timerWithTimeInterval:ScanTimeInterval target:self selector:@selector(scanForPeripherals) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_scanTimer forMode:NSDefaultRunLoopMode];
    }
    if (_scanTimer && !_scanTimer.valid) {
        [_scanTimer fire];
    }
}

- (void)scanForPeripherals
{
    [_manager scan];
}


/*发现设备*/
- (void)foundPeripheral:(JCBluetoothManager *)manager peripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
//    NSLog(@"发现蓝牙设备:%@，信号强度:%@,广播信息：\n%@\n",peripheral.name,RSSI,advertisementData);
//    NSLog(@"\n\n\n\n");
    
    JCBlutoothInfoModel *model = [[JCBlutoothInfoModel alloc]init];
    model.peripheral = peripheral;
    model.RSSI = RSSI;
    model.advertisementData = advertisementData;
    
    if (_allBlutoothModel.count == 0) {
        [_allBlutoothModel addObject:model];
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
    else{
        for (NSInteger i = 0; i < _allBlutoothModel.count; i++)
        {
            JCBlutoothInfoModel *primaryModel = _allBlutoothModel[i];
            CBPeripheral *per = primaryModel.peripheral;
            
            if ([peripheral.identifier.UUIDString isEqualToString:per.identifier.UUIDString]) {
//                isExist = YES;
                [_allBlutoothModel replaceObjectAtIndex:i withObject:model];//更新数组中的数据
                [self.tableView reloadData];
            }
        }
        if (![_allBlutoothModel containsObject:model]) {
            [_allBlutoothModel addObject:model];
            NSIndexPath *path = [NSIndexPath indexPathForRow:(_allBlutoothModel.count - 1) inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }
    
    
    
//    if(![_allPeripheral containsObject:peripheral]){
//        [_allPeripheral addObject:peripheral];
//        
//        JCBlutoothInfoModel *model = [JCBlutoothInfoModel new];
//        model.peripheral = peripheral;
//        model.RSSI = RSSI;
//        model.advertisementData = advertisementData;
//        [_allBlutoothModel addObject:model];
//        
//        [self.tableView reloadData];
//        //        NSLog(@"添加设备%@，信号：%@",peripheral.name,RSSI);
//    }
}
/*收到新数据*/
- (void)receivePeripheralData:(JCBluetoothManager *)manager receiveString:(NSString *)string
{
    NSLog(@"收到：%@",string);
}

//- (void)foundPeripherial:(NSNotification *)noti//发现设备
//{
//    CBPeripheral *peripheral = noti.object;
//    [_allPeripheral addObject:peripheral];
//    NSLog(@"*****************************************************发现外设%@",peripheral);
//    [self writeToLog:[NSString stringWithFormat:@"发现外设：%@",peripheral.name]];
//    [self.tableView reloadData];
//}

- (void)connectToPeripheral:(NSNotification *)noti//连接设备
{
    NSLog(@"*****************************************************连接外设%@",noti.object);
    [self writeToLog:[NSString stringWithFormat:@"连接外设：%@",noti.object]];
}

- (void)connectToPeripheralSeccuss:(NSNotification *)noti//连接成功
{
    NSLog(@"*****************************************************外设%@连接成功",noti.object);
    [self writeToLog:[NSString stringWithFormat:@"外设%@连接成功",noti.object]];
    GameViewController *game = [GameViewController new];
    [self.navigationController pushViewController:game animated:YES];
}

- (void)connectToPeripheralFail:(NSNotification *)noti//连接失败
{
    NSLog(@"*****************************************************外设%@连接失败",noti.object);
    [self writeToLog:[NSString stringWithFormat:@"外设%@连接失败",noti.object]];
}

- (void)peripheralCanUse:(NSNotification *)noti//设备已准备好，可以使用
{
    NSLog(@"*****************************************************外设%@可以使用",noti.object);
    [self writeToLog:[NSString stringWithFormat:@"外设%@可以使用",noti.object]];
}

- (void)receivePeripheralData:(NSNotification *)noti//收到新数据
{
//    NSLog(@"*****************************************************收到数据：%@",noti.object);
//    [self writeToLog:[NSString stringWithFormat:@"收到数据：%@",noti.object]];
}


#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allBlutoothModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCBlutoothCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JCBlutoothCell" forIndexPath:indexPath];
    cell.blutoothInfo = _allBlutoothModel[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark 【1】开启蓝牙，开始搜寻外部设备
- (IBAction)start:(UIButton *)sender {
    [self writeToLog:@"开启蓝牙，开始搜寻外部设备"];
    [JCBluetoothManager shareCBCentralManager];
}

#pragma mark 【2】连接外部蓝牙设备
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *peripheral = ((JCBlutoothInfoModel *)_allBlutoothModel[indexPath.row]).peripheral;
    NSLog(@"连接蓝牙：%@",peripheral.name);
    [self writeToLog:[NSString stringWithFormat:@"连接蓝牙：%@",peripheral.name]];
    [[JCBluetoothManager shareCBCentralManager] connectToPeripheral:peripheral];
}

#pragma mark 发送数据(发送数据到外设)
- (IBAction)send:(UIButton *)sender {
    [[JCBluetoothManager shareCBCentralManager]sendString:self.TF.text];
    [self.TF resignFirstResponder];
}

#pragma mark - 输出日志
-(void)writeToLog:(NSString *)info{
    self.TV.text=[NSString stringWithFormat:@"%@\r\n%@",self.TV.text,info];
}
//是否支持旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //只支持竖屏
    return UIInterfaceOrientationMaskPortrait;
}
@end
