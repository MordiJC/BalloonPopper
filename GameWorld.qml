import QtQuick 2.0
import "ballons" as Ballons
import Box2D 2.0

Item {
    id: rootGameWorld
    anchors.fill: parent

    World {
        id: gameWorld

    }
    Ballons.Ballon {
        id: ballon
        x: 100
        y: 100
        gameWorld: gameWorld
    }
}

