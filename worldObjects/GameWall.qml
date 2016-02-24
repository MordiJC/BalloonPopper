import QtQuick 2.0
import Box2D 2.0

Rectangle {
    id: wall
    objectName: "wall"
    color: "red"
    width: 100
    height: 50
    property string wallImageSource
    property bool wallImageSourceCenterIn: true

    property World gameWorld: undefined

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
        world: gameWorld
        Box {
            id: wallBox
            objectName: wall.objectName
            width: wall.width
            height: wall.height
            onBeginContact: console.log(objectName, "colides with: ", other.objectName)
        }
    }
}
