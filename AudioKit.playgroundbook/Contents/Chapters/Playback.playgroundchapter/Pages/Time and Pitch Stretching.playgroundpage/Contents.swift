//: # Time and Pitch Stretching

let file = try AKAudioFile(readFileName: audioFiles[0],
                           baseDir: .resources)

let player = try AKAudioPlayer(file: file)
player.looping = true

var timePitch = AKTimePitch(player)
timePitch.rate = 2.0
timePitch.pitch = -400.0
timePitch.overlap = 8.0

AudioKit.output = timePitch
AudioKit.start()

//#-hidden-code

class PlaygroundView: AKPlaygroundView {

    override func setup() {
        addTitle("Time/Pitch")

        addSubview(AKResourcesAudioFileLoaderView(
            player: player,
            filenames: audioFiles))

        addLabel("Time/Pitch Parameters")

        addSubview(AKBypassButton(node: timePitch))

        addSubview(AKPropertySlider(
            property: "Rate",
            format: "%0.3f",
            value: timePitch.rate, minimum: 0.3125, maximum: 5,
            color: AKColor.green
        ) { sliderValue in
            timePitch.rate = sliderValue
        })

        addSubview(AKPropertySlider(
            property: "Pitch",
            format: "%0.3f Cents",
            value: timePitch.pitch, minimum: -2400, maximum: 2400,
            color: AKColor.red
        ) { sliderValue in
            timePitch.pitch = sliderValue
        })

        addSubview(AKPropertySlider(
            property: "Overlap",
            value: timePitch.overlap, minimum: 3, maximum: 32,
            color: AKColor.cyan
        ) { sliderValue in
            timePitch.overlap = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()


PlaygroundPage.current.needsIndefiniteExecution = true
//#-end-hidden-code
