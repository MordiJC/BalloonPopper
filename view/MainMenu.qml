import QtQuick 2.0
import QtQuick.Layouts 1.1

Item {
	// Component
	id: menuRoot

	anchors.fill: parent

	RowLayout {
		id: menuLayout
		anchors.fill: parent

		Rectangle {
			id: newGameButton
			anchors.horizontalCenter: parent.horizontalCenter

			color: 'lightgrey'
			border.color: 'black'
			border.width: 4
			radius: 5

			Text {
				id: newGameLabel
				text: qsTr("New Game")

				font.pointSize: 14
				font.family: 'Tahoma'
			}
		}

		Rectangle {
			id: highScoresButton
			anchors.horizontalCenter: parent.horizontalCenter

			color: 'lightgrey'
			border.color: 'black'
			border.width: 4
			radius: 5

			Text {
				id: highScoresLabel
				text: qsTr("High Scores")

				font.pointSize: 14
				font.family: 'Tahoma'
			}
		}
	}
}
