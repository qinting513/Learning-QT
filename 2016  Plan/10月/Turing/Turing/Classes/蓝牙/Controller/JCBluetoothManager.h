//
//  JCBluetoothManager.h
//  图灵机器人
//
//  Created by Guo.JC on 16/9/11.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


//#define kCharacteristicUUID @"365FA1BD-344C-BA19-3781-78DC785CAEAD" //外设特征的UUID
//#define kServiceUUID @"FFE1" //服务的UUID

#define kFoundBluetoothPeripheral           @"foundBluetoothPeripheral"
#define kConnectBluetoothPeripheral         @"connectBluetoothPeripheral"
#define kConnectSucceed                     @"connectSucceed"
#define kConnectFailed                      @"connectFailed"
#define kBluetoothPeripheralCanUse          @"bluetoothPeripheralCanUse"
#define kReceiveBluetoothPeripheralData     @"receiveBluetoothPeripheralData"

@class JCBluetoothManager;

typedef void(^BLOCK) (id state);

@protocol JCBluetoothManagerDelegate <NSObject>
@required
/*发现设备*/
- (void)foundPeripheral:(JCBluetoothManager *)manager peripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
/*收到新数据*/
- (void)receivePeripheralData:(JCBluetoothManager *)manager receiveString:(NSString *)string;
/*连接蓝牙设备*/
//- (void)connectToPeripheral:(JCBluetoothManager *)manager connect:(CBPeripheral *)peripheral completion:(BLOCK)state;
@optional

@end


@interface JCBluetoothManager : NSObject<
                                            CBPeripheralManagerDelegate,//作为外围设备，用的少
                                            CBCentralManagerDelegate,   //【作为中央设备】

                                            CBPeripheralDelegate        //外设代理
                                        >


@property (nonatomic, strong) NSMutableArray *allperipherals;
@property (nonatomic, strong) CBPeripheral   *currentPeripheral;
@property (nonatomic, strong) NSMutableArray *allServers;
@property (nonatomic, strong) NSMutableArray *allcharacteristic;
@property (nonatomic, assign) int             characteristicNum;
@property (nonatomic, strong) id <JCBluetoothManagerDelegate> delegate;


+ (JCBluetoothManager *)shareCBCentralManager;

- (void)connectToPeripheral:(CBPeripheral *)peripheral;

- (void)sendString:(NSString *)string;

- (void)scan;
@end
