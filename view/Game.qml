import QtQuick 2.0
import QtQuick.Layouts 1.1

import Box2D 2.0

import "../ballons" as Ballons

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
    Rectangle {
        id: wall
        x: 0
        y: 300
        color: "black"
        width: parent.width
        height: 50
        Body {
            id: wallBody
            target: wall
            Box {
                id: wallBox
                width: wall.width
                height: wall.height
            }
        }
    }
}
