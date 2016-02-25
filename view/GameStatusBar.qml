import QtQuick 2.0

Item {
	id: statusBar
	anchors.left: parent.left
	anchors.right: parent.right
	height: 24

	property alias model: itemsModel.model

	// Status bar item component
	Component {
		id: statusBarItem

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
		}
	}

	// Status bar layout
	Flow {
		id: layoutContainer
		anchors.fill: parent
		visible: true
		Repeater {
			id: itemsModel
			delegate: statusBarItem
			model: undefined
		}
	}
}
