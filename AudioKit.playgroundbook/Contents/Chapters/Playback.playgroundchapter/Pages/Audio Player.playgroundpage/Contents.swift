//: ## Audio Player
//:
//#-hidden-code
import PlaygroundSupport
//#-end-hidden-code

let mixloop = try AKAudioFile(readFileName: "mixloop.wav", baseDir: .resources)

let player = try AKAudioPlayer(file: mixloop) {
    print("completion callback has been triggered !")
}

AudioKit.output = player
AudioKit.start()
player.looping = true

//#-hidden-code

class PlaygroundView: AKPlaygroundView {

    // UI Elements we'll need to be able to access
    var inPositionSlider: AKPropertySlider?
    var outPositionSlider: AKPropertySlider?
    var playingPositionSlider: AKPropertySlider?

    override func setup() {

        AKPlaygroundLoop(every: 1/60.0) {
            if player.duration > 0 {
                self.playingPositionSlider?.value = player.playhead
            }

        }
        addTitle("Audio Player")

        addSubview(AKResourcesAudioFileLoaderView(
            player: player,
            filenames: ["mixloop.wav", "drumloop.wav", "bassloop.wav", "guitarloop.wav", "leadloop.wav"]))

        addSubview(AKButton(title: "Disable Looping") {
            player.looping = !player.looping
            if player.looping {
                return "Disable Looping"
            } else {
                return "Enable Looping"
            }})

        inPositionSlider = AKPropertySlider(
            property: "In Position",
            format: "%0.2f s",
            value: player.startTime, maximum: 3.428,
            color: AKColor.green
        ) { sliderValue in
            player.startTime = sliderValue
        }
        addSubview(inPositionSlider!)

        outPositionSlider = AKPropertySlider(
            property: "Out Position",
            format: "%0.2f s",
            value: player.endTime, maximum: 3.428
        ) { sliderValue in
            player.endTime = sliderValue
        }
        addSubview(outPositionSlider!)

        playingPositionSlider = AKPropertySlider(
            property: "Position",
            format: "%0.2f s",
            value: player.playhead, maximum: 3.428,
            color: AKColor.yellow
        ) { sliderValue in
            // Can't do player.playhead = sliderValue
        }
        addSubview(playingPositionSlider!)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()
//#-end-hidden-code
