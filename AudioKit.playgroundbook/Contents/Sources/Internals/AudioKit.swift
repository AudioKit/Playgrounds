//
//  AudioKit.swift
//  AudioKit
//
//  Created by Aurelius Prochazka, revision history on Github.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import Foundation
import AVFoundation


import CoreAudioKit
import UIKit
import Dispatch

public typealias AKCallback = () -> Void

/// Top level AudioKit managing class
@objc open class AudioKit: NSObject {

    // MARK: - Internal audio engine mechanics

    /// Reference to the AV Audio Engine
    @objc public static let engine = AVAudioEngine()

    @objc static var finalMixer = AKMixer()

    // MARK: - Device Management

    /// An audio output operation that most applications will need to use last
    @objc open static var output: AKNode? {
        didSet {
            do {
                try updateSessionCategoryAndOptions()
                output?.connect(to: finalMixer)
                engine.connect(finalMixer.avAudioNode, to: engine.outputNode)

                } catch {
                AKLog("Could not set output: \(error)")
            }
        }
    }

    /// Enumerate the list of available input devices.
    @objc open static var inputDevices: [AKDevice]? {

        var returnDevices = [AKDevice]()
        if let devices = AVAudioSession.sharedInstance().availableInputs {
            for device in devices {
                if device.dataSources == nil || device.dataSources!.isEmpty {
                    returnDevices.append(AKDevice(name: device.portName, deviceID: device.uid))
                } else {
                    for dataSource in device.dataSources! {
                        returnDevices.append(AKDevice(name: device.portName,
                                                        deviceID: "\(device.uid) \(dataSource.dataSourceName)"))
                    }
                }
            }
            return returnDevices
        }
        return nil
    }

    /// Enumerate the list of available output devices.
    @objc open static var outputDevices: [AKDevice]? {
        let devs = AVAudioSession.sharedInstance().currentRoute.outputs
        if devs.isNotEmpty {
            var outs = [AKDevice]()
            for dev in devs {
                outs.append(AKDevice(name: dev.portName, deviceID: dev.uid))
            }
            return outs
        }
        return nil
    }

    /// The name of the current input device, if available.
    @objc open static var inputDevice: AKDevice? {
        if let dev = AVAudioSession.sharedInstance().preferredInput {
            return AKDevice(name: dev.portName, deviceID: dev.uid)
        } else {
            let inputDevices = AVAudioSession.sharedInstance().currentRoute.inputs
            if inputDevices.isNotEmpty {
                for device in inputDevices {
                    let dataSourceString = device.selectedDataSource?.description ?? ""
                    let id = "\(device.uid) \(dataSourceString)".trimmingCharacters(in: [" "])
                    return AKDevice(name: device.portName, deviceID: id)
                }
            }
        }
        return nil
    }

    /// The name of the current output device, if available.
    @objc open static var outputDevice: AKDevice? {
        let devs = AVAudioSession.sharedInstance().currentRoute.outputs
        if devs.isNotEmpty {
            return AKDevice(name: devs[0].portName, deviceID: devs[0].uid)
        }

        return nil
    }

        /// Change the preferred input device, giving it one of the names from the list of available inputs.
    @objc open static func setInputDevice(_ input: AKDevice) throws {

        if let devices = AVAudioSession.sharedInstance().availableInputs {
            for device in devices {
                if device.dataSources == nil || device.dataSources!.isEmpty {
                    if device.uid == input.deviceID {
                        do {
                            try AVAudioSession.sharedInstance().setPreferredInput(device)
                        } catch {
                            AKLog("Could not set the preferred input to \(input)")
                        }
                    }
                } else {
                    for dataSource in device.dataSources! {
                        if input.deviceID == "\(device.uid) \(dataSource.dataSourceName)" {
                            do {
                                try AVAudioSession.sharedInstance().setInputDataSource(dataSource)
                            } catch {
                                AKLog("Could not set the preferred input to \(input)")
                            }
                        }
                    }
                }
            }
        }

        if let devices = AVAudioSession.sharedInstance().availableInputs {
            for dev in devices {
                if dev.uid == input.deviceID {
                    do {
                        try AVAudioSession.sharedInstance().setPreferredInput(dev)
                    } catch {
                        AKLog("Could not set the preferred input to \(input)")
                    }
                }
            }
        }

    }

    // MARK: - Disconnect node inputs

    /// Disconnect all inputs
    @objc open static func disconnectAllInputs() {
        engine.disconnectNodeInput(finalMixer.avAudioNode)
    }
}
