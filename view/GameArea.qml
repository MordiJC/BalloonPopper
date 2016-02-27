import QtQuick 2.0

Item {
	id: gameArea
	anchors.fill: parent

	property alias bgtype: background.state
	property string bgvalue: "white"
	property var scene: undefined

	onSceneChanged: {
		sceneItem.children[0] = scene;
	}

	Item {
		id: background
		anchors.fill: parent
		z: -1
		state: "none"

		Rectangle {
			id: colorBackground
			anchors.fill: parent
			color: bgvalue
			visible: false
		}

		Image {
			id: imageBackground
			anchors.fill: parent
			source: bgvalue
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
		id: sceneItem
		anchors.fill: parent
	}
}
