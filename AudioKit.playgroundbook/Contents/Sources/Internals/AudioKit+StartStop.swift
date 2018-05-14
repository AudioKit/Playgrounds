//
//  AudioKit+StartStop.swift
//  AudioKit
//
//  Created by Jeff Cooper on 4/20/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import Foundation
import AVFoundation


import CoreAudioKit
import UIKit
import Dispatch

extension AudioKit {

    // MARK: - Start/Stop

    /// Start up the audio engine
    @objc open static func start() throws {
        if output == nil {
            AKLog("No output node has been set yet, no processing will happen.")
        }
        // Start the engine.
        engine.prepare()

        try updateSessionCategoryAndOptions()
        try AVAudioSession.sharedInstance().setActive(true)

        try engine.start()
        shouldBeRunning = true
    }

    @objc internal static func updateSessionCategoryAndOptions() throws {
        let sessionCategory = AKSettings.computedSessionCategory()

        let sessionOptions = AKSettings.computedSessionOptions()
        try AKSettings.setSession(category: sessionCategory,
                                  with: sessionOptions)
    }

    /// Stop the audio engine
    @objc open static func stop() throws {
        // Stop the engine.
        engine.stop()
        shouldBeRunning = false

        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            AKLog("couldn't stop session \(error)")
            throw error
        }
    }
}
