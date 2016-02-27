import QtQuick 2.5
import QtQuick.Layouts 1.1

import Box2D 2.0

import "../balloons" as Balloons
import "../worldObjects" as WorldObjects

import "../scripts/utility.js" as Utility

Item {
	id: game
	anchors.fill: parent

	property int points: 30
	onPointsChanged: console.log("points: ", points)

	property Body pressedBody: null

	property var spawnTimeRange: [100, 800]

	Component.onCompleted: {
		console.log("Window: " + game.width + " : " + game.height);
		console.log("GameArea: " + gameArea.width + " : " + gameArea.height);
		console.log("StatusBar: " + statusBar.width + " : " + statusBar.height);
	}

	Timer {
		id: timerBalloonspawner
		running: false
		interval: Utility.getRandomInt(spawnTimeRange[0], spawnTimeRange[1]);
		onTriggered: {
			interval: Utility.getRandomInt(spawnTimeRange[0], spawnTimeRange[1]);
			// Dodać balona
		}
	}

	ColumnLayout {
		anchors.fill: parent

		// TODO: Dodać GameArea [X]

		GameArea {
			id: gameArea
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: statusBar.top
			clip: true
			bgtype: "image"
			bgvalue: "http://lh6.ggpht.com/ZCOlB4IXq3Ocx8IhUrAtBUxhq26flOKbMsy8KU9mjPPh-Mf7s1yEIjTJ3DQioqOnbrU=h900"
			scene: Item {
				id: gameContent
				// Umieścić tutaj box z grą
			}
		}

//		Image {
//			anchors.top: parent.top
//			anchors.left: parent.left
//			anchors.right: parent.right
//			anchors.bottom: statusBar.top
//			//color: 'grey'
//			source: "http://lh6.ggpht.com/ZCOlB4IXq3Ocx8IhUrAtBUxhq26flOKbMsy8KU9mjPPh-Mf7s1yEIjTJ3DQioqOnbrU=h900"
//			clip: true
//		}



		Row {
			id: statusBar
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.rightMargin: 10

			spacing: 20

			height: childrenRect.height

			Item {
				width: childrenRect.width
				height: childrenRect.height
				GameStatusBar {

					model: ListModel {
						id: modello
					}
					Component.onCompleted: modello.append({icon: "http://icons.iconarchive.com/icons/custom-icon-design/pretty-office-11/256/coin-us-dollar-icon.png",
															  name: "Points: ",
															  value: points});
				}
			}
		}
	}
	World {
		id: gameWorld
		gravity: Qt.point(0, -4.5)
	}


	Balloons.Balloon {
		id: balloon
		objectName: "balloon"
		gameWorld: gameWorld
		points: 50
		Component.onCompleted: setXY(100, 600)
	}
	WorldObjects.GameWall {
		id: wallBottom
		y: parent.height
		x: 0
		width: parent.width
		gameWorld: gameWorld
	}
	WorldObjects.GameWall {
		id: wallUp
		y: -height
		x: 0
		width: parent.width
		gameWorld: gameWorld
	}
	WorldObjects.GameWall {
		id: wallLeft
		y: 0
		x: -width
		width: parent.width/2
		height: parent.height * 2
		gameWorld: gameWorld
	}
	WorldObjects.GameWall {
		id: wallRight
		y: 0
		x: parent.width
		width: parent.width/2
		height: parent.height * 2
		gameWorld: gameWorld
	}
}
