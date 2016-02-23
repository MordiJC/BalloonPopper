import QtQuick 2.3
import QtQuick.Window 2.2

Window {
	visible: true
	id: mainWindow

	property var cMainMenuComponent: Qt.createComponent("MainMenu.qml");
	property var iMainMenuItem: undefined

	Loader {
		id: mainLoader
	}

	MouseArea {
		anchors.fill: parent
		onClicked: {
			iMainMenuItem = iMainMenuItem ? iMainMenuItem : cMainMenuComponent.createObject(mainWindow);
			mainLoader.data = [iMainMenuItem];
		}
	}
}
