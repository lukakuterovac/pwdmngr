//
//  SensorDataViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import Foundation
import CoreMotion
import CoreLocation

class SensorDataViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let motionManager = CMMotionManager()
    private let locationManager = CLLocationManager()
    
    @Published var accelerometerData: CMAccelerometerData?
    @Published var gyroscopeData: CMGyroData?
    @Published var locationData: CLLocation?
    
    override init() {
        super.init()
        startSensors()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func startSensors() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                guard let data = data, error == nil else { return }
                self?.accelerometerData = data
            }
        }
        
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: .main) { [weak self] data, error in
                guard let data = data, error == nil else { return }
                self?.gyroscopeData = data
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationData = location
        }
    }
    
    func generateSensorSeed() -> UInt64 {
        let accelerometer = accelerometerData
        let gyroscope = gyroscopeData
        let location = locationData
        
        var seed: UInt64 = 0
        
        if let accel = accelerometer {
            seed ^= UInt64(abs(accel.acceleration.x * 1_000_000).rounded())
            seed ^= UInt64(abs(accel.acceleration.y * 1_000_000).rounded())
            seed ^= UInt64(abs(accel.acceleration.z * 1_000_000).rounded())
        }
        
        if let gyro = gyroscope {
            seed ^= UInt64(abs(gyro.rotationRate.x * 1_000_000).rounded())
            seed ^= UInt64(abs(gyro.rotationRate.y * 1_000_000).rounded())
            seed ^= UInt64(abs(gyro.rotationRate.z * 1_000_000).rounded())
        }
        
        if let loc = location {
            seed ^= UInt64(abs(loc.coordinate.latitude * 1_000_000).rounded())
            seed ^= UInt64(abs(loc.coordinate.longitude * 1_000_000).rounded())
            seed ^= UInt64(abs(loc.altitude * 1_000_000).rounded())
        }
        
        let currentTime = UInt64(Date().timeIntervalSince1970 * 1_000_000)
        seed ^= currentTime
        
        return seed
    }
}
