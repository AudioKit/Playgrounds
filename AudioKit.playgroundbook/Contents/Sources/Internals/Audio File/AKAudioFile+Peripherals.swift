//
//  AKAudioFile+Peripherals.swift
//  AudioKit
//
//  Created by Aurelius Prochazka and Laurent Veliscek, revision history on GitHub.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import Foundation
import AVFoundation

extension AKAudioFile {

    /// Create an AKAppleSampler loaded with the current AKAudioFile
    public var sampler: AKAppleSampler? {
        let fileSampler = AKAppleSampler()
        do {
            try fileSampler.loadAudioFile(self)
        } catch let error as NSError {
            AKLog("ERROR AKAudioFile: cannot create sampler: \(error)")
        }
        return fileSampler
    }
}
