import QtQuick 2.0
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

	ColumnLayout {
		anchors.fill: parent

		Rectangle {
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: statusBar.top
			color: 'purple'
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

			Column {
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
			}
		}
	}

	World {
		id: gameWorld
	}
	Ballons.Ballon {
		id: ballon
		x: 100
		y: 100
        gameWorld: gameWorld
	}
    WorldObjects.GameWall {
        id: wallBottom
        x: 0
        y: 500
        width: parent.width
        wallColor: "black"
    }
}
