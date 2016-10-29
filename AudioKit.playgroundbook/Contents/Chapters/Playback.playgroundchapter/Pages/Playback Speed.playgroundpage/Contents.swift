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

//#-hidden-code

//: User Interface Set up

class PlaygroundView: AKPlaygroundView {

    override func setup() {
        addTitle("Playback Speed")

        addSubview(AKResourcesAudioFileLoaderView(
            player: player,
            filenames: audioFiles))

        addSubview(AKBypassButton(node: variSpeed))

        addSubview(AKPropertySlider(
            property: "Rate",
            format: "%0.3f",
            value: variSpeed.rate, minimum: 0.3125, maximum: 5,
            color: AKColor.green
        ) { sliderValue in
            variSpeed.rate = sliderValue
            })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()


PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code