import QtQuick 2.0
import Box2D 2.0

import "balloons" as Balloons

/**
 * GameWorld.qml - Plik zawiera "Świat Gry", który zawiera
 * wszystkie elementy rozgrywki.
 */

Item {
    id: rootGameWorld
    anchors.fill: parent

    World {
        id: gameWorld
		gravity: Qt.point(0, 1)
    }

	Balloons.Balloon {
		id: balloon
        x: 100
        y: 100
        gameWorld: gameWorld
    }
}

