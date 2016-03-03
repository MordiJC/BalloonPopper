import QtQuick 2.0
import Box2D 2.0

Rectangle {
    id: wall
	objectName: "wall"
    property string wallImageSource
	property bool wallImageSourceCenterIn: true

	property alias world: wallBody.world

    Image {
        id: wallImage
        anchors.centerIn: wallImageSourceCenterIn ? parent : 0
        source: parent.parent.wallImageSource !== undefined ? wallImageSource : ""
        anchors.fill: !wallImageSourceCenterIn ? parent : undefined
        visible: wallImageSource != undefined ? true : false
	}

    Body {
        id: wallBody
		target: wall
        Box {
            id: wallBox
            objectName: wall.objectName
            width: wall.width
            height: wall.height
			//onBeginContact: console.log(objectName, "colides with: ", other.objectName)
        }
    }
}
