//: ## Playback Speed
//: This playground uses the AKVariSpeed node to change the playback speed of a file
//: (which also affects the pitch)
//:

let file = try AKAudioFile(readFileName: audioFiles[0],
                           baseDir: .resources)
let player = try AKAudioPlayer(file: file)
player.looping = true

var variSpeed = AKVariSpeed(player)
variSpeed.rate = 2.0

AudioKit.output = variSpeed
AudioKit.start()
player.play()

//hidden-code

//: User Interface Set up

class PlaygroundView: AKPlaygroundView {

    override func setup() {
        addTitle("Playback Speed")

        addSubview(AKResourcesAudioFileLoaderView(
            player: player,
            filenames: audioFiles))

        addSubview(AKBypassButton(node: variSpeed))

        addSubview(AKSlider(property: "Rate", value: variSpeed.rate, range: 0.312_5 ... 5) { sliderValue in
            variSpeed.rate = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()


PlaygroundPage.current.needsIndefiniteExecution = true
//end-hidden-code