//
//  JCBluetoothManager.m
//  图灵机器人
//
//  Created by Guo.JC on 16/9/11.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCBluetoothManager.h"

static JCBluetoothManager *_manager;
static CBCentralManager *_myCentralManager;


@implementation JCBluetoothManager

/*创建中心设备单例*/
+ (JCBluetoothManager *)shareCBCentralManager
{
    @synchronized(self) {
        if (!_manager) {
            _manager = [[JCBluetoothManager alloc]init];
            _myCentralManager = [[CBCentralManager alloc] initWithDelegate:_manager queue:nil];//如果设置为nil，默认在主线程中跑
        }
    }
    return _manager;
}

#pragma mark 【2】监测蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central

{
    switch (central.state)
    {
        case CBCentralManagerStateUnknown:
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"模拟器不支持蓝牙调试");
            break;
        case CBCentralManagerStateUnauthorized:
            break;
        case CBCentralManagerStatePoweredOff:{
            NSLog(@"蓝牙处于关闭状态");
        }
            break;
        case CBCentralManagerStateResetting:
            break;
        case CBCentralManagerStatePoweredOn:
        {
            NSLog(@"蓝牙已开启");//                         此处填写特定的UUID（即特定蓝牙）
            [_myCentralManager  scanForPeripheralsWithServices:nil  options:nil];//开启蓝牙后扫描设备，扫描蓝牙设备,扫描设备定制
        }
            break;
    }
}
#pragma mark 【3】发现外部设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
//    [_myCentralManager stopScan];
//    NSLog(@"能发现设备:%@--%@",peripheral.name,advertisementData);
    
    if (![peripheral.name isEqual:[NSNull null]]) {
        if(![self.allperipherals containsObject:peripheral]){
            [self.allperipherals addObject:peripheral];
            //        NSLog(@"添加设备%@，信号：%@",peripheral.name,RSSI);
        }
        [self.delegate foundPeripheral:self peripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
        [[NSNotificationCenter defaultCenter]postNotificationName:kFoundBluetoothPeripheral object:peripheral];//发出发现蓝牙设备通知
    }

}
#pragma mark 【4】连接外部蓝牙设备
- (void)connectToPeripheral:(CBPeripheral *)peripheral
{
//    NSLog(@"连接蓝牙：%@",peripheral.name);
    [[NSNotificationCenter defaultCenter]postNotificationName:kConnectBluetoothPeripheral object:peripheral.name];//发出正在连接蓝牙设备通知
    [_myCentralManager connectPeripheral:peripheral options:nil];//连接蓝牙
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CBPeripheral *peripheral = self.allperipherals[indexPath.row];
//    NSLog(@"连接蓝牙：%@",peripheral.name);
//    [[NSNotificationCenter defaultCenter]postNotificationName:kConnectBluetoothPeripheral object:peripheral.name];//发出正在连接蓝牙设备通知
//    [_myCentralManager connectPeripheral:peripheral options:nil];//连接蓝牙
//}
#pragma mark 【5】连接外部蓝牙设备成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
//    NSLog(@"成功连接%@",peripheral.name);
    self.currentPeripheral = peripheral;
    peripheral.delegate = self;
    self.allServers = [NSMutableArray array];
    //外围设备开始寻找服务
    [peripheral discoverServices:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kConnectSucceed object:peripheral.name];//发出连接蓝牙设备成功通知

}
#pragma mark 连接外部蓝牙设备失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{//如何实现自动断线重连，就是在断开的委托方法中，执行连接蓝牙的方法  可以在此处重新调用连接蓝牙方法
//    NSLog(@"连接%@失败--error:%@",peripheral.name,error);
    [[NSNotificationCenter defaultCenter]postNotificationName:kConnectFailed object:peripheral.name];//发出连接蓝牙设备失败通知
}



#pragma mark - CBPeripheral 外设代理方法
//外围设备寻找到服务后
//-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
//    NSLog(@"已发现可用服务...");
//    [self writeToLog:@"已发现可用服务..."];
//    if(error)
//    {
//        NSLog(@"外围设备寻找服务过程中发生错误，错误信息：%@",error.localizedDescription);
//        [self writeToLog:[NSString stringWithFormat:@"外围设备寻找服务过程中发生错误，错误信息：%@",error.localizedDescription]];
//    }
//    //遍历查找到的服务
//    CBUUID *serviceUUID=[CBUUID UUIDWithString:kServiceUUID];
//    CBUUID *characteristicUUID=[CBUUID UUIDWithString:kCharacteristicUUID];
//    for (CBService *service in peripheral.services) {
//        if([service.UUID isEqual:serviceUUID]){
//            //外围设备查找指定服务中的特征
//            [peripheral discoverCharacteristics:@[characteristicUUID] forService:service];
//        }
//    }
//}
#pragma mark 【6】寻找蓝牙服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error)
    {
        NSLog(@"发现服务错误 : %@", [error localizedDescription]);
        return;
    }
    
    NSLog(@"已发现可用服务...");
    for (CBService *s in peripheral.services)//遍历外设中找到的服务
    {
        NSLog(@"Service found with UUID : %@", s.UUID);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"secName":s.UUID.description}];
        [self.allServers addObject:dic];
        [s.peripheral discoverCharacteristics:nil forService:s];
    }
}
#pragma mark 【7】寻找蓝牙服务中的特性
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {//报错直接返回退出
        NSLog(@"didDiscoverCharacteristicsForService error : %@", [error localizedDescription]);
        return;
    }
//    NSLog(@"发现的服务：%@",service);
    
    self.allcharacteristic = [NSMutableArray array];//创建数组用于保存特性
    
    for (CBCharacteristic *characteristic in service.characteristics)//遍历服务中的所有特性
    {
        [self.allcharacteristic addObject:characteristic];
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        self.characteristicNum++;
        [peripheral readValueForCharacteristic:characteristic];
        if (characteristic.value) {
            NSString *value=[[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
            NSLog(@"读取到特征值：%@",value);
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kBluetoothPeripheralCanUse object:peripheral.name];//发出蓝牙外设可用通知
}


#pragma mark 特征值被更新后
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//    NSLog(@"收到特征更新通知...");
//    if (error) {
//        NSLog(@"更新通知状态时发生错误，错误信息：%@",error.localizedDescription);
//    }
    //给特征值设置新的值
//    CBUUID *characteristicUUID=[CBUUID UUIDWithString:kCharacteristicUUID];
    
//    if ([characteristic.UUID isEqual:characteristicUUID]) {
//        if (characteristic.isNotifying) {
//            if (characteristic.properties==CBCharacteristicPropertyNotify) {
//                NSLog(@"已订阅特征通知.");
//                return;
//            }else if (characteristic.properties ==CBCharacteristicPropertyRead) {
//                //从外围设备读取新值,调用此方法会触发代理方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//                [peripheral readValueForCharacteristic:characteristic];
//            }
    
//        }else{
//            NSLog(@"停止已停止.");
//            //取消连接
//            [_myCentralManager cancelPeripheralConnection:peripheral];
//        }
//    }
//}
//更新特征值后（调用readValueForCharacteristic:方法或者外围设备在订阅后更新特征值都会调用此代理方法）
#pragma mark 特征值被更新后(收到外设数据)
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@"更新特征值时发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    if (characteristic.value) {
        NSString *value=[[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
//        NSLog(@"读取到特征值：%@",value);
        [self.delegate receivePeripheralData:self receiveString:value];
        [[NSNotificationCenter defaultCenter]postNotificationName:kReceiveBluetoothPeripheralData object:value];//发出收到蓝牙外设数据通知
    }else{
        NSLog(@"未发现特征值.");
    }
}

#pragma mark 发送数据
-(void)sendString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    for (int i = 0; i < self.allcharacteristic.count; i++) {
        CBCharacteristic *characteristic = self.allcharacteristic[i];
        
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]])
//        {
            [self.currentPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
//        }
    }

}

- (void)scan
{
    [_myCentralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:NO]}];
}



//#pragma mark -----------------------------------------作为外设设备时-----------------------------------------
//- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
//{
//    NSLog(@"作为外设设备");
//}
@end
