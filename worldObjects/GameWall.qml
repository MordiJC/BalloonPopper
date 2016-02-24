import QtQuick 2.0
import Box2D 2.0

Item {
    id: root
    width: 100
    height: 50
    property color wallColor: "red"
    property int wallRadius: 0
    property bool wallImageSourceCenterIn: true

    Rectangle {
        id: wall
        x: parent.x
        y: parent.y
        width: parent.width
        height: parent.height
        color: "black"
        radius: parent.wallRadius

        Body {
            id: wallBody
            target: wall
            Box {
                id: wallBox
                width: wall.width
                height: wall.height
                onBeginContact: console.log("Wall", wallBox, "colides with: ", wallBox.collidesWith)
            }
        }
    }
}
