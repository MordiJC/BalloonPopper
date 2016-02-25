import QtQuick 2.5
import QtQuick.Layouts 1.1

import Box2D 2.0

import "../ballons" as Ballons
import "../worldObjects" as WorldObjects

/** Koncept

Item {
	id: gameLayout
	anchors.fill: parent

	property var gameComponent: undefined
	property var statusBarComponents: []

	property alias gameArea: layoutContainer.gameArea

	Item {
		id: layoutContainer
		anchors.fill: parent

		Rectangle {
			id: gameArea
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: statusBar.top
		}

		Row {
			id: statusBar
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.rightMargin: 10

			// Dodać wyliczanie i wewntualne zawijanie (gdy za dużo elementów) lub dodawanie nowego wiersza
			spacing: 30

			height: statusBar.childrenRect.height
		}
	}
}
*/

// Old

Item {
	id: game
	anchors.fill: parent

	property int points: 0

	property Body pressedBody: null

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
					ListElement {
						icon: "http://icons.iconarchive.com/icons/custom-icon-design/pretty-office-11/256/coin-us-dollar-icon.png"
						name: "Points: "
						value: 0
					}
				}
			}

			/*Column {
				id: pointsContainer
				Row {
					Text {
						id: pointsLabel
						text: qsTr("Points: ")
						font.pointSize: 14
					}

					Text {
						id: pointsCounter
						text: game.points
						font.pointSize: 14
					}
				}
			}*/
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
