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
		if(it) {
			statusBar.items.itemsModel.model = it;
			statusBar.items.visible = true;
		} else {
			statusBar.items.visible = false;
		}
	}

	Flow {
		id: items
		anchors.fill: parent
		visible: false
		Repeater {
			id: itemsModel
			anchors.fill: parent

			Item {
				anchors.fill: childrenRect
				width: childrenRect.width
				height: childrenRect.height
			}
		}
	}
}
