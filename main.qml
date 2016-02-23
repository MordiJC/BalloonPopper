import QtQuick 2.3
import QtQuick.Window 2.2

Window {
	visible: true
	id: mainWindow

	width: 300; height: 400

	Loader {
		anchors.fill: parent
		id: mainLoader
	}

	onVisibilityChanged: {
		if(visibility) {
			mainLoader.setSource("view/MainMenu.qml");
		}
	}
}
