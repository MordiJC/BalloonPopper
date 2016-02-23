import QtQuick 2.3
import QtQuick.Window 2.2

Window {
	visible: true
	id: mainWindow

	signal loadPage(string pagePath)
    onLoadPage: {
        console.log("setting page: ", pagePath)
        mainLoader.setSource(pagePath, {})
    }

	width: 300; height: 400

	Loader {
		anchors.fill: parent
		id: mainLoader
		source: "view/MainMenu.qml"
	}
}
