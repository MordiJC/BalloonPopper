import QtQuick 2.3
import QtQuick.Window 2.2

Window {
	visible: true
	id: mainWindow

    signal loadPage(string pagePath, var args)
    onLoadPage: {
        console.log("setting page: ", pagePath, args)
        mainLoader.setSource(pagePath, args)
    }

    width: 450; height: 800

	Loader {
		anchors.fill: parent
		id: mainLoader
		source: "view/MainMenu.qml"
	}
}
