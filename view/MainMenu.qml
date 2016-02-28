import QtQuick 2.0
import QtQuick.Layouts 1.1

/**
 * MainMenu.qml - Plik zawierający główne menu gry.
 */

Item {
	id: menuRoot
	anchors.fill: parent

	Column {
		anchors.centerIn: parent
		spacing: 25

		// Tekst na górze menu
		Row {
			spacing: 10
			Text {
				id: balloonLabel
				text: "Balloon"
				rotation: -10
				font.pointSize: 22
				font.family: "Forte"
			}

			Text {
				id: popperLabel
				text: "Popper"
				rotation: 10
				font.pointSize: 22
				font.family: "Forte"
			}
		} // Row

		// Przycisk "New Game"
		Rectangle {
			id: newGameButton
			anchors.horizontalCenter: parent.horizontalCenter

			color: 'red'
			border.color: 'black'
			border.width: 4
			radius: 5
			height: newGameLabel.height + border.width*4
			width: 160

			Text {
				id: newGameLabel
				text: qsTr("New Game")

				anchors.centerIn: parent

				font.pointSize: 14
				font.family: 'Tahoma'
				color: 'white'
			}

			MouseArea {
				id: newGameMouseArea
                anchors.fill: parent
                onClicked: mainWindow.loadPage("view/Game.qml", {})
			}
		} // Rectangle: newGameButton

		// Przycisk "High Scores"
		Rectangle {
			id: highScoresButton
			anchors.horizontalCenter: parent.horizontalCenter
			color: 'lightblue'
			border.color: 'black'
			border.width: 4
			radius: 5
			height: highScoresLabel.height + border.width*4
			width: 160

			Text {
				id: highScoresLabel
				text: qsTr("High Scores")

				anchors.centerIn: parent

				font.pointSize: 14
				font.family: 'Tahoma'
				color: 'white'
			}
		} // Rectangle: highScoresButton
	} // Column
} // Item: menuRoot
