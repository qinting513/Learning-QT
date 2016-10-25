//
//  BluetoothListViewController.m
//  CoreBluetooth
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "BluetoothListViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "CentralView.h"

@interface BluetoothListViewController ()<UITableViewDataSource,UITableViewDelegate, CBCentralManagerDelegate,CBPeripheralDelegate>
//系统蓝牙设备管理对象，可以把他理解为主设备，通过他，可以去扫描和链接外设
@property (nonatomic,strong) CBCentralManager  *centralManager;
//已经连接的外设
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) NSMutableArray  *allPeripherals;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) CentralView  *centralView;

@property (nonatomic,strong) NSMutableArray  *allServices;
@end

@implementation BluetoothListViewController

#pragma mark - lazy
-(NSMutableArray *)allPeripherals{
    if (!_allPeripherals) {
        _allPeripherals = [NSMutableArray array];
    }
    return _allPeripherals;
}

-(NSMutableArray *)allServices{
    if(!_allServices){
        _allServices = [NSMutableArray array];
        
    }
    return _allServices;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCentralManager];
}


// 1.初始化中心设备
- (void)initCentralManager {
    //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
    CBCentralManager *centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    
    self.centralManager = centralManager;
}
// 2. 扫描外设（discover），扫描外设的方法我们放在centralManager成功打开的委托中，因为只有设备成功打开，才能开始扫描，否则会报错
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            //开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            break;
    }
}

// 3.连接外设(connect)
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    //接下连接我们的测试设备，如果你没有设备，可以下载一个app叫lightbule的app去模拟一个设备
    //这里自己去设置下连接规则，我设置的是BT开头的设备
    NSLog(@"peripheral: %@ -- %@",peripheral.name,RSSI.stringValue);
    if (peripheral.name.length > 0) {
        [self.allPeripherals addObject:peripheral];
        [self.tableView reloadData];
    }
    //    if ([peripheral.name hasPrefix:@"BT"]){
    //        /*
    //         一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
    //         - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
    //         - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
    //         - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
    //         */
    //        //连接设备
    //        [self.centralManager connectPeripheral:peripheral options:nil];
    //    }
}


#pragma mark - dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.allPeripherals.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CBPeripheral* peripheral = self.allPeripherals[indexPath.row];
    cell.textLabel.text = peripheral.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        CBPeripheral* peripheral = self.allPeripherals[indexPath.row];
        if ([peripheral.name hasPrefix:@"BT"]){
            //连接设备
            [self.centralManager connectPeripheral:peripheral options:nil];
        }
}

// 4.连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    self.peripheral = peripheral;
    self.centralView = [CentralView loadView];
    self.centralView.frame = self.view.bounds;
    [self.view addSubview:self.centralView];
    [self.centralView.sendMsgButton addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    [self.centralView.dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //5.链接成功后 扫描服务
      [peripheral discoverServices:nil];
}

-(void)sendMsg{

}
-(void)dismissBtnClick{
//    NSLog(@"==============dismiss==========");
    if(self.peripheral){
        [self.centralManager cancelPeripheralConnection:self.peripheral];
    }
    [self.centralView removeFromSuperview];
}
//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
}

// 6.扫描到服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [self.allServices addObject:service];
        [peripheral discoverCharacteristics:nil forService:service];
    }
}


// 7.获取Characteristics的值，获取Characteristics的Descriptor和Descriptor的值
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        {
            NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
    
    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
    
}

//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
    
}

//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
    
}
//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}

//把数据写到Characteristic中
//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast= 0x01,
     CBCharacteristicPropertyRead= 0x02,
     CBCharacteristicPropertyWriteWithoutResponse= 0x04,
     CBCharacteristicPropertyWrite= 0x08,
     CBCharacteristicPropertyNotify= 0x10,
     CBCharacteristicPropertyIndicate= 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites= 0x40,
     CBCharacteristicPropertyExtendedProperties= 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)= 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)= 0x200
     };
     
     */
    NSLog(@"%lu", (unsigned long)characteristic.properties);
    
    
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        NSLog(@"该字段不可写！");
    }
    
    
}

//订阅Characteristic的通知
//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//断开连接(disconnect)
//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}
@end
