import QtQuick 2.0

Item {
	id: gameArea
	anchors.fill: parent

	Item {
		id: background
		anchors.fill: parent
		z: -1
		state: "none"
		property alias source: imageBackground.source

		Rectangle {
			id: colorBackground
			anchors.fill: parent
			color: "white"
			visible: false
		}

		Image {
			id: imageBackground
			anchors.fill: parent
			source: ""
			visible: false
		}

		states: [
			State {
				name: "color"
				PropertyChanges {
					target: colorBackground
					visible: true
				}
				PropertyChanges {
					target: imageBackground
					visible: false
				}
			},
			State {
				name: "image"
				PropertyChanges {
					target: colorBackground
					visible: false
				}
				PropertyChanges {
					target: imageBackground
					visible: true
				}
			},
			State {
				name: "none"
				PropertyChanges {
					target: colorBackground
					visible: false
				}
				PropertyChanges {
					target: imageBackground
					visible: false
				}
			}
		]
	} // End of Item:background

	Item {
		id: scene
		anchors.fill: parent
	}
}
