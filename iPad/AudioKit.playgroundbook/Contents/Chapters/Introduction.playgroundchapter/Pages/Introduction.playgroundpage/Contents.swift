/*: 
 
# AudioKit High Level Design Overview

This document describes the main components of AudioKit and how they work together. We have unabashedly copied the layout, the style, and yes even the text of this document from [CorePlot's excellent High Level Design Overview](https://github.com/core-plot/core-plot/wiki/High-Level-Design-Overview).

## Design Considerations

Before delving into the components that make up AudioKit, it is worth considering the design goals of the framework. AudioKit has been developed to run on  iOS, macOS, and tvOS. Since these are not equally capable platforms, there are certain things that will be missing.  However, if a feature exists on more than one platform, the implementations will be identical.  As an example MIDI doesn't exist on tvOS so the MIDI directory is omitted from the framework project for tvOS.

AudioKit relies on several Apple technologies and several open-source audio projects.  In some cases AudioKit is a simple wrapper around AVAudioEngine's nodes, and in other cases it is much more complex than that.  The idea is that we can do any thing that AVAudioEngine can do, but a whole lot more too.

## Anatomy of an AudioKit Signal Chain

The image below gives a basic run down of how audio flows through AudioKit.  A signal chain is compromised of signal generators and signal processors.  The AKMicrophone is an input source, which can by the actual physical microphone of the phone, or any input source if you're using Inter-App Audio or Audiobus. A generator takes parameters and creates audio based on them.  An example would be a MIDI synthesizer.  A processor, or filter, takes in audio and does something to it and output a modified signal.  Finally, an output node takes audio and sends it to the speakers, headphones, or bluetooth.

## Class Diagram

Because AudioKit's tree structure is fairly flat, this is not a standard UML diagram, but more of taxonomy of the types of objects available in AudioKit.  The image is clickable when more information is available about a topic on this web site.

Another objective that is influential in the design of Core Plot is that it should behave as much as possible from a developer's perspective as a built-in framework. Design patterns and technologies used in Apple's own frameworks, such as the data source pattern, delegation, and bindings, are all supported in Core Plot.
 */
