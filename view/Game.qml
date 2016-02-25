import QtQuick 2.5
import QtQuick.Layouts 1.1

import Box2D 2.0

import "../ballons" as Ballons
import "../worldObjects" as WorldObjects

Item {
	id: game
	anchors.fill: parent

	property int points: 30
	onPointsChanged: console.log("points: ", points)

	property Body pressedBody: null

	Component.onCompleted: {}

	Timer {
		id: timerBallonSpawner
		running: false
		interval: 300
		onTriggered: {

		}
	}

	ColumnLayout {
		anchors.fill: parent

		Image {
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: statusBar.top
			//color: 'grey'
			source: "http://lh6.ggpht.com/ZCOlB4IXq3Ocx8IhUrAtBUxhq26flOKbMsy8KU9mjPPh-Mf7s1yEIjTJ3DQioqOnbrU=h900"
			clip: true
		}

		Row {
			id: statusBar
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.rightMargin: 10

			spacing: 20

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

	World {
		id: gameWorld
		gravity: Qt.point(0, -6.81)
	}
	Ballons.Ballon {
		id: ballon
		objectName: "ballon"
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
