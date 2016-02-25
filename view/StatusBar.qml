import QtQuick 2.0

Item {
	id: statusBar
	anchors.fill: parent

	property alias model: items.itemsModel.model

	onModelChanged: {
		if(model)
			statusBar.items.visible = true;
		else
			statusBar.items.visible = false;
	}

	signal setModel(var it);

	onSetModel: {
		if(it && it instanceof ListModel) {
			statusBar.items.itemsModel.model = it;
			statusBar.items.visible = true;
		} else {
			statusBar.items.visible = false;
		}
	}

	// Status bar item component
	Component {
		id: statusBarItem

		QtObject {
			id: internalData
		}

		Item {
			id: statusBarItemRoot

			anchors.fill: childrenRect

			Image {
				id: iconImage
				source: icon
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
		id: items
		anchors.fill: parent
		visible: false
		Repeater {
			id: itemsModel
			delegate: statusBarItem
		}
	}
}
