//: ## AutoPanner
//:
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: playgroundAudioFiles[0])
let player = try AKAudioPlayer(file: file)
player.looping = true

let osc = AKOscillator()
let effect = AKAutoPanner(osc)

effect.depth = 1
effect.frequency = 1
AKManager.output = effect
try AKManager.start()
//player.play()
osc.start()

import AudioKitUI

class LiveView: AKLiveViewController {

    override func viewDidLoad() {
        addTitle("AutoPanner")

        addView(AKResourcesAudioFileLoaderView(player: player, filenames: playgroundAudioFiles))

        addView(AKSlider(property: "Frequency", value: effect.frequency, range: 0.1 ... 25) { sliderValue in
            effect.frequency = sliderValue
        })

        addView(AKSlider(property: "Depth", value: effect.depth) { sliderValue in
            effect.depth = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = LiveView()
