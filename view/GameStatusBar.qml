import QtQuick 2.0

Item {
	id: statusBar
	anchors.fill: parent

	property alias model: itemsModel.model

//	onModelChanged: {
//		if(model)
//			statusBar.items.visible = true;
//		else
//			statusBar.items.visible = false;
//	}
	// działa tak samo a mniej o 5 lini kodu
	// jesli sie cos da w skroconym ifie zrobic to trzeba zrobic :)
	onModelChanged: model ? statusBar.items.visible = true : statusBar.items.visible = false

	// Status bar item component
	Component {
		id: statusBarItem

		Item {
			id: statusBarItemRoot

			anchors.fill: childrenRect

			Image {
				id: iconImage
				source: icon
				height: 32
				width: 32
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
	}

	// Status bar layout
	Flow {
		id: layoutContainer
		anchors.fill: parent
		visible: false
		Repeater {
			id: itemsModel
			delegate: statusBarItem
		}
	}
}
