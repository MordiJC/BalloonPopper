import QtQuick 2.0
import Box2D 2.0

Rectangle {
    id: root
    property World gameWorld: undefined

    function setXY(x,y) {
        root.x = x
        root.y = y
    }

    width: 100
    height: 50
    color: "black"
    smooth: true

    Body {
        id: rootBody

        world: gameWorld
        target: root
        bodyType: Body.Dynamic

        Box {
            id: box
            width: root.width
            height: root.height
            density: 0.5
            restitution: 0.5
            friction: 0.5
        }
    }
}

