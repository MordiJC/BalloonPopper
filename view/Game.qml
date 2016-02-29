import QtQuick 2.5
import QtQuick.Layouts 1.1

import Box2D 2.0

import "../balloons" as Balloons
import "../gameObjects" as WorldObjects

import "../scripts/utility.js" as Utility

/**
 * Game.qml - Plik z głównymi danymi gry.
 */

Item {
	id: game
	anchors.fill: parent

	property int points: 30
	onPointsChanged: console.log("points: ", points)

	property Body pressedBody: null

	// Zmienna odpowiadajaca za stan gry. (Działa, czy nie działa, o to jest pytanie...)
	property bool gameRunning: false

	Component.onCompleted: {}

	ColumnLayout {
		anchors.fill: parent

		Row {
			id: statusBar
			anchors {
				top: parent.top
				left: parent.left
				right: parent.right
				topMargin: 3
				bottomMargin: 3
				leftMargin: 3
				rightMargin: 10
			}
			spacing: 20
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

		GameArea {
			id: gameArea
			anchors {
				top: statusBar.bottom
				left: parent.left
				right: parent.right
				bottom: parent.bottom
			}
			bgtype: "image"
			bgvalue: "http://lh6.ggpht.com/ZCOlB4IXq3Ocx8IhUrAtBUxhq26flOKbMsy8KU9mjPPh-Mf7s1yEIjTJ3DQioqOnbrU=h900"
			sceneComponent: Item {
				id: gameContent
				// Umieścić tutaj box z grą
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
