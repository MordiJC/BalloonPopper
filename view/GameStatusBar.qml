import QtQuick 2.0

/**
 * GameStatusBar.qml - Plik ten zawiera obiekt z status barem gry.
 * W tym kontenerze można osadzać Informacje w formacie {icon, name, value}.
 */

Item {
	id: statusBar

	property alias model: itemsModel.model

	signal updateStatusBarValue(string name, int value)
	onUpdateStatusBarValue: {
		for (var i=0 ; i<model.count ; i++) {
			if (model.get(i).name === name) {
				model.get(i).value = value
			}
		}
	}

	// Status bar item component
	Component {
		id: statusBarComponent

		Item {
			id: statusBarItemRoot

			width: childrenRect.width
			height: childrenRect.height

			Row {
				spacing: 4
				Image {
					id: iconImage
					source: icon
					height: 24
					width: 24
				}

				Text {
					id: nameText
					text: name
					font.pointSize: 14
				}

				Text {
					id: valueText
					text: value
					font.pointSize: 14
				}
			}
		} // Item: statusBarItemRoot
	} // Component: statusBarComponent

	// Status bar layout
	Flow {
		id: layoutContainer
		anchors.fill: parent
		visible: true
		Repeater {
			id: itemsModel
			delegate: statusBarComponent
			model: undefined
		}
	} // Flow: layoutContainer
} // Item: statusBar
